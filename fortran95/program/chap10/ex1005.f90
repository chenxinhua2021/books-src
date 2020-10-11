program ex1005
  implicit none
  integer, pointer :: a(:) ! 定義a是一維的指標陣列
  allocate( a(5) )  ! 配置5個整數的空間給指標a
  a = (/ 1,2,3,4,5 /)
  write(*,*) a
  deallocate( a )   ! allocate得到的記憶體要記得歸還
  stop
end
