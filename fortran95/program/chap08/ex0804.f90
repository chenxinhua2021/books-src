program  ex0804
implicit none
  integer :: a = 1
  integer :: b = 2
  call add(a,b)  ! 把變數a及b交給副程式add來處理
  stop
end

subroutine add(first, second)
implicit none
  integer :: first, second ! first,second的內容會從CALL時得到
  write(*,*) first+second
  return
end

