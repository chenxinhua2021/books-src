program ex0821
  implicit none
  real, external  :: func ! func琌璹ㄧ计
  real, intrinsic :: sin  ! sin琌畐ㄧ计

  call ExecFunc(func)
  call ExecFunc(sin)

  stop
end program

subroutine ExecFunc(f)
  implicit none
  real, external :: f ! 把计f琌ㄧ计
  write(*,*) f(1.0)   ! 磅︽肚ㄧ计f
  return
end 

real function func(num)
  implicit none
  real :: num
  func = num*2
  return
end function