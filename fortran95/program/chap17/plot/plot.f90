! 簡單的繪圖示範
! By Perng 1997/9/19
program Plot_Demo
! 使用Visual Fortran的繪圖功能時需要module dflib
use DFLIB	
implicit none
  type(xycoord) :: t
  integer :: result
  call MoveTo(10,10,t)  ! 把目前繪圖的位置移動到座標(10,10)
  result=LineTo(100,50) ! 從(10,10)到(100,50)間繪一條直線
  ! 繪一個左上角為(110,10), 右下角為(150,50)的實心方形
  result=Rectangle( $GFILLINTERIOR, 110,10, 150, 50 )
  ! 繪一個可以放入在(10,60)--(150,100)方形當中的空心橢圓
  result=Ellipse($GBORDER, 10, 60, 150, 100)
end program Plot_Demo
