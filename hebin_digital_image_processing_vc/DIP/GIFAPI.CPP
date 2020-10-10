// ************************************************************************
//  �ļ�����GIFAPI.cpp
//
//  GIF(Graphics Interchange Format) API�����⣺
//
//  DIBToGIF()          - ��ָ����DIB����< 256ɫ������ΪGIF�ļ�
//  EncodeGIF_LZW()		- ��ָ��ͼ�����GIF_LZW����
//  GIF_LZW_WriteCode() - ���һ������
//  ReadGIF()           - ��ȡGIF�ļ�
//  DecodeGIF_LZW()     - ��GIF_LZW���������н���
//  ReadSrcData()       - ��ȡGIF_LZW����
//
// ************************************************************************

#include "stdafx.h"
#include "DIBAPI.h"
#include "GIFAPI.h"

#include <io.h>
#include <errno.h>

#include <math.h>
#include <direct.h>

/*************************************************************************
 *
 * �������ƣ�
 *   DIBToGIF()
 *
 * ����:
 *   LPSTR lpDIB        - ָ��DIB�����ָ��
 *   CFile& file        - Ҫ������ļ�
 *   BOOL	bInterlace	- �Ƿ��ս�����ʽ����
 *
 * ����ֵ:
 *   BOOL               - �ɹ�����True�����򷵻�False��
 *
 * ˵��:
 *   �ú�����ָ����DIB����< 256ɫ������ΪGIF�ļ���
 *
 *************************************************************************/
BOOL WINAPI DIBToGIF(LPSTR lpDIB, CFile& file, BOOL bInterlace)
{
	// ѭ������
	WORD	i;
	WORD	j;
	
	// DIB�߶�
	WORD	wHeight;
	
	// DIB����
	WORD	wWidth;
	
	// ָ��DIB����ָ��
	LPSTR   lpDIBBits;
	
	// GIF�ļ�ͷ
	GIFHEADER          GIFH;
	
	// GIF�߼���Ļ������
	GIFSCRDESC         GIFS;
	
	// GIFͼ��������
	GIFIMAGE           GIFI;
	
	// GIF�������
	GIFC_VAR           GIFCVar;
	
	// ��ɫ��Ŀ
	WORD               wColors;
	
	// ÿ���ֽ���
	WORD               wWidthBytes;
	
	// ��ɫ��
	BYTE               byGIF_Pal[768];
	
	// �ֽڱ���
	BYTE               byChar;
	
	// ָ��BITMAPINFO�ṹ��ָ�루Win3.0��
	LPBITMAPINFO	   lpbmi;
	
	// ָ��BITMAPCOREINFO�ṹ��ָ��
	LPBITMAPCOREINFO   lpbmc;
	
	// �����Ƿ���Win3.0 DIB�ı��
	BOOL			   bWinStyleDIB;
	
	// ��ȡDIB�߶�
	wHeight = (WORD) DIBHeight(lpDIB);
	
	// ��ȡDIB����
	wWidth  = (WORD) DIBWidth(lpDIB);
	
	// �ҵ�DIBͼ��������ʼλ��
	lpDIBBits = FindDIBBits(lpDIB);
	
	// ��GIFCVar�ṹ��ֵ
	GIFCVar.wWidth     = wWidth;
	GIFCVar.wDepth     = wHeight;
	GIFCVar.wBits      = DIBBitCount(lpDIB);
	GIFCVar.wLineBytes = (WORD)BYTE_WBYTES((DWORD)GIFCVar.wWidth *
										   (DWORD)GIFCVar.wBits);
	
	// ����ÿ���ֽ���
	wWidthBytes = (WORD)DWORD_WBYTES(wWidth * (DWORD)GIFCVar.wBits);
	
	// ������ɫ��Ŀ
	wColors     = 1 << GIFCVar.wBits;
	
	// ��ȡָ��BITMAPINFO�ṹ��ָ�루Win3.0��
	lpbmi = (LPBITMAPINFO)lpDIB;
	
	// ��ȡָ��BITMAPCOREINFO�ṹ��ָ��
	lpbmc = (LPBITMAPCOREINFO)lpDIB;
	
	// �ж��Ƿ���WIN3.0��DIB
	bWinStyleDIB = IS_WIN30_DIB(lpDIB);
	
	// ����ɫ�帳ֵ
	if (bWinStyleDIB)
	{
		j = 0;
		for (i = 0; i < wColors; i++)
		{
			// ��ȡ��ɫ����
			byGIF_Pal[j++] = lpbmi->bmiColors[i].rgbRed;
			
			// ��ȡ��ɫ����
			byGIF_Pal[j++] = lpbmi->bmiColors[i].rgbGreen;
			
			// ��ȡ��ɫ����
			byGIF_Pal[j++] = lpbmi->bmiColors[i].rgbBlue;
		}
	}
	else
	{
		j = 0;
		for (i = 0; i < wColors; i++)
		{
			// ��ȡ��ɫ����
			byGIF_Pal[j++] = lpbmc->bmciColors[i].rgbtRed;
			
			// ��ȡ��ɫ����
			byGIF_Pal[j++] = lpbmc->bmciColors[i].rgbtGreen;
			
			// ��ȡ��ɫ����
			byGIF_Pal[j++] = lpbmc->bmciColors[i].rgbtBlue;
		}
	}
	
	////////////////////////////////////////////////////////////////////////////////////////
	// ��ʼдGIF�ļ�
	
	// дGIF�ļ�ͷ
	GIFH.bySignature[0] = 'G';
	GIFH.bySignature[1] = 'I';
	GIFH.bySignature[2] = 'F';
	GIFH.byVersion[0]='8';
	GIFH.byVersion[1]='9';
	GIFH.byVersion[2]='a';
	file.Write((LPSTR)&GIFH, 6);
	
	// дGIF�߼���Ļ������
	GIFS.wWidth               = GIFCVar.wWidth;
	GIFS.wDepth               = GIFCVar.wDepth;
	GIFS.GlobalFlag.PalBits   = (BYTE)(GIFCVar.wBits - 1);
	GIFS.GlobalFlag.SortFlag  = 0x00;
	GIFS.GlobalFlag.ColorRes  = (BYTE)(GIFCVar.wBits - 1);
	GIFS.GlobalFlag.GlobalPal = 0x01;
	GIFS.byBackground         = 0x00;
	GIFS.byAspect             = 0x00;
	file.Write((LPSTR)&GIFS, 7);
	
	// дGIFȫ�ֵ�ɫ��
	file.Write((LPSTR)byGIF_Pal,(wColors*3));
	
	// дGIFͼ�����������
	byChar      = 0x2C;
	file.Write((LPSTR)&byChar,1);
	
	// дGIFͼ��������
	GIFI.wLeft                = 0;
	GIFI.wTop                 = 0;
	GIFI.wWidth               = GIFCVar.wWidth;
	GIFI.wDepth               = GIFCVar.wDepth;
	GIFI.LocalFlag.PalBits    = 0x00;
	GIFI.LocalFlag.Reserved   = 0x00;
	GIFI.LocalFlag.SortFlag   = 0x00;
	GIFI.LocalFlag.Interlace  = (BYTE)(bInterlace ? 0x01 : 0x00);
	GIFI.LocalFlag.LocalPal   = 0x00;
	file.Write((LPSTR)&GIFI, 9);
	
	// дGIFͼ��ѹ������
	HANDLE hSrcBuff = GlobalAlloc(GHND,(DWORD)MAX_BUFF_SIZE);
	GIFCVar.lpDataBuff = (LPSTR)GlobalLock(hSrcBuff);
	GIFCVar.lpEndBuff  = GIFCVar.lpDataBuff;
	GIFCVar.dwTempCode = 0UL;
	GIFCVar.wByteCnt   = 0;
	GIFCVar.wBlockNdx  = 1;
	GIFCVar.byLeftBits = 0x00;
	
	// ����GIF_LZW����
	EncodeGIF_LZW(lpDIBBits, file, &GIFCVar,wWidthBytes, bInterlace);
	
	// �ж��Ƿ����ɹ�
	if (GIFCVar.wByteCnt)
	{
		// д���ļ�
		file.Write(GIFCVar.lpDataBuff, GIFCVar.wByteCnt);
	}
	
	// �ͷ��ڴ�
	GlobalUnlock(hSrcBuff);
	GlobalFree(hSrcBuff);
	
	// дGIF Block Terminator
	byChar   = 0x00;
	file.Write((LPSTR)&byChar,1);
	
	// дGIF�ļ���β��
	byChar   = 0x3B;
	file.Write((LPSTR)&byChar,1);
	
	// ����
	return TRUE;
}

