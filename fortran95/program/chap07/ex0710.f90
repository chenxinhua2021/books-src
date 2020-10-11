program ex0710
implicit none
  integer :: i
  integer :: a(5)=(/ (i,i=1,5) /)
  integer :: b(5)=0
  
  ! 把a(1～5)中小於3的元素值設定給b
  where( a<3 )
    b = a
  end where
     
  write(*,"(5(I3,1X))") b
  stop
end

