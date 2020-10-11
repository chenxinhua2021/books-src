program main
  implicit none
  integer, parameter :: answer = 45
  integer, parameter :: max = 5
  integer weight, i
  
  do i=1,max
    write(*,*) "請輸入體重"
	read(*,*) weight
	if ( weight==answer ) exit
  end do

  if ( i<=max ) then
    write(*,*) "猜對了"
  else
    write(*,*) "猜錯了"
  end if

  stop
end program
