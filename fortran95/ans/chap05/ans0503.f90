program main
  implicit none
  integer age, money
  real tax

  write(*,*) "請輸入年齡"
  read(*,*) age
  write(*,*) "請輸入年收入"
  read(*,*) money

  if ( age<50 ) then
    if ( money<240000 ) then
	  tax = 0.07
	else if ( money<480000 )then
	  tax = 0.10
	else
	  tax = 0.15
	end if
  else
    if ( money<240000 ) then
	  tax = 0.5
	else if ( money<480000 )then
	  tax = 0.7
	else
	  tax = 0.10
	end if
  end if
  
  write(*,"(' 稅金為 'I8)") nint(money*tax)

end program