program ex0432
implicit none
  integer :: a=1
  integer :: b=2
  real    :: c
  c=real(a)/real(b) ! 經由庫存函式real把整數轉型成浮點數 
  write(*,"(F5.2)") c 
end
