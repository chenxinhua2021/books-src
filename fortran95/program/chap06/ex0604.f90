program ex0604
implicit none
  integer, parameter :: limit=10  ! 計數器的上限
  integer counter      ! 計數器
  integer :: ans = 0   ! 拿來累加使用

  counter = 2  ! 設定計數器初值
  do while( counter <= limit )
    ans = ans + counter
    counter = counter + 2  ! 計數器累加
  end do

  write(*,*) ans

  stop
end
