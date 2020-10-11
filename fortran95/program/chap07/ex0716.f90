program ex0716
implicit none
  integer :: students
  integer, allocatable :: a(:) ! 宣告一個可變大小的一維陣列
  integer :: i
    
  write(*,*) "How many students:"
  read(*,*) students
  allocate( a(students) ) ! 配置記憶體空間

  ! 輸入成績
  do i=1,students
    write(*,"('Number ',I3)") i
    read(*,*) a(i)
  end do

  stop
end
