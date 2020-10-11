program ex0807
implicit none
  real :: a=1
  real :: b=2
  real, external :: add

  write(*,*) add(a,b)
  stop
end

function add(a,b)
implicit none
  real :: a,b ! 傳入的參數
  real :: add 
  ! add跟函數名稱一樣，這邊不是用來宣告變數，
  ! 是宣告這個函數會傳回的數值型態
  add = a+b
  return
end