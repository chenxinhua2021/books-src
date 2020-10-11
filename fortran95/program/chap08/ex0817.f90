program ex0817
implicit none
  integer, parameter :: size = 5
  integer :: s = size
  integer :: a(size) = (/ 1,2,3,4,5 /)
  call UseArray1(a,size) ! 把常數size傳入做陣列大小
  call UseArray1(a,s)    ! 把一般變數s 傳入做陣列大小
  call UseArray2(a)      ! 不傳入陣列大小
  call UseArray3(a)
  stop
end

subroutine UseArray1(num, size)
implicit none
  integer :: size 
  integer :: num(size) ! 傳入的陣列大小可用變數來指定
  write(*,*) num
  return
end

subroutine UseArray2(num)
implicit none
  integer :: num(*) ! 不指定陣列大小
  integer :: i
  write(*,*) (num(i), i=1,5) 
  ! 如果傳入的陣列大小少於5, write在執行時會出現錯誤
  return
end

subroutine UseArray3(num)
implicit none
  integer :: num(-2:2) ! 可以重新定義陣列座標範圍
  write(*,*) num(0)
  return
end
