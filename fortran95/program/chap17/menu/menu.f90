! 使用選單示範
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
  result=AppendMenuQQ(3,$MENUENABLED,'&Exit'C,WINEXIT)

  InitialSettings=.true.
  return
end function InitialSettings
!
! 畫sin的副程式
!
subroutine PlotSin(check)
use DFLIB
implicit none
  logical(kind=4) :: check
  real(kind=8), external :: f1
  integer :: result
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
implicit none
  logical(kind=4) :: check
  real(kind=8), external :: f2
  integer :: result
  check=.true.
  ! 把選項sin前的勾取消
  result=ModifyMenuFlagsQQ(2,1,$MENUUNCHECKED)
  ! 在選項cos前打個勾
  result=ModifyMenuFlagsQQ(2,2,$MENUCHECKED)
  call Draw_Func(f2)
  return
end subroutine
!
! 畫出所傳入的函數圖形來
!
subroutine Draw_Func(func)
use DFLIB
implicit none
  integer, parameter :: lines=500	! 用多少線段來畫函數曲線
  real(kind=8), parameter :: X_Start=-5.0	! x軸最小範圍
  real(kind=8), parameter :: X_End=5.0		! x軸最大範圍	
  real(kind=8), parameter :: Y_Top=5.0		! y軸最大範圍 
  real(kind=8), parameter :: Y_Bottom=-5.0	! y軸最小範圍
  integer :: result			! 取回繪圖函數運作狀態
  integer(kind=2) :: color	! 設定顏色用
  real(kind=8) :: step		! 迴圈的增量
  real(kind=8) :: x,y		! 繪圖時使用,每條小線段都連接
  real(kind=8) :: NewX,NewY	! (x,y)及(NewX,NewY)
  real(kind=8), external :: func ! 待繪圖的函數
  type(wxycoord) :: wt		! 傳回上一次的邏輯座標位置
  type(xycoord)  :: t		! 傳回上一次的實際座標位置

  call ClearScreen($GCLEARSCREEN) ! 清除螢幕
  ! 設定邏輯座標範圍大小	
  result=SetWindow( .true. , X_Start, Y_Top, X_End, Y_Bottom )
  ! 用索引值的方法來設定顏色
  result=SetColor(2)   ! 內定的2號是應該是綠色
  call MoveTo(10,20,t) ! 移動畫筆到視窗的(10,20)
  
  ! 使用全彩RGB 0-255的256種色階來設定顏色
  color=RGBToInteger(255,0,0)		! 把控制RGB的三個值濃縮到color中
  result=SetColorRGB(color)			! 利用color來設定顏色

  call MoveTo_W(X_Start,0.0_8,wt)	! 畫X軸
  result=LineTo_W(X_End,0.0_8)		! 
  call MoveTo_W(0.0_8,Y_Top,wt)		! 畫Y軸
  result=LineTo_W(0.0_8,Y_Bottom)	! 	

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
