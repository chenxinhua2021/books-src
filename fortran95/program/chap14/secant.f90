module NUMERICAL
  implicit none
  real, parameter :: zero=0.00001  ! 小於zero的值會被當成0
contains
! 割線法的函數
  real function secant(a,b,f)
  implicit none
  real :: a,b ! 起始的兩個猜值
  real :: c	  ! 新的解
  real, external :: f ! 傳入的求解函數
  real :: fa,fb,fc	! 記錄f(a),f(b),f(c)

  fa=f(a)
  fb=f(b)
  c=a-fa*(b-a)/(fb-fa)
  fc=f(c)
! 在驅近於0 之前要一直做逼近的工作
  do while( abs(fc) > zero )
	a=b
	b=c
	fa=f(a)
	fb=f(b)
    c=a-fa*(b-a)/(fb-fa)
    fc=f(c)
  end do
  secant=c
  return
  end function secant
  real function func(x)
    implicit none
    real :: x
    func=sin(x)
    return
  end function func
end module numerical

program main
  use NUMERICAL
  implicit none
  real :: a,b	! 起始猜值
  real :: ans	! 算得的解
  write(*,*) "輸入兩個猜值"
  read (*,*) a,b
  ! 傳入起始猜值及求值的函數
  ans=secant(a,b,func)
  write(*,"('x=',f8.4)") ans
  stop
end program
