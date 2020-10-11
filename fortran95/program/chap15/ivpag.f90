! IMSL IVPAG示範
! 求解Y'(t)=-0.01*Y(t)
! initial value Y(0)=2
program main
  use IMSL
  implicit none
  integer, parameter :: MXPARM = 50
  integer, parameter :: N = 1
  integer IDO, ISTEP, NOUT
  real A(1,1)
  real PARAM(MXPARM), T, TEND, Y(N)
  real, parameter :: TOL = 1E-3
  external FCN, FCNJ

  PARAM = 0  ! 令IVPAG計算過程的設定完全使用內定值
  WRITE (*,"(' Time', 9X,'Y')")
  Y(1) = 2.0 ! Initial value Y(T)=2.0
  T = 0.0    ! Initial value Y(T)=2.0中的時間T值
  IDO = 1
  do ISTEP=10,100,10
    TEND = ISTEP
	call IVPAG(IDO, N, FCN, FCNJ, A, T, TEND, TOL, PARAM, Y)
    write (*,'(F5.1,F12.4)') T, Y
  end do
  call IVPAG(3, N, FCN, FCNJ, A, T, TEND, TOL, PARAM, Y) ! 釋放記憶體

  stop
end program
! 計算微分方程式
! YPRIME=Y'=f(t,y)
subroutine FCN (N, T, Y, YPRIME)
  implicit none
  integer N
  real T, Y(N), YPRIME(N)
  real, parameter :: K=-1E-2
  ! Y' = K*Y
  YPRIME(1) = K*Y(1)
  return
end subroutine
! 在這邊不計算Jacobian值
! 所以函數FCNJ完全不做事
! 實際使用時, 要在DYPDY中傳回計算結果
subroutine FCNJ(N, T, Y, DYPDY)
  implicit none
  integer N
  real T, Y(N), DYPDY(N)
  return
end subroutine