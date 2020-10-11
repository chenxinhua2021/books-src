! Interactive的繪圖示範
! By Perng 1997/9/20
program Plot_Sine
use DFLIB
implicit none
  logical :: result
  integer :: input		
  type(WindowConfig) :: wc
  real(kind=8), external :: f1,f2,f3	! 所要繪的函數
  ! 開啟輸入用的視窗
  open(unit=5,file='user',iofocus=.true.)
  ! -1 代表由程式自行去做決定
  wc.numxpixels=300 ! 視窗的寬
  wc.numypixels=300 ! 視窗的高
  wc.numtextcols=-1 ! 每行可容納的文字
  wc.numtextrows=-1 ! 可以有幾列文字
  wc.numcolors=-1	! 可以使用的顏色
  wc.title="Input Area"C ! 視窗的標題文字
  wc.fontsize=-1	! 所使用的文字大小
  ! 根據wc中所定義的資料來重新設定視窗大小
  result=SetWindowConfig(wc) 
  result=DisplayCursor($GCURSORON) ! 顯現出游標
  ! 開啟繪圖所要使用的視窗
  open(unit=10,file='user',iofocus=.true.)
  wc.numxpixels=300 ! 視窗的寬
  wc.numypixels=300 ! 視窗的高
  ! -1代表讓程式自行去做決定
  wc.numtextcols=-1	! 每行容量的文字
  wc.numtextrows=-1	! 可以有幾列文字
  wc.numcolors=-1	! 使用多少顏色
  wc.title="Plot Area"C ! 視窗的標題
  wc.fontsize=-1
  ! 根據wc中所定義的資料來重新設定視窗大小
  result=SetWindowConfig(wc)
  ! 程式自我按下選單中Windows的Tile指令, 使兩個視窗之間
  ! 不會互相重疊
  result=ClickMenuQQ(QWIN$TILE) 
  input=1 ! 隨便給一個合理的值, 不然不能進入下面的迴圈
  ! 把輸入使用的視窗設為可以被輸入的狀態, 5就是第一次開啟
  ! user時所用的unit值
  result=FocusQQ(5) 
  do while( input>0 .and. input<4 )
    write(5,*) '(1) Plot f(x)=sin(x)'
	write(5,*) '(2) Plot f(x)=cos(x)'
	write(5,*) '(3) Plot f(x)=(x+2)*(x-2)'
	write(5,*) 'Other to EXIT'
	read(5,*) input
	result=SetActiveQQ(10) ! 把繪圖指令指定到繪圖視窗的代碼上
	! 根據input來決定要畫出那一個函數
	select case(input)
	case (1)
	  call Draw_Func(f1)
	case (2)
	  call Draw_Func(f2)
	case (3)
	  call Draw_Func(f3)
	end select
  end do
  ! 設定主程式碼結束後,視窗會自動關閉
  result=SetExitQQ(QWIN$EXITNOPERSIST)
end program Plot_Sine

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
! 所要繪圖的函數
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
real(kind=8) function f3(x)
implicit none
  real(kind=8) :: x
  f3=(x+2)*(x-2)
  return
end function f3