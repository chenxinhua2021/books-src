program ex1002
  implicit none
  integer, pointer :: p   ! 宣告一個可以指向整數的指標　
  allocate(p) ! 配置一塊可以存放integer的記憶體空間給指標p
  p=100       ! 得到記憶體後指標p 可以像一般整數一樣來使用
  write(*,*) p
  stop
end