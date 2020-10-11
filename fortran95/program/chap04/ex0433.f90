program ex0433
implicit none
  integer :: a=1
  real    :: b=2
  real    :: c
  c=a ! 整數設定給浮點數的動作會自動轉型
  write(*,"(F5.2)") c
  c=a/b ! 因為除數跟被除數型態不同, 計算的結果會以浮點數來表示.
  write(*,"(F5.2)") c 
end
