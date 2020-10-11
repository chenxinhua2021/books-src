!	二分法求解
!	By Pon 1997/9/2
module NUMERICAL
  implicit none
  real, parameter :: zero = 0.00001
contains
  real function bisect( A, B )
    implicit none
	real A,B	! 傳入的猜值
	real C		! 用來算(A+B)/2
	real FA		! 記錄F(A)
	real FB		! 記錄F(B)
	real FC		! 記錄F(C)

!	先求出C, F(C)的值
	C = (A+B)/2.0	
	FC = func(C)

!   F(C) 小於 ZERO 時,就視 F(C)=0 , 結束迴圈
	do while( abs(fc) > zero )
	  FA = func(A)
	  FB = func(B)
	  if ( FA*FC < 0 ) then
	  ! f(a)*f(c)<0 ,以a,c值為新的區間
		B=C
		C=(A+B)/2.0
	  else
	  ! 不然就是以b,c為新的區間
		A=C
		C=(A+B)/2.0
	  end if
      ! 求出新的f(c)值
		FC=FUNC(C)
	end do
	bisect = C
	return
	end function
!	求解用的函數
	real function func(X)
	implicit none
	real X
	FUNC=(X+3)*(X-3)
	return
	end function
end module

program main
  use NUMERICAL
  implicit none
  real  A,B		! 兩個猜值
  real  ANS		! 算出的值
  do while(.true.)
	write(*,*) '輸入兩個猜測值'
	read (*,*) A,B
    ! f(a)*f(b) < 0 的猜值才是有效的猜值
	if ( func(A)*func(B) < 0 ) exit
	write(*,*) "不正確的猜值"
  end do
  ! 呼叫二分法求根的函數
  ANS=bisect( A, B )
  ! 寫出結果
  write(*,"('x=',F6.3)") ans
  stop
end

