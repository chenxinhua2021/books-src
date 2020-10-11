program ex0816
implicit none
  integer :: a(5) = (/ 1,2,3,4,5 /)
  call ShowOne(a)   ! 傳入a, 也就是傳入陣列a第1個元素的記憶體位址
  call ShowArray5(a)  
  call ShowArray3(a)  
  call ShowArray3( a(2) ) ! 傳入a(2), 也就是傳入陣列a第2個元素的記憶體位址
  call ShowArray2X2(a)  
  stop
end

subroutine ShowOne(num)
implicit none
  integer :: num ! 只取出參數位址中的第1個數字
  write(*,*) num
  return
end

subroutine ShowArray5(num)
implicit none
  integer :: num(5) ! 取出參數位址中的前5個數字,當成陣列來使用
  write(*,*) num
  return
end

subroutine ShowArray3(num)
implicit none
  integer :: num(3) ! 取出參數位址中的前3個數字,當成陣列來使用
  write(*,*) num
  return
end

subroutine ShowArray2X2(num)
implicit none
  integer :: num(2,2) ! 取出參數位址中的前4個數字,當成2X2陣列來使用
  write(*,*) num(2,1), num(2,2)
  return
end