module datas
  implicit none
  integer, parameter :: N=5
  real :: temperature(N) = (/5.0,10.0,15.0,20.0,25.0/)  ! 癘魁放
  real :: length(N) = (/1.047,1.112,1.1152,1.191,1.252/)! 癘魁ぃ放
  real, save :: A,B  ! ㄧ计L=At+B╰计
end module

module sgl_util
  use datas
  use sgl
  implicit none
  real, parameter :: xmin = 0.0, xmax = 30.0
  real, parameter :: ymin = 0.5, ymax = 1.5
contains
  subroutine display()
    real, parameter :: xsize = 0.3, ysize=0.01
	real xs, ys, xe, ye
	real l,x
	l(x) = A*x+B
    integer i
	call sglClearBuffer()
	xs = xmin
	ys = l(xs)
	xe = xmax
	ye = l(xe)
	call sglColor3i(255,255,255)
    call sglLineV(xs,ys, xe,ye)
	call sglColor3i(255,0,0)
	do i=1,N
	  call sglLineV( temperature(i)-xsize, length(i)-ysize, &
	                 temperature(i)+xsize, length(i)+ysize  )
	  call sglLineV( temperature(i)+xsize, length(i)-ysize, &
	                 temperature(i)-xsize, length(i)+ysize  )
	end do
	call sglUpdateBuffer()
  end subroutine
end module

! 程よ畉猭ボ絛
program main
  use sgl_util
  implicit none
  ! ㊣程よ畉猭捌祘Αㄓ璸衡╰计A,B
  call least_square(temperature, length, N, A, B)
  write(*,"('A=',F6.4,' B=',F6.4)") A,B

  call sglSetVirtual(xmin, ymax, xmax, ymin)
  call sglDisplaySub(display)
  call sglCreateWindow(100,100,400,400,1)
  call sglMainLoop()

  stop
END

subroutine least_square(x, y, n, s, t)
  implicit none
  integer n
  real x(n)   ! x计沮翴
  real y(n)   ! y计沮翴
  real s,t    ! ┮璶璸衡╰计
  real A,B,C,D,E,F  ! 羛ミよ祘Αい╰计
  integer I         ! 癹伴璸计竟
  ! 秆 As+Bt=E いゼ计s,t
  !      Cs+Dt=F  
  ! 砞﹚A,B,C,D,E,F╰计
  A = 0; B = 0; E = 0; F = 0
  do I=1,N
    A=A+X(I)*X(I) 
    B=B+X(I)              
    E=E+X(I)*Y(I) 
    F=F+Y(I)              
  END DO
  C=B
  D=N
  ! じΩよ祘ΑΤそΑ秆
  S=(B*F-E*D)/(B*C-A*D)
  T=(E*C-A*F)/(B*C-A*D)
  return
end subroutine
