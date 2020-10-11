program main
  implicit none
  type distance
    real meter, inch, cm
  end type
  type(distance) :: d
  write(*,*) "請輸入長度:"
  read(*,*) d%meter
  d%cm = d%meter*100
  d%inch = d%cm/2.54
  write(*,"(f8.3'公尺 ='f8.3'公分 ='f8.3'英吋')") d%meter, d%cm, d%inch
end program