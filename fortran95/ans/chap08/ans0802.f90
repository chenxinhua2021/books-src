program main
  implicit none
  real radius
  real, external :: CircleArea

  write(*,*) "請輸入半徑長"
  read(*,*) radius
  write(*,"(' 面積 = 'F8.3)") CircleArea(radius)

  stop
end program

real function CircleArea(radius)
  implicit none
  real, parameter :: PI=3.14159
  real radius
  CircleArea = radius*radius*PI
  return
end function
