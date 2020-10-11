module INTEGRAL
  implicit none
  real, parameter :: PI=3.14159
contains
! 產生數列
  subroutine GenerateData(datas, width, func)
    real datas(:), width
	real, external :: func
	real r
	integer i,n
	n = size(datas,1)
	width = PI/(n-1)
	r = 0
	do i=1,n
	  datas(i) = func(r)
	  r = r+width
	end do
  end subroutine
! 梯形法積分
  real function Trape_Integral(datas, width)
    implicit none
    real datas(:)
    real width     ! 每筆資料的間隔
    real SUM       ! 計算所有上底加下底除以二的和
    integer i,n
    n = size(datas,1)
    SUM = (datas(1)+datas(n))/2.0
    do i=2,n-1
      SUM=SUM+datas(i) ! 累加邊長
    end do
    Trape_Integral=SUM*width  ! 計算面積和
    return
  end function 
end module
! 梯形法積分示範
program main
  use INTEGRAL
  implicit none
  integer, parameter :: N = 10
  real DATAS(N), width
  real ANS  ! 答案  
  real, intrinsic :: sin ! 模擬用來產生資料的函數
  call GenerateData(DATAS, width, sin)
  ANS = Trape_Integral(DATAS, width)  ! 計算積分
  write(*,"('ans=',F5.2)") ANS        ! 寫出答案
  stop
end program