program ex0509
implicit none
  real :: a
  real :: b = 3.0

  a=SQRT(b)**2-b ! 理論上a應該要等於0

  if ( a==0.0 ) then
	write(*,*) "a等於0"
  else
    write(*,*) "a不等於0"
  end if

stop
end