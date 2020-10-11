program ex1001
  implicit none
  integer, target  :: a=1 ! 宣告一個可以當成目標的變數
  integer, pointer :: p   ! 宣告一個可以指向整數的指標　
  p=>a ! 把指標p指到變數a
  write(*,*) p
  a=2  ! 改變a的值
  write(*,*) p
  p=3  ! 改變指標p指向的記憶體內容
  write(*,*) a
  stop
end