/*************************************************************************
 *
 * �������ƣ�
 *   EncodeGIF_LZW()
 *
 * ����:
 *   LPSTR lpDIBBits		- ָ��ԴDIBͼ��ָ��
 *   CFile& file			- Ҫ������ļ�
 *   LPGIFC_VAR lpGIFCVar	- ָ��GIFC_VAR�ṹ��ָ��
 *	 WORD wWidthBytes		- ÿ��ͼ���ֽ���
 *	 BOOL bInterlace		- �Ƿ��ս�����ʽ����
 *
 * ����ֵ:
 *   ��
 *
 * ˵��:
 *   �ú�����ָ��ͼ�����GIF_LZW���롣
 *
 *************************************************************************/
void WINAPI EncodeGIF_LZW(LPSTR lpDIBBits, CFile& file, 
						  LPGIFC_VAR lpGIFCVar,WORD wWidthBytes, BOOL bInterlace)
{
	// �ڴ������
	HANDLE hTableNdx;
	HANDLE hPrefix;
	HANDLE hSuffix;
	
	// ָ���ִ���ָ��
	LPWORD lpwTableNdx;
	
	// �����ִ�������������
	LPWORD lpwPrefix;
	LPBYTE lpbySuffix;
	
	// ָ��ǰ�������ص�ָ��
	LPSTR  lpImage;
	
	// ���㵱ǰ����ͼ���ƫ����
	DWORD  dwDataNdx;
	
	// LZW_CLEAR
	WORD   wLZW_CLEAR;
	
	// LZW_EOI
	WORD   wLZW_EOI;
	
	// LZW_MinCodeLen
	BYTE   byLZW_MinCodeLen;
	
	// �ִ�������
	WORD   wPreTableNdx;
	WORD   wNowTableNdx;
	WORD   wTopTableNdx;
	
	// ��ϣ������
	WORD   wHashNdx;
	WORD   wHashGap;
	WORD   wPrefix;
	WORD   wShiftBits;
	
	// ��ǰͼ�������
	WORD   wRowNum;
	
	WORD   wWidthCnt;
	
	// ѭ������
	WORD   wi;
	WORD   wj;
	
	// ������ʽ�洢ʱÿ�����ӵ�����
	WORD   wIncTable[5]  = { 8,8,4,2,0 }; 
	
	// ������ʽ�洢ʱ��ʼ����
	WORD   wBgnTable[5]  = { 0,4,2,1,0 }; 
	
	BOOL   bStart;
	BYTE   bySuffix;
	BYTE   bySubBlock[256];
	BYTE   byCurrentBits;
	BYTE   byMask;
	BYTE   byChar;
	BYTE   byPass;
	
	// ��ʱ�ֽڱ���
	BYTE   byTemp;
	
	// ���ִ��������ڴ�
	hTableNdx        = GlobalAlloc(GHND,(DWORD)(MAX_HASH_SIZE<<1));
	hPrefix          = GlobalAlloc(GHND,(DWORD)(MAX_HASH_SIZE<<1));
	hSuffix          = GlobalAlloc(GHND,(DWORD)MAX_HASH_SIZE);
	
	// �����ڴ�
	lpwTableNdx      = (LPWORD)GlobalLock(hTableNdx);
	lpwPrefix        = (LPWORD)GlobalLock(hPrefix);
	lpbySuffix       = (LPBYTE)GlobalLock(hSuffix);
	
	// ����LZW_MinCodeLen
	byLZW_MinCodeLen = (BYTE)((lpGIFCVar->wBits>1) ? lpGIFCVar->wBits : 0x02);
	
	// дGIF LZW��С�����С
	file.Write((LPSTR)&byLZW_MinCodeLen,1);
	
	wRowNum          = 0;
	bStart           = TRUE;
	byPass           = 0x00;
	
	// ����LZW_CLEAR
	wLZW_CLEAR       = 1 << byLZW_MinCodeLen;
	
	// ����LZW_EOI
	wLZW_EOI         = wLZW_CLEAR + 1;
	
	// ��ʼ���ִ���
	byCurrentBits    = byLZW_MinCodeLen + (BYTE)0x01;
	wNowTableNdx     = wLZW_CLEAR + 2;
	wTopTableNdx     = 1 << byCurrentBits;
	for(wi=0; wi<MAX_HASH_SIZE; wi++)
	{
		// ��ʼ��Ϊ0xFFFF
		*(lpwTableNdx+wi) = 0xFFFF;
	}
	
	// ���LZW_CLEAR
	GIF_LZW_WriteCode(file, wLZW_CLEAR, (LPSTR)bySubBlock,
					  &byCurrentBits, lpGIFCVar);
	
	// ���б���
	for(wi=0; wi<lpGIFCVar->wDepth; wi++)
	{
		// ���㵱ǰƫ����
		dwDataNdx  = (DWORD)(lpGIFCVar->wDepth - 1 - wRowNum) * (DWORD)wWidthBytes;
		
		// ָ��ǰ��ͼ���ָ��
		lpImage    = (LPSTR) (((BYTE*)lpDIBBits) + dwDataNdx);
		
		wWidthCnt  = 0;
		wShiftBits = 8 - lpGIFCVar->wBits;
		byMask     = (BYTE)((lpGIFCVar->wBits==1) ? 0x80 : 0xF0);
		
		if (bStart)
		{
			// �ж��Ƿ���256ɫλͼ��һ������һ�ֽڣ�
			if (lpGIFCVar->wBits==8)
			{
				// 256ɫ��ֱ�Ӹ�ֵ����
				byTemp      = *lpImage++;
			}
			else
			{
				// ��256ɫ����Ҫ��λ��ȡ����ֵ
				wShiftBits  = 8 - lpGIFCVar->wBits;
				byMask      = (BYTE)((lpGIFCVar->wBits==1) ? 0x80 : 0xF0);
				byTemp      = (BYTE)((*lpImage & byMask) >> wShiftBits);
				byMask    >>= lpGIFCVar->wBits;
				wShiftBits -= lpGIFCVar->wBits;
			}
			wPrefix    = (WORD)byTemp;
			bStart     = FALSE;
			wWidthCnt ++;
		}
		
		// ÿ�б���
		while(wWidthCnt < lpGIFCVar->wWidth)
		{
			// �ж��Ƿ���256ɫλͼ��һ������һ�ֽڣ�
			if (lpGIFCVar->wBits==8)
			{
				// 256ɫ��ֱ�Ӹ�ֵ����
				byTemp = *lpImage++;
			}
			else
			{
				// ��256ɫ����Ҫ��λ��ȡ����ֵ
				byChar = *lpImage;
				byTemp = (BYTE)((byChar & byMask) >> wShiftBits);
				if (wShiftBits)
				{
					byMask    >>= lpGIFCVar->wBits;
					wShiftBits -= lpGIFCVar->wBits;
				}
				else
				{
					wShiftBits  = 8 - lpGIFCVar->wBits;
					byMask      = (BYTE)((lpGIFCVar->wBits==1) ? 0x80 : 0xF0);
					lpImage    ++;
				}
			}
			bySuffix   = byTemp;
			wWidthCnt ++;
			
			// ���ҵ�ǰ�ַ����Ƿ�������ִ�����
			wHashNdx = wPrefix ^ ((WORD)bySuffix << 4);
			wHashGap = (wHashNdx ? (MAX_HASH_SIZE - wHashNdx) : 1);
			
			// �жϵ�ǰ�ַ����Ƿ����ִ�����
			while(TRUE)
			{
				// ��ǰ�ַ��������ִ�����
				if (*(lpwTableNdx + wHashNdx) == 0xFFFF)
				{
				   // ���ַ������˳�ѭ��
				   break;
				}
				
				// �ж��Ƿ��ҵ����ַ���
				if ((*(lpwPrefix+wHashNdx)  == wPrefix) &&
					(*(lpbySuffix+wHashNdx) == bySuffix))
				{
					// �ҵ����˳�ѭ��
					break;
				}
				
				// �ڶ���ϣ��
				if (wHashNdx < wHashGap)
				{
					wHashNdx += MAX_HASH_SIZE;
				}
				wHashNdx -= wHashGap;
			}
			
			// �ж��Ƿ������ַ���
			if (*(lpwTableNdx+wHashNdx) != 0xFFFF)
			{
				// �������ַ���
				wPrefix = *(lpwTableNdx + wHashNdx);
			 }
			 else
			 {
				// ���ַ���
				
				// ����ñ���
				GIF_LZW_WriteCode(file,wPrefix,(LPSTR)bySubBlock,
								   &byCurrentBits,lpGIFCVar);
				
				// �������ַ������ӵ��ִ�����
				wPreTableNdx = wNowTableNdx;
				
				// �ж��Ƿ�ﵽ����ִ�����С
				if (wNowTableNdx < MAX_TABLE_SIZE)
				{
					*(lpwTableNdx+wHashNdx) = wNowTableNdx++;
					*(lpwPrefix+wHashNdx)   = wPrefix;
					*(lpbySuffix+wHashNdx)  = bySuffix;
				}
				
				if (wPreTableNdx == wTopTableNdx)
				{
					if (byCurrentBits<12)
					{
						byCurrentBits ++;
						wTopTableNdx <<= 1;
					}
					else
					{
						// �ִ���������󳤶�
						
						// ���LZW_CLEAR
						GIF_LZW_WriteCode(file, wLZW_CLEAR, (LPSTR)bySubBlock,
										 &byCurrentBits,lpGIFCVar);
						
						// ���³�ʼ���ִ���
						byCurrentBits    = byLZW_MinCodeLen + (BYTE)0x01;
						wLZW_CLEAR       = 1 << byLZW_MinCodeLen;
						wLZW_EOI         = wLZW_CLEAR + 1;
						wNowTableNdx     = wLZW_CLEAR + 2;
						wTopTableNdx     = 1 << byCurrentBits;
						for(wj=0;wj<MAX_HASH_SIZE;wj++)
						{
							// ��ʼ��Ϊ0xFFFF
							*(lpwTableNdx+wj) = 0xFFFF;
						}
					}
				}
				wPrefix = (WORD)bySuffix;
			}
		}
		
		// �ж��Ƿ��ǽ�����ʽ
		if (bInterlace)
		{
			// ������ʽ��������һ��λ��
			wRowNum += wIncTable[byPass];
			if (wRowNum>=lpGIFCVar->wDepth)
			{
				byPass ++;
				wRowNum = wBgnTable[byPass];
			}
		}
		else
		{
			// �ǽ�����ʽ��ֱ�ӽ�������һ����
			wRowNum ++;
		}
	}
	
	// �����ǰ����
	GIF_LZW_WriteCode(file, wPrefix, (LPSTR)bySubBlock,
					  &byCurrentBits,lpGIFCVar);
	
	// ���LZW_EOI
	GIF_LZW_WriteCode(file,wLZW_EOI,(LPSTR)bySubBlock,
					  &byCurrentBits,lpGIFCVar);
	
	if (lpGIFCVar->byLeftBits)
	{
		// ������ַ�
		bySubBlock[lpGIFCVar->wBlockNdx++] = (BYTE)lpGIFCVar->dwTempCode;
		
		// �ж��Ƿ񳬳�MAX_SUBBLOCK_SIZE
		if (lpGIFCVar->wBlockNdx > MAX_SUBBLOCK_SIZE)
		{
			// �ж�wByteCnt + 256�Ƿ񳬹�MAX_BUFF_SIZE
			if ((lpGIFCVar->wByteCnt + 256) >= MAX_BUFF_SIZE)
			{
				// ���
				file.Write(lpGIFCVar->lpDataBuff,
							  lpGIFCVar->wByteCnt);
				lpGIFCVar->lpEndBuff = lpGIFCVar->lpDataBuff;
				lpGIFCVar->wByteCnt  = 0;
			}
			bySubBlock[0]           = (BYTE)(lpGIFCVar->wBlockNdx - 1);
			memcpy(lpGIFCVar->lpEndBuff,(LPSTR)bySubBlock,lpGIFCVar->wBlockNdx);
			lpGIFCVar->lpEndBuff   += lpGIFCVar->wBlockNdx;
			lpGIFCVar->wByteCnt    += lpGIFCVar->wBlockNdx;
			lpGIFCVar->wBlockNdx    = 1;
		}
		lpGIFCVar->dwTempCode = 0UL;
		lpGIFCVar->byLeftBits = 0x00;
	}
	
	if (lpGIFCVar->wBlockNdx > 1)
	{
		// �ж�wByteCnt + 256�Ƿ񳬹�MAX_BUFF_SIZE
		if ((lpGIFCVar->wByteCnt + 256) >= MAX_BUFF_SIZE)
		{
			// ���
			file.Write(lpGIFCVar->lpDataBuff,
						   lpGIFCVar->wByteCnt);
			lpGIFCVar->lpEndBuff = lpGIFCVar->lpDataBuff;
			lpGIFCVar->wByteCnt  = 0;
		}
		bySubBlock[0]           = (BYTE)(lpGIFCVar->wBlockNdx - 1);
		memcpy(lpGIFCVar->lpEndBuff,(LPSTR)bySubBlock,lpGIFCVar->wBlockNdx);
		lpGIFCVar->lpEndBuff   += lpGIFCVar->wBlockNdx;
		lpGIFCVar->wByteCnt    += lpGIFCVar->wBlockNdx;
		lpGIFCVar->wBlockNdx    = 1;
	}
	
	// �������
	GlobalUnlock(hTableNdx);
	GlobalUnlock(hPrefix);
	GlobalUnlock(hSuffix);
	
	// �ͷ��ڴ�
	GlobalFree(hTableNdx);
	GlobalFree(hPrefix);
	GlobalFree(hSuffix);
	
	// �˳�
	return;
}


