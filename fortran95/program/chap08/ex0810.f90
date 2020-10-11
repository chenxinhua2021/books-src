program ex0810
implicit none
  integer :: a,b
  common a,b ! 定義a,b是全域變數中的第1及第2個變數
  a=1
  b=2
  call ShowCommon()
  stop
end

subroutine ShowCommon()
implicit none
  integer :: num1, num2
  common num1, num2 ! 定義a,b是全域變數中的第1及第2個變數
  write(*,*) num1, num2
  return
end
