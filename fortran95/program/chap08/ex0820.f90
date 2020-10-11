program ex0820
implicit none
  call sub()
  call sub()
  call sub()
  stop
end program

subroutine sub()
  implicit none
  integer :: count = 1
  save    count      ! 指定count變數會永遠活著, 不會忘記它的內容
  write(*,*) count
  count = count+1
  return
end