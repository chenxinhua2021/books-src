program main
  implicit none
  real, parameter :: PI=3.14159
  real radius
  write(*,*) "請輸入半徑長"
  read(*,*) radius
  write(*,"(' 面積='f8.3)") radius*radius*PI
end program

