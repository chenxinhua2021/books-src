program ex0407
  real :: a ! 宣告浮點數型態變數a
  a = 2.5+3/2
  write(*,*) '2.5+3.0/2.0=', A ! A和a指的是同一個變數
  stop
end
