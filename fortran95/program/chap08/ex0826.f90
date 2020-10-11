program  ex0826
  implicit none
  interface
    subroutine sub(a,b) ! ﹚竡捌祘Αsubㄏノざ
    implicit none
    integer :: a
    integer, optional :: b
    end subroutine sub
  end interface

  call sub(1)   ! ㄏノ1把计
  call sub(2,3) ! ㄏノ2把计
  stop
end program ex0817

subroutine sub(a,b)
  implicit none
  integer :: a
  integer, optional :: b
  write(*,*) present(a)
  if ( present(b) ) then ! Τ肚b
    write(*,"('a=',I3,' b=',I3)") a,b ! 
  else                   ! ⊿Τ肚b
    write(*,"('a=',I3,' b=unknown')") a
  end if
  return
end subroutine sub
