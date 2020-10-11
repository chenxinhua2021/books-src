program ex0808
  implicit none
  real :: a = 1
  real :: b
  real add
  add(a,b) = a+b  ! 直接把函數寫在裏面
  write(*,*) add(a,3.0)
  stop
end
