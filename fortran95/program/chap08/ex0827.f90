program  ex0827
  implicit none
  interface
    real function func(x,a,b,c) ! 定義副程式func的使用介面
    implicit none
	real x
    real, optional :: a,b,c
    end function 
  end interface

  write(*,*) func(2.0, c=1.0)        ! F(2)=0*2^2 + 0*2 + 1 = 1
  write(*,*) func(2.0, a=2.0, b=1.0) ! F(2)=2*2^2 + 1*2 + 0 = 10
  stop
end
! 計算func(X)=A*X^2+B*X+C
! A,B,C不傳入的話為0
real function func(x,a,b,c)
  implicit none
  real x  ! x值一定要傳入
  real, optional :: a,b,c ! a,b,c可以不傳入
  real ra, rb, rc         ! 實際計算的數字

  if ( present(a) ) then
    ra=a
  else
    ra=0.0 ! 內定值為0
  end if

  if ( present(b) ) then
    rb=b
  else
    rb=0.0 ! 內定值為0
  end if

  if ( present(c) ) then
    rc=c
  else
    rc=0.0 ! 內定值為0
  end if
  ! func(x)=A*X^2+B*X+C
  func = ra*x**2 + rb*x + rc

  return
end 
