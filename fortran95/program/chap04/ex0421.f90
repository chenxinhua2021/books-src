program ex0421
  integer   a
  real      b
  complex   c
  logical   d
  character(len=20) e
  a=10
  b=12.34
  c=(1,2)
  d=.true.
  e="FORTRAN"
  write(*,"(1X,I5)")    a  ! 用I來格式化整數
  write(*,"(1X,F5.2)" ) b  ! 用F來格式化浮點數
  write(*,"(1X,F4.1,F4.1)" ) c ! complex也是浮點數
  write(*,"(1X,L3)") d  ! 用L來輸出logical
  write(*,"(1X,A10)") e ! 用A來輸出字串
end
