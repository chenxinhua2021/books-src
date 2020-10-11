program ex0712
implicit none
  integer :: i
  real :: income(10)=(/ 250000, 300000, 500000, 400000, 350000, &
                        600000, 270000, 450000, 280000, 700000 /)
  real :: tex(10)=0
  
  where( income < 300000.0 )
    tex = income*0.10
  elsewhere( income < 500000.0 )
    tex = income*0.12
  elsewhere
    tex = income*0.15
  end where
     
  write(*,"(10(F8.1,1X))") tex

  stop
end