/*************************************************************************
 *
 * �������ƣ�
 *   GIF_LZW_WriteCode()
 *
 * ����:
 *   CFile& file			- Ҫ������ļ�
 *	 WORD wCode				- Ҫ���ӵı���
 *   LPSTR lpSubBlock		- �ӿ�
 *	 LPBYTE lpbyCurrentBits	- ��ǰλ��
 *	 LPGIFC_VAR lpGIFCVar	- ָ��GIFC_VAR�ṹ��ָ��
 *
 * ����ֵ:
 *   ��
 *
 * ˵��:
 *   �ú����������һ�����롣
 *
 *************************************************************************/
void WINAPI GIF_LZW_WriteCode(CFile& file, WORD wCode, LPSTR lpSubBlock,
                              LPBYTE lpbyCurrentBits,LPGIFC_VAR lpGIFCVar)
{
	// ����ñ���
	lpGIFCVar->dwTempCode |= ((DWORD)wCode << lpGIFCVar->byLeftBits);
	lpGIFCVar->byLeftBits += (*lpbyCurrentBits);
	
	while(lpGIFCVar->byLeftBits >= 0x08)
	{
		lpSubBlock[lpGIFCVar->wBlockNdx++] = (BYTE)lpGIFCVar->dwTempCode;
      
		// �ж��Ƿ񳬳�MAX_SUBBLOCK_SIZE
		if (lpGIFCVar->wBlockNdx > MAX_SUBBLOCK_SIZE)
		{
			// �ж�wByteCnt + 256�Ƿ񳬹�MAX_BUFF_SIZE
			if ((lpGIFCVar->wByteCnt + 256) >= MAX_BUFF_SIZE)
			{
				// ���
				file.Write(lpGIFCVar->lpDataBuff,
							lpGIFCVar->wByteCnt);
	            lpGIFCVar->lpEndBuff = lpGIFCVar->lpDataBuff;
		        lpGIFCVar->wByteCnt  = 0;
			}
			lpSubBlock[0]           = (BYTE)(lpGIFCVar->wBlockNdx - 1);
			memcpy(lpGIFCVar->lpEndBuff,lpSubBlock,lpGIFCVar->wBlockNdx);
			lpGIFCVar->lpEndBuff   += lpGIFCVar->wBlockNdx;
			lpGIFCVar->wByteCnt    += lpGIFCVar->wBlockNdx;
			lpGIFCVar->wBlockNdx    = 1;
		}
		lpGIFCVar->dwTempCode >>= 8;
		lpGIFCVar->byLeftBits  -= 0x08;
	}
	
	// ����
	return;
}


