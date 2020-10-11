!
! 對話窗的示範之二
! By Perng 1997/09/26
program main
use DFLIB
implicit none
  integer :: i,ix,iy

  call ClearScreen($GCLEARSCREEN)
  do while(.true.)
    i = waitonmouseevent(MOUSE$LBUTTONDOWN, i, ix, iy)
  end do
end program
!
! 記錄全域變數
!
module Global
implicit none
  integer, save :: red=0
  integer, save :: green=0
  integer, save :: blue=0
end module
!
! 自訂選單
!
logical(kind=4) function InitialSettings()
use DFLIB
implicit none
  logical(kind=4) result
  external FileOpen,FileSave
  external SetColorDialog

  result=AppendMenuQQ(1,$MENUENABLED,'File'C,NUL)
  result=AppendMenuQQ(1,$MENUENABLED,'&Open'C,FileOpen)
  result=AppendMenuQQ(1,$MENUENABLED,'&Save'C,FileSave)
  result=AppendMenuQQ(1,$MENUENABLED,'&Exit'C,WINEXIT)

  result=AppendMenuQQ(2,$MENUENABLED,'&SetColor',SetColorDialog)
  
  InitialSettings=result
  return
end function
!
! 處理Open
!
subroutine FileOpen(check)
use Global
implicit none
  logical :: check
  check=.true.
  ! 開啟一個空白字元的檔案, 會出現一個檔案選擇的對話窗來給使用者選擇檔案
  open(unit=10, file=' ')
  read(10,*) red
  read(10,*) green
  read(10,*) blue
  close(10)
  call DrawObject()
  return
end subroutine
!
! 處理Save
!
subroutine FileSave(check)
use Global
implicit none
  logical :: check
  check=.true.
  ! 使用檔案選擇的對話窗
  open(unit=20, file=' ')
  write(20,*) red
  write(20,*) green
  write(20,*) blue
  close(20)
  return
end subroutine
!
! 按下SetColor時會執行這個函式
!
subroutine SetColorDialog(check)
use Global
use DFLIB
use dialogm
implicit none
  logical :: check
  integer :: result
  include 'resource.fd'
  type(dialog) :: dlg
  external ShowColor
  character(len=10) output

  check=.true.
  result=DlgInit(IDD_SETCOLOR, dlg) ! 初始對話窗
  ! 設定捲軸可以捲動的範圍
  result=DlgSet( dlg, IDC_SCROLLBAR1, 256, dlg_range ) 
  result=DlgSet( dlg, IDC_SCROLLBAR2, 256, dlg_range )
  result=DlgSet( dlg, IDC_SCROLLBAR3, 256, dlg_range )
  ! 設定捲軸目前的位置
  result=DlgSet( dlg, IDC_SCROLLBAR1, red, dlg_position )
  result=DlgSet( dlg, IDC_SCROLLBAR2, green, dlg_position )
  result=DlgSet( dlg, IDC_SCROLLBAR3, blue, dlg_position )
! 上面有比較奇怪的用法, dlg_range代表現在是要設定捲軸元件的範圍值
! dlg_position代表是要設定捲軸元件的位置. 讀者可以想像當型態為dialog
! 的dlg被宣告時, 編譯器會自動幫我們宣告出dlg_range, dlg_position等等
! 的變數並設定好它們的數值.

  ! 寫出紅,綠,藍三色光的強度數值
  write(output,"(I3)") red
  result=DlgSet( dlg, IDC_VALUE_RED, output )
  write(output,"(I3)") green
  result=DlgSet( dlg, IDC_VALUE_GREEN, output )
  write(output,"(I3)") blue
  result=DlgSet( dlg, IDC_VALUE_BLUE, output )
  ! 設定拉動捲軸時會執行的函式
  result=DlgSetSub( dlg, IDC_SCROLLBAR1, ShowColor )
  result=DlgSetSub( dlg, IDC_SCROLLBAR2, ShowColor )
  result=DlgSetSub( dlg, IDC_SCROLLBAR3, ShowColor )
  ! 秀出對話窗
  result=DlgModal(dlg)

  return
end subroutine
!
! 取出三色光的設定並繪出一個實心方形
!
subroutine ShowColor(dlg,id,callbacktype)
use Global
use DFLIB
use dialogm
implicit none
  type(dialog) :: dlg
  integer :: id, callbacktype
  integer :: result
  character(len=10) :: output
  include 'resource.fd'
  ! 取出捲軸的位置
  result=DlgGet( dlg, IDC_SCROLLBAR1, red, dlg_position )
  result=DlgGet( dlg, IDC_SCROLLBAR2, green, dlg_position )
  result=DlgGet( dlg, IDC_SCROLLBAR3, blue, dlg_position )
  ! 因為顏色的變化範圍是0-255, 而捲軸的範圍是1-256, 所以要減1
  red=red-1
  green=green-1
  blue=blue-1

  select case(id)
  case(IDC_SCROLLBAR1)	! 第一個捲軸設定紅色光強度
    write(output,"(I3)") red
    result=DlgSet( dlg, IDC_VALUE_RED, output )
  case(IDC_SCROLLBAR2)  ! 第二個捲軸設定綠色光強度
    write(output,"(I3)") green
    result=DlgSet( dlg, IDC_VALUE_GREEN, output )
  case(IDC_SCROLLBAR3)  ! 第三個捲軸設定藍色光強度
    write(output,"(I3)") blue
    result=DlgSet( dlg, IDC_VALUE_BLUE, output )
  end select

  call DrawObject()

  return
end subroutine
!
! 以設定的顏色畫出實心方形
!
subroutine DrawObject()
use Global
use DFLIB
implicit none
  integer :: result
  integer :: color

  color=RGBToInteger(red,green,blue)
  result=SetColorRGB(color)
  result=Rectangle($GFILLINTERIOR,10,10,50,50)
  
  return
end subroutine 
