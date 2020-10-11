module NUMERICAL
  implicit none
  real, parameter :: zero=0.00001  ! 小於zero的值會被當成0
contains
! 割線法的函數
  real function newton(a,f,df)
  implicit none
  real :: a	  ! 起始的猜值
  real, external :: f	! 傳入的求值函數
  real, external :: df  ! f'(x)的函數
  real :: b	  ! 逼近得到解
  real :: fb  ! 記錄f(a),f(b),f(c)

  b = a-f(a)/df(a)
  fb= f(b)
! 在驅近於0 之前要一直做逼近的工作
  do while( abs(fb) > zero )
	a=b
	b=a-f(a)/df(a)
    fb=f(b)
  end do
  newton=b
  return
  end function newton
  ! 求值的函數
  real function func(x)
    implicit none
    real :: x
    func=sin(x)
    return
  end function func
  ! func'(x)
  real function dfunc(x)
    implicit none
    real :: x
    dfunc=cos(x)
    return
  end function dfunc
end module NUMERICAL

program main
  use numerical
  implicit none
  real :: a	  ! 起始猜值
  real :: ans ! 解
  write(*,*) "輸入起始猜值"
  read (*,*) a
  ! 傳入起始猜值及求值的函數
  ans=newton(a,func,dfunc)
  write(*,"('x=',F8.4)") ans
  stop
end program
