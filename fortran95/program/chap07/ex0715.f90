program ex0715
implicit none
  integer, parameter :: max = 1000
  integer :: a(max) ! 先宣告一個超大的陣列
  integer :: students
  integer :: i
    
  write(*,*) "How many students:"
  read(*,*) students

  ! 輸入成績
  do i=1,students
    write(*,"('Number ',I3)") i
    read(*,*) a(i)
  end do

  stop
end
