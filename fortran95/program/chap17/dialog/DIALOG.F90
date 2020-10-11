!
! 使用選單及對話窗的示範
! By Perng 1997/9/22
program Menu_Demo
use DFLIB
implicit none
  type(windowconfig) :: wc
  integer :: result  
  integer :: i,ix,iy

  wc.numxpixels=200 ! 視窗的寬
  wc.numypixels=200 ! 視窗的高
  ! -1代表讓程式自行去做決定
  wc.numtextcols=-1	! 每行容量的文字
  wc.numtextrows=-1	! 可以有幾列文字
  wc.numcolors=-1	! 使用多少顏色
  wc.title="Plot Area"C ! 視窗的標題
  wc.fontsize=-1
  ! 根據wc中所定義的資料來重新設定視窗大小
  result=SetWindowConfig(wc)
  ! 把程式放入等待滑鼠訊息的狀態
  do while (.TRUE.)
    i = waitonmouseevent(MOUSE$RBUTTONDOWN, i, ix, iy)
  end do
end program
!
! 程式會自動執行這個函數, 它會設定視窗的長相
!
logical(kind=4) function InitialSettings()
use DFLIB
implicit none
  logical(kind=4) :: result
  type(qwinfo) :: qw
  external PlotSin,PlotCos  
  external SetRange
  
  ! 設定整個視窗程式一開始出現的位置及大小
  qw.type=QWIN$SET
  qw.x=0
  qw.y=0
  qw.h=400
  qw.w=400
  result=SetWSizeQQ(QWIN$FRAMEWINDOW,qw) 
  
  ! 組織第一組選單
  result=AppendMenuQQ(1,$MENUENABLED,'&File'C,NUL)		 
  result=AppendMenuQQ(1,$MENUENABLED,'&Save'C,WINSAVE)   
  result=AppendMenuQQ(1,$MENUENABLED,'&Print'C,WINPRINT) 
  result=AppendMenuQQ(1,$MENUENABLED,'&Exit'C,WINEXIT)  
  ! 組織第二組選單
  result=AppendMenuQQ(2,$MENUENABLED,'&Plot'C,NUL)
  result=AppendMenuQQ(2,$MENUENABLED,'&sin(x)'C,PlotSin)
  result=AppendMenuQQ(2,$MENUENABLED,'&cos(x)'C,PlotCos)
  ! 組織第三組選單
  result=AppendMenuQQ(3,$MENUENABLED,'&Range'C,SetRange)

  InitialSettings=.true.
  return
end function InitialSettings
!
! 記錄全域變數
!
module Global
implicit none
  real(kind=8) :: X_Start=-5.0  ! x軸最小範圍
  real(kind=8) :: X_End=5.0		! x軸最大範圍	
  real(kind=8) :: Y_Top=5.0		! y軸最大範圍 
  real(kind=8) :: Y_Buttom=-5.0	! y軸最小範圍
  integer      :: lines=500     ! 用多少線段來畫函數曲線
  integer	   :: Function_Num=0 ! 使用第幾號函數來畫圖
end module  
!
! 畫sin的副程式
!
subroutine PlotSin(check)
use DFLIB
use Global
implicit none
  logical(kind=4) :: check
  real(kind=8), external :: f1
  integer :: result
  check=.true.
  Function_Num=1
  ! 在第二組選單的第一個選項,也就是sin的前面打個勾
  result=ModifyMenuFlagsQQ(2,1,$MENUCHECKED)
  ! 把選項cos前的勾取消
  result=ModifyMenuFlagsQQ(2,2,$MENUUNCHECKED)
  call Draw_Func(f1)
  return
end subroutine
!
! 畫cos的副程式
!
subroutine PlotCos(check)
use DFLIB
use Global
implicit none
  logical(kind=4) :: check
  real(kind=8), external :: f2
  integer :: result
  check=.true.
  Function_Num=2
  ! 把選項sin前的勾取消
  result=ModifyMenuFlagsQQ(2,1,$MENUUNCHECKED)
  ! 在選項cos前打個勾
  result=ModifyMenuFlagsQQ(2,2,$MENUCHECKED)
  call Draw_Func(f2)
  return
