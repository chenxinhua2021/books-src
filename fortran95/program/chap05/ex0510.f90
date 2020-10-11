program ex0510
implicit none
  real :: a
  real :: b = 4.0
  real, parameter :: e = 0.0001

  a=SQRT(b)**2-b ! 理論上a應該要等於0
  
  if ( abs(a-0.0)<=e ) then
	write(*,*) "a等於0"
  else
    write(*,*) "a不等於0"
  end if

  stop
end