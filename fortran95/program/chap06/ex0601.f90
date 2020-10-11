program ex0601
implicit none
  integer counter
  integer, parameter :: lines=10
  ! counter<=lines之前會一直重複迴圈
  ! 每跑一次迴圈counter會累加1
  do counter=1,lines,1
    write(*,*) "Happy Birthday",counter
  end do

  stop
end