/*************************************************************************
 *
 * �������ƣ�
 *   ReadGIF()
 *
 * ����:
 *   CFile& file        - Ҫ��ȡ���ļ�
 *
 * ����ֵ:
 *   HDIB               - �ɹ�����DIB�ľ�������򷵻�NULL��
 *
 * ˵��:
 *   �ú�������ȡָ����GIF�ļ�������ȡ�Ľ��������һ��δѹ��
 * �����DIB�����С�
 *
 *************************************************************************/
HDIB WINAPI ReadGIF(CFile& file)
{
	
	// DIB���
	HDIB			   hDIB;
	
	// DIBָ��
	LPSTR			   pDIB;
	
	// ָ��DIB���ص�ָ��
	LPSTR			   lpDIBBits;
	
	// ָ��BITMAPINFOHEADER��ָ��
	LPBITMAPINFOHEADER lpBIH;
	
	// ָ��BITMAPINFO��ָ��
	LPBITMAPINFO       lpBI;	
	
	// GIF�ļ�ͷ
	GIFHEADER          GIFH;
	
	// GIF�߼���Ļ������
	GIFSCRDESC         GIFS;
	
	// GIFͼ��������
	GIFIMAGE           GIFI;
	
	// GIFͼ����������
	GIFCONTROL         GIFC;
	
	// GIFͼ��˵�������
	GIFPLAINTEXT       GIFP;
	
	// GIFӦ�ó��������
	GIFAPPLICATION     GIFA;
	
	// GIF�������
	GIFD_VAR           GIFDVar;
	
	// ��ɫ��Ŀ
	WORD               wColors;
	
	// ÿ���ֽ���
	WORD               wWidthBytes;
	
	// ��ɫ��
	BYTE               byGIF_Pal[768];
	
	// 16ɫϵͳ��ɫ��
	BYTE               bySysPal16[48] = {	0,   0,   0,   0,   0, 128,
											0, 128,   0,   0, 128, 128,
										  128,   0,   0, 128,   0, 128,
										  128, 128,   0, 128, 128, 128,
										  192, 192, 192,   0,   0, 255,
											0, 255,   0,   0, 255, 255,
										  255,   0,   0, 255,   0, 255,
										  255, 255,   0, 255, 255, 255
									   };
	
	// DIB��С(�ֽ���)
	DWORD              dwDIB_Size;	
	
	// ��ɫ���С(�ֽ���)
	WORD               wPalSize;
	
	// �ֽڱ���
	BYTE               byTemp;
	
	// �ڴ���
	HANDLE			   hSrcBuff;
	HANDLE             hTemp;
	
	// �ڴ�ָ��
	LPSTR              lpTemp;
	
	// �ֱ���
	WORD               wTemp;
	
	// ѭ������
	WORD               wi;
	
	// ��ǩ
	BYTE               byLabel;
	
	// ���С
	BYTE               byBlockSize;
	
	// ��ȡGIF�ļ�ͷ
	file.Read((LPSTR)&GIFH, sizeof(GIFH));
	
	// �ж��Ƿ���GIF�ļ�
	if (memicmp((LPSTR)GIFH.bySignature,"GIF",3) != 0)
	{
		// ��GIF�ļ�������NULL
		return NULL;
	}
	
	// �жϰ汾���Ƿ���ȷ
	if ((memicmp((LPSTR)GIFH.byVersion,"87a",3) != 0) &&
		(memicmp((LPSTR)GIFH.byVersion,"89a",3) != 0))
	{
		// ��֧�ָð汾������NULL
		return NULL;
	}
	
	// ��ȡGIF�߼���Ļ������
	file.Read((LPSTR)&GIFS, 7);
	
	// ��ȡ��ɫ���λ��
	GIFDVar.wBits = (WORD)GIFS.GlobalFlag.PalBits + 1;
	
	// �ж��Ƿ���ȫ�ֵ�ɫ��
	if (GIFS.GlobalFlag.GlobalPal)
	{
		// ����ֵ
		memset((LPSTR)byGIF_Pal,0,768);
		
		// ȫ�ֵ�ɫ���С
		wPalSize = 3 * (1 << GIFDVar.wBits);
		
		// ��ȡȫ�ֵ�ɫ��
		file.Read((LPSTR)byGIF_Pal,wPalSize);
	}
	
	// ��ȡ��һ���ֽ�
	file.Read((LPSTR)&byTemp,1);
	
	// ��ÿһ��������ѭ��
	while(TRUE)
	{
		// �ж��Ƿ���ͼ��������
		if (byTemp == 0x2C)
		{
			// ��ͼ�������飬�˳�ѭ��
			break;
		}
		
		// �ж��Ƿ���GIF��չ��
		if (byTemp==0x21)
		{
			// ��GIF��չ��
			
			// �����ڴ�
			hTemp  = GlobalAlloc(GHND,(DWORD)MAX_BUFF_SIZE);
			
			// �����ڴ�
			lpTemp = (LPSTR) GlobalLock(hTemp);
			
			// ��ȡ��һ���ֽ�
			file.Read((LPSTR)&byLabel, 1);
			
			// ��Ը�������飬���зֱ���
			switch(byLabel)
			{
				case 0xF9:
				{
					// ͼ����������
					file.Read((LPSTR)&GIFC, 6);
					
					// ����
					break;
				}
				case 0x01:
				{
					// ͼ��˵�������
					file.Read((LPSTR)&GIFP,sizeof(GIFP));
					
					// ��ȡ������С
					file.Read((LPSTR)&byBlockSize,1);
					
					// ��byBlockSize > 0ʱѭ����ȡ
					while(byBlockSize)
					{
						// ��ȡͼ��˵������飨����û�н����κδ�����
						file.Read(lpTemp,byBlockSize);
						
						// ��ȡ������С
						file.Read((LPSTR)&byBlockSize,1);
					}
					
					// ����
					break;
				}
				case 0xFE:
				{
					// ע��˵�������
					
					// ��ȡ������С
					file.Read((LPSTR)&byBlockSize,1);
					
					// ��byBlockSize > 0ʱѭ����ȡ
					while(byBlockSize)
					{
						// ��ȡע��˵������飨����û�н����κδ�����
						file.Read(lpTemp,byBlockSize);
					
						// ��ȡ������С
						file.Read((LPSTR)&byBlockSize,1);
					}
					
					// ����
					break;
				}
				case 0xFF:
				{
					// Ӧ�ó��������
					file.Read((LPSTR)&GIFA, sizeof(GIFA));
					
					// ��ȡ������С
					file.Read((LPSTR)&byBlockSize,1);
					
					// ��byBlockSize > 0ʱѭ����ȡ
					while(byBlockSize)
					{
						// ��ȡӦ�ó�������飨����û�н����κδ�����
						file.Read(lpTemp,byBlockSize);
						
						// ��ȡ������С
						file.Read((LPSTR)&byBlockSize,1);
					}
					
					// ����
					break;
				}
				default:
				{
					// ����δ֪�������
					
					// ��ȡ������С
					file.Read((LPSTR)&byBlockSize,1);
					
					// ��byBlockSize > 0ʱѭ����ȡ
					while(byBlockSize)
					{
						// ��ȡδ֪������飨����û�н����κδ�����
						file.Read(lpTemp,byBlockSize);
						
						// ��ȡ������С
						file.Read((LPSTR)&byBlockSize,1);
					}
					
					// ����
					break;
				}
			
				// �ͷ��ڴ�
				GlobalUnlock(hTemp);
				GlobalFree(hTemp);
			}
		}
		
		// ��ȡ��һ���ֽ�
		file.Read((LPSTR)&byTemp,1);
	}

	// ��ȡGIFͼ��������
	file.Read((LPSTR)&GIFI, 9);
	
	// ��ȡͼ�����
	GIFDVar.wWidth         = GIFI.wWidth;
	
	// ��ȡͼ��߶�
	GIFDVar.wDepth         = GIFI.wDepth;
	
	// �ж��Ƿ��������ɫ��
	if (GIFI.LocalFlag.LocalPal)
	{
		// ����ֵ
		memset((LPSTR)byGIF_Pal, 0, 768);
		
		// ��ȡ�����ɫ��λ��
		GIFDVar.wBits = (WORD)GIFI.LocalFlag.PalBits + 1;
		
		// �����ɫ���С
		wPalSize      = 3 * (1 << GIFDVar.wBits);
		
		// ��ȡ�����ɫ��
		file.Read((LPSTR)byGIF_Pal,wPalSize);
	}
	
	// ��GIFDVar��Ա��ֵ
	GIFDVar.wBits          = ((GIFDVar.wBits==1) ? 1 :
							  (GIFDVar.wBits<=4) ? 4 : 8);
	
	GIFDVar.wLineBytes     = (WORD)BYTE_WBYTES((DWORD)GIFDVar.wWidth *
											   (DWORD)GIFDVar.wBits);
	GIFDVar.bEOF           = FALSE;
	
	// ������ʽ
	GIFDVar.bInterlace     = (GIFI.LocalFlag.Interlace ? TRUE : FALSE);
	
	// ÿ���ֽ���
	wWidthBytes			   = (WORD)DWORD_WBYTES((DWORD)GIFDVar.wWidth *
								  				(DWORD)GIFDVar.wBits);
	
	// ��ɫ��Ŀ
	wColors				   = 1 << GIFDVar.wBits;
	
	// ��ɫ���С
	wPalSize			   = wColors * sizeof(RGBQUAD);
	
	// ����DIB���ȣ��ֽڣ�
	dwDIB_Size			   = sizeof(BITMAPINFOHEADER) + wPalSize
							 + GIFDVar.wDepth * wWidthBytes;
	
	// ΪDIB�����ڴ�
	hDIB = (HDIB) ::GlobalAlloc(GMEM_MOVEABLE | GMEM_ZEROINIT, dwDIB_Size);
	
	if (hDIB == 0)
	{
		// �ڴ����ʧ�ܣ�����NULL��
		return NULL;
	}
	
	// ����
	pDIB = (LPSTR) ::GlobalLock((HGLOBAL) hDIB);
	
	///////////////////////////////////////////////////////////////////////////
	// ����BITMAPINFOHEADER
	
	// ��ֵ
	lpBIH = (LPBITMAPINFOHEADER) pDIB;
	lpBI  = (LPBITMAPINFO) pDIB;
	
	// ��lpBIH��Ա��ֵ
	lpBIH->biSize = (DWORD)sizeof(BITMAPINFOHEADER);
	lpBIH->biWidth = (DWORD)GIFDVar.wWidth;
	lpBIH->biHeight = (DWORD)GIFDVar.wDepth;
	lpBIH->biPlanes = 1;
	lpBIH->biBitCount = GIFDVar.wBits;
	lpBIH->biCompression = BI_RGB;
	lpBIH->biSizeImage = (DWORD)wWidthBytes * GIFDVar.wDepth;
	lpBIH->biXPelsPerMeter = 0;
	lpBIH->biYPelsPerMeter = 0;
	lpBIH->biClrUsed = wColors;
	lpBIH->biClrImportant = 0;
	
	///////////////////////////////////////////////////////////////////////////
	// ���õ�ɫ��
	
	// �ж��Ƿ�ָ��ȫ�ֻ������ɫ��
	if (GIFS.GlobalFlag.GlobalPal || GIFI.LocalFlag.LocalPal)
	{
		wTemp = 0;
		for(wi=0; wi<wColors; wi++)
		{
			lpBI->bmiColors[wi].rgbRed      = byGIF_Pal[wTemp++];
			lpBI->bmiColors[wi].rgbGreen    = byGIF_Pal[wTemp++];
			lpBI->bmiColors[wi].rgbBlue     = byGIF_Pal[wTemp++];
			lpBI->bmiColors[wi].rgbReserved = 0x00;
		}
	}
	else
	{
		// û��ָ��ȫ�ֺ������ɫ�壬����ϵͳ��ɫ��
		
		// ������ɫ��Ŀ���ֱ����ɫ�帳ֵ
		switch(wColors)
		{
			case   2:
			{
				// ��ɫλͼ
				
				lpBI->bmiColors[0].rgbRed          = 0x00;
				lpBI->bmiColors[0].rgbGreen        = 0x00;
				lpBI->bmiColors[0].rgbBlue         = 0x00;
				lpBI->bmiColors[0].rgbReserved     = 0x00;
				lpBI->bmiColors[1].rgbRed          = 0xFF;
				lpBI->bmiColors[1].rgbGreen        = 0xFF;
				lpBI->bmiColors[1].rgbBlue         = 0xFF;
				lpBI->bmiColors[1].rgbReserved     = 0x00;
				
				// ����
				break;
			}
			case  16:
			{
				// 16ɫλͼ
				
				wTemp = 0;
				for(wi=0;wi<wColors;wi++)
				{
					lpBI->bmiColors[wi].rgbRed      = bySysPal16[wTemp++];
					lpBI->bmiColors[wi].rgbGreen    = bySysPal16[wTemp++];
					lpBI->bmiColors[wi].rgbBlue     = bySysPal16[wTemp++];
					lpBI->bmiColors[wi].rgbReserved = 0x00;
				}
				
				// ����
				break;
			}
			case 256:
			{
				// 256ɫλͼ
				for(wi=0; wi<wColors; wi++)
				{
					lpBI->bmiColors[wi].rgbRed      = (BYTE)wi;
					lpBI->bmiColors[wi].rgbGreen    = (BYTE)wi;
					lpBI->bmiColors[wi].rgbBlue     = (BYTE)wi;
					lpBI->bmiColors[wi].rgbReserved = 0x00;
				}
				
				// ����
				break;
			}
		}
	}
	
	///////////////////////////////////////////////////////////////////////////
	// ����

	// ��ȡ�������ݳ���
	GIFDVar.dwDataLen  = (DWORD) (file.GetLength() - file.GetPosition());
	
	// �����ڴ��С����󲻳���MAX_BUFF_SIZE��
	GIFDVar.wMemLen    = ((GIFDVar.dwDataLen > (DWORD)MAX_BUFF_SIZE) ?
						  (WORD)MAX_BUFF_SIZE : (WORD)GIFDVar.dwDataLen);
	
	// �����ڴ�
	hSrcBuff = GlobalAlloc(GHND, (DWORD)GIFDVar.wMemLen);
	
	// �����ڴ�
	GIFDVar.lpDataBuff = (LPSTR)GlobalLock(hSrcBuff);
	
	// ��ȡ��������
	ReadSrcData(file,&GIFDVar.wMemLen,&GIFDVar.dwDataLen,
				GIFDVar.lpDataBuff,&GIFDVar.bEOF);
	
	// ��������ʼλ��
	GIFDVar.lpBgnBuff  = GIFDVar.lpDataBuff;
	
	// ��������ֹλ��
	GIFDVar.lpEndBuff  = GIFDVar.lpBgnBuff + GIFDVar.wMemLen;
	
	// ����DIB������λ��
	lpDIBBits = (LPSTR) FindDIBBits(pDIB);
	
	// ����
	DecodeGIF_LZW(file, lpDIBBits, &GIFDVar, wWidthBytes);

	// �ͷ��ڴ�
	GlobalUnlock(hSrcBuff);
	GlobalFree(hSrcBuff);
	
	// ����DIB���
	return hDIB;
}


