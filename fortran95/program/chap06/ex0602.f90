program ex0602
implicit none
  integer, parameter :: limit=10  ! 計數器的上限
  integer counter      ! 計數器
  integer :: ans = 0   ! 拿來累加使用

  do counter=2, limit ,2
    ans = ans + counter
  end do
  write(*,*) ans

  stop
end