end subroutine
!
! 按下Range時,會執行這個副程式
!
subroutine SetRange(check)
use Global
use Dialogm
implicit none
  logical(kind=4) :: check
  real(kind=8), external :: f1,f2
  external ReSetRange
  ! 因為想在對話窗中保留上一次的設定結果,所以安排了下列的變數
  real(kind=8),save :: OX_Start=-5.0  ! x軸最小範圍
  real(kind=8),save :: OX_End=5.0	  ! x軸最大範圍	
  real(kind=8),save :: OY_Top=5.0	  ! y軸最大範圍 
  real(kind=8),save :: OY_Buttom=-5.0 ! y軸最小範圍
  integer     ,save :: Olines=500     ! 用多少線段來畫函數曲線
  include 'resource.fd'	! 對話窗的資訊 
  type(dialog) :: dl	
  integer :: result		!
  character(len=20) :: str	

  check=.true.
  ! 宣告要使用代碼為IDD_INPUT的對話窗, 並把顯示這個對話窗的資訊放
  ! 在dl中. 以後只要對dl來處理就等於對這個對話窗來工作
  result=DlgInit(IDD_INPUT, dl)
    
  ! 下面要對dl所代表的對話窗中ID值為IDC_X_MIN來設定初值
  ! 也就是設定IDD_INPUT中X min欄的內容
  
  ! 因為DlgSet無法使用read型態變數來設定,所以要先把它們轉換成字串
  write(str,'(f6.2)') OX_Start
  result=DlgSet(dl,IDC_X_MIN,str)
  ! 設定X max欄的內容
  write(str,'(f6.2)') OX_End
  result=DlgSet(dl,IDC_X_MAX,str)
  ! 設定Y min欄的內容
  write(str,'(f6.2)') OY_Buttom
  result=DlgSet(dl,IDC_Y_MIN,str)
  ! 設定Y max欄的內容
  write(str,'(f6.2)') OY_Top
  result=DlgSet(dl,IDC_Y_MAX,str)
  ! 設定Lines欄的內容
  write(str,'(I5)') OLines
  result=DlgSet(dl,IDC_LINES,str)
  ! 設定按下Reset時會執行的副程式
  result=DlgSetSub(dl,IDC_RESET, ReSetRange)
  ! 到此才真正秀出對話窗
  result=DlgModal(dl)
  
  if ( result==IDOK ) then
  ! 由字串轉成數值
    result=DlgGet(dl,IDC_X_MIN,str)
    read(str,*) OX_Start
    result=DlgGet(dl,IDC_X_MAX,str)
	read(str,*) OX_End
    result=DlgGet(dl,IDC_Y_MIN,str)
	read(str,*) OY_Buttom
    result=DlgGet(dl,IDC_Y_MAX,str)
    read(str,*) OY_Top
    result=DlgGet(dl,IDC_LINES,str)
	read(str,*) OLines
  ! 設定全域變數的值, 繪圖時會取用這些數值
    X_Start=OX_Start
	X_End=OX_End
	Y_Top=OY_Top
	Y_Buttom=OY_Buttom
	Lines=OLines
  end if
  ! 由Function_Num的值來決定要畫出第幾個函數
  select case(Function_Num)
  case(0)
    ! Do Nothing
  case(1)
    call Draw_Func(f1) 
  case(2)
    call Draw_Func(f2)
  end select

  return
end subroutine
!
! 按下Reset會執行這個副程式
! dlg,id,callback會自動傳入
subroutine ReSetRange( dlg, id, callbacktype )
use DialogM
implicit none
  type(Dialog) :: dlg
  integer :: id,callbacktype
  integer :: t1,t2
  integer :: result
  include 'resource.fd'
  ! 下面這兩行沒什麼用,只是如果沒有下面兩行,Compile時會有Warning.
  t1=id
  t2=callbacktype
  ! 重新設定對話窗中每個欄位的內容
  result=DlgSet(dlg,IDC_X_MIN,'-5.00')
  result=DlgSet(dlg,IDC_X_MAX,' 5.00')
  result=DlgSet(dlg,IDC_Y_MIN,'-5.00')
  result=DlgSet(dlg,IDC_Y_MAX,' 5.00')
  result=DlgSet(dlg,IDC_LINES,'500')

  return
end subroutine  
!
! 畫出所傳入的函數圖形來
!
subroutine Draw_Func(func)
use DFLIB
use Global
implicit none
  integer :: result			! 取回繪圖函數運作狀態
  integer(kind=2) :: color	! 設定顏色用
  real(kind=8) :: step		! 迴圈的增量
  real(kind=8) :: x,y		! 繪圖時使用,每條小線段都連接
  real(kind=8) :: NewX,NewY	! (x,y)及(NewX,NewY)
  real(kind=8), external :: func ! 待繪圖的函數
  type(wxycoord) :: wt		! 傳回上一次的邏輯座標位置

  call ClearScreen($GCLEARSCREEN) ! 清除螢幕
  ! 設定邏輯座標範圍大小	
  result=SetWindow( .true. , X_Start, Y_Top, X_End, Y_Buttom )

  ! 使用全彩RGB 0-255的256種色階來設定顏色
  color=RGBToInteger(255,0,0)		! 把控制RGB的三個值濃縮到color中
  result=SetColorRGB(color)			! 利用color來設定顏色

  call MoveTo_W(X_Start,0.0_8,wt)	! 畫X軸
  result=LineTo_W(X_End,0.0_8)		! 
  call MoveTo_W(0.0_8,Y_Top,wt)		! 畫Y軸
  result=LineTo_W(0.0_8,Y_Buttom)	! 	

  step=(X_End-X_Start)/lines		! 計算小線段間的X間距
  ! 參數#FF0000是使用16進位的方法來表示一個整數
  result=SetColorRGB(#FF0000)		 
  
  ! 開始繪製小線段們
  do x=X_Start,X_End-step,step
    y=func(x)		! 線段的左端點
	NewX=x+step		
	NewY=func(NewX)	! 線段的右端點
	call MoveTo_W(x,y,wt)
	result=LineTo_W(NewX,NewY)
  end do
  
  ! 設定程式結束後,視窗會繼續保留
  result=SetExitQQ(QWIN$EXITPERSIST)
end subroutine Draw_Func
!
! 所要繪圖的函數
!
real(kind=8) function f1(x)
implicit none
  real(kind=8) :: x
  f1=sin(x)
  return
end function f1

real(kind=8) function f2(x)
implicit none
  real(kind=8) :: x
  f2=cos(x)
  return
end function f2
