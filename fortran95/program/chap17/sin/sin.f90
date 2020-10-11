! sin函數的繪圖示範
program Plot_Sine
 use DFLIB
implicit none
  integer, parameter :: lines=500	! 用多少線段來畫函數曲線
  real(kind=8), parameter :: X_Start=-5.0	! x軸最小範圍
  real(kind=8), parameter :: X_End=5.0		! x軸最大範圍	
  real(kind=8), parameter :: Y_Top=2.0		! y軸最大範圍 
  real(kind=8), parameter :: Y_Bottom=-2.0	! y軸最小範圍
  integer :: result			! 取回繪圖函數運作狀態
  integer(kind=2) :: color	! 設定顏色用
  real(kind=8) :: step		! 迴圈的增量
  real(kind=8) :: x,y		! 繪圖時使用,每條小線段都連接
  real(kind=8) :: NewX,NewY	! (x,y)及(NewX,NewY)
  real(kind=8), external :: f ! 待繪圖的函數
  type(wxycoord) :: wt		! 傳回上一次的邏輯座標位置
  type(xycoord)  :: t		! 傳回上一次的實際座標位置

  ! 設定邏輯座標範圍大小	
  result=SetWindow( .true. , X_Start, Y_Top, X_End, Y_Bottom )
  ! 用索引值的方法來設定顏色
  result=SetColor(2)   ! 內定的2號是應該是綠色
  call MoveTo(10,20,t) ! 移動畫筆到視窗的(10,20)
  call OutGText("f(x)=sin(x)")  ! 寫出內容
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
    y=f(x)			! 線段的左端點
	NewX=x+step		
	NewY=f(NewX)	! 線段的右端點
	call MoveTo_W(x,y,wt)
	result=LineTo_W(NewX,NewY)
  end do
  ! 設定程式結束後,視窗會繼續保留
  result=SetExitQQ(QWIN$EXITPERSIST)
end
! 所要繪圖的函數
real(kind=8) function f(x)
implicit none
  real(kind=8) :: x
  f=sin(x)
  return
end function f