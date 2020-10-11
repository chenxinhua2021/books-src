program ex0414
  character(len= 6) first
  character(len=10) second
  character(len=20) add
  first="Happy "
  second="Birthday"
  add = first//second ! 經由兩個連續的除號可以連接兩個字串
  write(*,*) add
end
