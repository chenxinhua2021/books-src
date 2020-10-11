program main
  implicit none
  real grades
  write(*,*) "請輸入成績"
  read(*,*) grades
  write(*,"(' 調整後成績為 'f8.3)") SQRT(grades)*10.0
end program