/*************************************************************************
 *
 * �������ƣ�
 *   ReadSrcData()
 *
 * ����:
 *   CFile& file			- ԴGIF�ļ�
 *   LPWORD lpwMemLen		- ���������ȣ�ָ�룩
 *   LPDWORD lpdwDataLen	- ʣ�����ݳ��ȣ�ָ�룩
 *   LPSTR lpSrcBuff		- ������ָ��
 *	 LPBOOL lpbEOF			- ������־
 *
 * ����ֵ:
 *   ��
 *
 * ˵��:
 *   �ú���������ȡָ��GIF�ļ��е�ͼ����룬ÿ������ȡMAX_BUFF_SIZE
 * �ֽڣ��Ƿ�����ɱ�־lpbEOFָ����
 *
 *************************************************************************/
void WINAPI ReadSrcData(CFile& file, LPWORD lpwMemLen, LPDWORD lpdwDataLen,
                        LPSTR lpSrcBuff, LPBOOL lpbEOF)
{
	// �ж����ݳ����Ƿ���Ȼ�����ڴ��С
	if ((*lpdwDataLen) > (DWORD)(*lpwMemLen))
	{
		// ���ݳ��ȴ����ڴ��С����ʾû�н�����
		
		// ���ݳ��ȼ��ڴ��С
		(*lpdwDataLen) -= (DWORD)(*lpwMemLen);
	}
	else
	{
		// ���ݳ��Ȳ������ڴ��С����ʾ���뽫Ҫ���
		
		// �ڴ��С����ʣ�����ݳ���
		(*lpwMemLen)    = (WORD)(*lpdwDataLen);
		
		// EOF��־����ΪTRUE
		(*lpbEOF)       = TRUE;
	}
	
	// ��ȡ��������
	file.Read(lpSrcBuff, (*lpwMemLen));
	
	// ����
	return;
}

