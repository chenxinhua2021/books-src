program  ex0801
implicit none
  call message() ! 呼叫副程式message
  call message()
  stop
end 
! 副程式message
subroutine message()
implicit none
  write(*,*) "Hello."
  return
end