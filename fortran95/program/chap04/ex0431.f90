program ex0431
implicit none
  integer :: a=1
  integer :: b=2
  real    :: c
  c=a/b 
! c=1/2=0, 雖然c是浮點數,但因為a,b是整數,計算a/b時會用整數去計算.
  write(*,"(F5.2)") c 
end