/*************************************************************************
 *
 * �������ƣ�
 *   DecodeGIF_LZW()
 *
 * ����:
 *   CFile& file			- ԴGIF�ļ�
 *   LPSTR lpDIBBits		- ָ��Ҫ�����DIBͼ��ָ��
 *   LPGIFD_VAR lpGIFDVar	- ָ��GIFC_VAR�ṹ��ָ��
 *	 WORD wWidthBytes		- ÿ��ͼ���ֽ���
 *
 * ����ֵ:
 *   ��
 *
 * ˵��:
 *   �ú�����ָ��GIF_LZW�������ݽ��н��롣
 *
 *************************************************************************/
void WINAPI DecodeGIF_LZW(CFile& file, LPSTR lpDIBBits,
						  LPGIFD_VAR lpGIFDVar,WORD wWidthBytes)
{
	// ָ������ͼ�����ݵ�ָ��
	BYTE *	lpDst;
	
	// �ڴ������
	HANDLE hPrefix;
	HANDLE hSuffix;
	HANDLE hStack;
	HANDLE hImage;
	
	// �����ִ�������������
	LPWORD lpwPrefix;
	LPBYTE lpbySuffix;
	LPBYTE lpbyStack;
	LPBYTE lpbyStackBgn;
	
	// ָ��ͼ��ǰ�н�������ָ��
	LPSTR  lpImageBgn;
	
	// ָ��ǰ�������ص�ָ��
	LPSTR  lpImage;
	
	// ���㵱ǰ����ͼ���ƫ����
	DWORD  dwDataNdx;
	
	// LZW_CLEAR
	WORD   wLZW_CLEAR;
	
	// LZW_EOI
	WORD   wLZW_EOI;
	
	// LZW_MinCodeLen
	BYTE   byLZW_MinCodeLen;
	
	// �ִ�������
	WORD   wNowTableNdx;
	WORD   wTopTableNdx;
	
	// ��ǰͼ�������
	WORD   wRowNum;
	
	// ����
	WORD   wWidthCnt;
	WORD   wBitCnt;
	WORD   wRowCnt;
	
	// ѭ������
	WORD   wi;
	
	// ������ʽ�洢ʱÿ�����ӵ�����
	WORD   wIncTable[5]  = { 8,8,4,2,0 }; 
	
	// ������ʽ�洢ʱ��ʼ����
	WORD   wBgnTable[5]  = { 0,4,2,1,0 }; 
	
	// ���С
	BYTE   byBlockSize;
	
	// ������
	BYTE   byBlockNdx;
	
	DWORD  dwData;
	
	// ��ǰ����
	WORD   wCode;
	
	// ��һ������
	WORD   wOldCode;
	
	// ��ʱ����
	WORD   wTempNdx;
	
	WORD   wCodeMask[13] = {0x0000,
							0x0001,0x0003,0x0007,0x000F,
							0x001F,0x003F,0x007F,0x00FF,
							0x01FF,0x03FF,0x07FF,0x0FFF
							};
	
	BYTE   byLeftBits;
	BYTE   byFirstChar;
	BYTE   byCode;
	BYTE   byCurrentBits;
	BYTE   byPass;
	
	// ��ʱ�ֽڱ���
	BYTE   byTempChar;
	
	// ���ִ��������ڴ�
	hPrefix          = GlobalAlloc(GHND,(DWORD)(MAX_TABLE_SIZE<<1));
	hSuffix          = GlobalAlloc(GHND,(DWORD)MAX_TABLE_SIZE);
	hStack           = GlobalAlloc(GHND,(DWORD)MAX_TABLE_SIZE);
	hImage           = GlobalAlloc(GHND,(DWORD)wWidthBytes);
	
	// �����ڴ�
	lpwPrefix        = (LPWORD)GlobalLock(hPrefix);
	lpbySuffix       = (LPBYTE)GlobalLock(hSuffix);
	lpbyStack        = (LPBYTE)GlobalLock(hStack);
	lpbyStackBgn     = lpbyStack;
	lpImage          = (LPSTR)GlobalLock(hImage);
	lpImageBgn       = lpImage;
	
	// ��ȡGIF LZW��С�����С
	byLZW_MinCodeLen = *lpGIFDVar->lpBgnBuff++;
	
	byCurrentBits    = byLZW_MinCodeLen + (BYTE)0x01;
	
	// ����LZW_CLEAR
	wLZW_CLEAR       = 1 << byLZW_MinCodeLen;
	
	// ����LZW_EOI
	wLZW_EOI         = wLZW_CLEAR + 1;
	
	// �����ִ�������
	wNowTableNdx     = wLZW_CLEAR + 2;
	wTopTableNdx     = 1 << byCurrentBits;
	
	// ����ֵ
	dwData           = 0UL;
	wBitCnt          = lpGIFDVar->wBits;
	wRowNum          = 0;
	wRowCnt          = 1;
	wWidthCnt        = 0;
	wCode            = 0;
	wOldCode         = 0xFFFF;
	byBlockSize      = 0x01;
	byBlockNdx       = 0x00;
	byLeftBits       = 0x00;
	byTempChar       = 0x00;
	byPass           = 0x00;
	
	// ��ȡ��һ������
	while(byLeftBits < byCurrentBits)
	{
		// ��ȡ��һ���ַ�
		
		// �ж��Ƿ����һ�����ݿ�
		if (++byBlockNdx == byBlockSize)
		{
			// ��ȡ��һ�����ݿ�
			byBlockSize = *lpGIFDVar->lpBgnBuff++;
			byBlockNdx  = 0x00;
			
			// �ж��Ƿ����
			if ((lpGIFDVar->lpBgnBuff == lpGIFDVar->lpEndBuff) &&
			    !lpGIFDVar->bEOF)
			{
				// ��ȡ��һ�����ݿ�
				ReadSrcData(file,&lpGIFDVar->wMemLen,
							&lpGIFDVar->dwDataLen,
							lpGIFDVar->lpDataBuff,&lpGIFDVar->bEOF);
				
				// ָ�����¸�ֵ
				lpGIFDVar->lpBgnBuff = lpGIFDVar->lpDataBuff;
				lpGIFDVar->lpEndBuff = lpGIFDVar->lpBgnBuff + lpGIFDVar->wMemLen;
			}
		}
		
		// ��һ���ַ�
		byCode      = *lpGIFDVar->lpBgnBuff++;
		
		// ��λ
		dwData     |= ((DWORD)byCode << byLeftBits);
		byLeftBits += 0x08;
		
		// �ж��Ƿ����
		if ((lpGIFDVar->lpBgnBuff == lpGIFDVar->lpEndBuff) &&
		    !lpGIFDVar->bEOF)
		{
			// ��ȡ��һ�����ݿ�
			ReadSrcData(file,&lpGIFDVar->wMemLen,
						&lpGIFDVar->dwDataLen,
						lpGIFDVar->lpDataBuff,&lpGIFDVar->bEOF);
			
			// ָ�����¸�ֵ
			lpGIFDVar->lpBgnBuff = lpGIFDVar->lpDataBuff;
			lpGIFDVar->lpEndBuff = lpGIFDVar->lpBgnBuff + lpGIFDVar->wMemLen;
		}
	}
	
	wCode       = (WORD)dwData & wCodeMask[byCurrentBits];
	dwData    >>= byCurrentBits;
	byLeftBits -= byCurrentBits;
	
	// ����
	while(wCode != wLZW_EOI)
	{
		// ��ǰ���벻��LZW_EOI��
		
		// �ж��Ƿ���LZW_CLEAR��
		if (wCode == wLZW_CLEAR)
		{
			// ��LZW_CLEAR������ִ���
			
			// ���³�ʼ���ִ���
			for(wi = 0; wi < wLZW_CLEAR; wi++)
			{
				*(lpwPrefix  + wi)  = 0xFFFF;
				*(lpbySuffix + wi) = (BYTE)wi;
			}
			
			for(wi = wNowTableNdx; wi < MAX_TABLE_SIZE; wi++)
			{
				*(lpwPrefix+wi)  = 0xFFFF;
				*(lpbySuffix+wi) = 0x00;
			}
			
			byCurrentBits = byLZW_MinCodeLen + (BYTE)0x01;
			wNowTableNdx  = wLZW_CLEAR + 2;
			wTopTableNdx  = 1 << byCurrentBits;
			wOldCode      = 0xFFFF;
			
			// ��ȡ��һ������
			while(byLeftBits < byCurrentBits)
			{
				// ��ȡ��һ���ַ�
				
				// �ж��Ƿ����һ�����ݿ�
				if (++byBlockNdx == byBlockSize)
				{
					// ��ȡ��һ�����ݿ�
					byBlockSize = *lpGIFDVar->lpBgnBuff++;
					byBlockNdx  = 0x00;
					
					// �ж��Ƿ����
					if ((lpGIFDVar->lpBgnBuff == lpGIFDVar->lpEndBuff) &&
						!lpGIFDVar->bEOF)
					{
						// ��ȡ��һ�����ݿ�
						ReadSrcData(file, &lpGIFDVar->wMemLen,
									&lpGIFDVar->dwDataLen,
									lpGIFDVar->lpDataBuff,
									&lpGIFDVar->bEOF);
						
						// ָ�����¸�ֵ
						lpGIFDVar->lpBgnBuff = lpGIFDVar->lpDataBuff;
						lpGIFDVar->lpEndBuff = lpGIFDVar->lpBgnBuff +
											   lpGIFDVar->wMemLen;
					}
				}
				byCode      = *lpGIFDVar->lpBgnBuff++;
				dwData     |= ((DWORD)byCode << byLeftBits);
				byLeftBits += 0x08;
				
				// �ж��Ƿ����
				if ((lpGIFDVar->lpBgnBuff == lpGIFDVar->lpEndBuff) &&
					 !lpGIFDVar->bEOF)
				{
					// ��ȡ��һ�����ݿ�
					ReadSrcData(file,&lpGIFDVar->wMemLen,
								&lpGIFDVar->dwDataLen,
								lpGIFDVar->lpDataBuff,&lpGIFDVar->bEOF);
					
					// ָ�����¸�ֵ
					lpGIFDVar->lpBgnBuff = lpGIFDVar->lpDataBuff;
					lpGIFDVar->lpEndBuff = lpGIFDVar->lpBgnBuff + lpGIFDVar->wMemLen;
				}
			}
			wCode       = (WORD)dwData & wCodeMask[byCurrentBits];
			dwData    >>= byCurrentBits;
			byLeftBits -= byCurrentBits;
			
			// �жϱ����Ƿ�ΪLZW_EOI
			if (wCode!=wLZW_EOI)
			{
				// ����û���õ�lpbyStack[0]
				lpbyStack  ++;
				
				// ������ѹ���ջ
				while((*(lpwPrefix+wCode)) != 0xFFFF)
				{
					*lpbyStack++ = *(lpbySuffix+wCode);
					wCode        = *(lpwPrefix+wCode);
				}
				*lpbyStack  = *(lpbySuffix+wCode);
				byFirstChar = *lpbyStack;
				
				// �������
				while(lpbyStack>lpbyStackBgn)
				{
					byTempChar |= (*lpbyStack-- << (8-wBitCnt));
					
					if (wBitCnt==8)
					{
						*lpImage++ = byTempChar;
						byTempChar = 0x00;
						wBitCnt    = lpGIFDVar->wBits;
					}
					else
					{
						wBitCnt   += lpGIFDVar->wBits;
					}
					
					wWidthCnt  ++;
					
					if (wWidthCnt==lpGIFDVar->wWidth)
					{
						if (wBitCnt!=lpGIFDVar->wBits)
						{
							*lpImage   = byTempChar;
							byTempChar = 0x00;
							wBitCnt    = lpGIFDVar->wBits;
						}
						
						// ͼ��ǰ��ƫ����
						dwDataNdx = (DWORD)(lpGIFDVar->wDepth - 1 - wRowNum) * (DWORD)wWidthBytes;
						
						// ͼ��ǰ����ʼλ��
						lpDst = (BYTE *)lpDIBBits + dwDataNdx;
						
						// ��ֵ
						memcpy(lpDst, lpImageBgn, wWidthBytes);
						
						lpImage   = lpImageBgn;
						
						// �ж��Ƿ��ս�����ʽ����
						if (lpGIFDVar->bInterlace)
						{
							// ������ʽ
							
							// ������һ�е��к�
							wRowNum += wIncTable[byPass];
							if (wRowNum >= lpGIFDVar->wDepth)
							{
								byPass ++;
								wRowNum = wBgnTable[byPass];
							}
						}
						else
						{
							// �ǽ�����ʽ���к�ֱ�Ӽ�1
							wRowNum ++;
						}
						wWidthCnt = 0;
					}
				}
			}
		}
		else
		{
			// ����û���õ�lpbyStack[0]
			lpbyStack  ++;
			
			// �ж��ַ����Ƿ����ִ�����
			if (wCode < wNowTableNdx)
			{
				// �����ִ�����
				wTempNdx   = wCode;
			}
			else
			{
				// ���ִ�����
				wTempNdx     = wOldCode;
				*lpbyStack++ = byFirstChar;
			}
			
			// ������ѹ���ջ
			while((*(lpwPrefix+wTempNdx)) != 0xFFFF)
			{
				*lpbyStack++ = *(lpbySuffix+wTempNdx);
				wTempNdx     = *(lpwPrefix+wTempNdx);
			}
			*lpbyStack  = *(lpbySuffix+wTempNdx);
			byFirstChar = *lpbyStack;
			
			// ���ַ������ӵ��ִ�����
			*(lpwPrefix+wNowTableNdx)  = wOldCode;
			*(lpbySuffix+wNowTableNdx) = byFirstChar;
			if (++wNowTableNdx==wTopTableNdx && byCurrentBits<12)
			{
				byCurrentBits ++;
				wTopTableNdx   = 1 << byCurrentBits;
			}
			
			// �������
			while(lpbyStack>lpbyStackBgn)
			{
				byTempChar |= (*lpbyStack-- << (8-wBitCnt));
				if (wBitCnt==8)
				{
					*lpImage++ = byTempChar;
					byTempChar = 0x00;
					wBitCnt    = lpGIFDVar->wBits;
				}
				else
				{
					wBitCnt   += lpGIFDVar->wBits;
				}
				
				wWidthCnt  ++;
				if (wWidthCnt==lpGIFDVar->wWidth)
				{
					if (wBitCnt!=lpGIFDVar->wBits)
					{
						*lpImage   = byTempChar;
						byTempChar = 0x00;
						wBitCnt    = lpGIFDVar->wBits;
					}
					
					// ͼ��ǰ��ƫ����
					dwDataNdx = (DWORD)(lpGIFDVar->wDepth - 1 - wRowNum) * (DWORD)wWidthBytes;
					
					// ͼ��ǰ����ʼλ��
					lpDst = (BYTE *)lpDIBBits + dwDataNdx;
					
					// ��ֵ
					memcpy(lpDst, lpImageBgn, wWidthBytes);
					
					lpImage   = lpImageBgn;
					
					// �ж��Ƿ��ս�����ʽ����
					if (lpGIFDVar->bInterlace)
					{
						// ������ʽ
						
						// ������һ�е��к�
						wRowNum += wIncTable[byPass];
						if (wRowNum >= lpGIFDVar->wDepth)
						{
							byPass ++;
							wRowNum = wBgnTable[byPass];
						}
					}
					else
					{
						// �ǽ�����ʽ���к�ֱ�Ӽ�1
						wRowNum ++;
					}
					wWidthCnt = 0;
				}
			}
		}
		wOldCode = wCode;
		
		// ��ȡ��һ������
		while(byLeftBits < byCurrentBits)
		{
			// ��ȡ��һ���ַ�
			
			// �ж��Ƿ����һ�����ݿ�
			if (++byBlockNdx == byBlockSize)
			{
				// ��ȡ��һ�����ݿ�
				byBlockSize = *lpGIFDVar->lpBgnBuff++;
				byBlockNdx  = 0x00;
				
				// �ж��Ƿ����
				if ((lpGIFDVar->lpBgnBuff == lpGIFDVar->lpEndBuff) &&
					 !lpGIFDVar->bEOF)
				{
					// ��ȡ��һ�����ݿ�
					ReadSrcData(file,&lpGIFDVar->wMemLen,
								&lpGIFDVar->dwDataLen,
								lpGIFDVar->lpDataBuff,&lpGIFDVar->bEOF);
					
					// ָ�����¸�ֵ
					lpGIFDVar->lpBgnBuff = lpGIFDVar->lpDataBuff;
					lpGIFDVar->lpEndBuff = lpGIFDVar->lpBgnBuff + lpGIFDVar->wMemLen;
				}
			}
			byCode      = *lpGIFDVar->lpBgnBuff++;
			dwData     |= ((DWORD)byCode << byLeftBits);
			byLeftBits += 0x08;
			
			// �ж��Ƿ����
			if ((lpGIFDVar->lpBgnBuff == lpGIFDVar->lpEndBuff) &&
				  !lpGIFDVar->bEOF)
			{
				// ��ȡ��һ�����ݿ�
				ReadSrcData(file,&lpGIFDVar->wMemLen,
							&lpGIFDVar->dwDataLen,
							lpGIFDVar->lpDataBuff,&lpGIFDVar->bEOF);
				
				// ָ�����¸�ֵ
				lpGIFDVar->lpBgnBuff = lpGIFDVar->lpDataBuff;
				lpGIFDVar->lpEndBuff = lpGIFDVar->lpBgnBuff + lpGIFDVar->wMemLen;
			}
		}
		wCode       = (WORD)dwData & wCodeMask[byCurrentBits];
		dwData    >>= byCurrentBits;
		byLeftBits -= byCurrentBits;
	}
	
	// �ͷ��ڴ�
	GlobalUnlock(hPrefix);
	GlobalUnlock(hSuffix);
	GlobalUnlock(hStack);
	GlobalFree(hPrefix);
	GlobalFree(hSuffix);
	GlobalFree(hStack);
	
	// ����
	return;
}