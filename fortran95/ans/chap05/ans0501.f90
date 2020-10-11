program main
  implicit none
  integer money
  real    tax
  
  write(*,*) "請輸入年收入"
  read(*,*) money

  if ( money<240000 ) then
    tax = 0.07
  else if ( money<480000 ) then
    tax = 0.1
  else
    tax = 0.15
  end if
  write(*,"(' 稅金為 'I8)") nint(money*tax)

end program