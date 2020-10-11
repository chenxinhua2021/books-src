program ex0822
  implicit none
  external sub1, sub2 ! 宣告sub1跟sub2是副程式名稱
  call sub(sub1)      ! 把副程式sub1當參數傳出去
  call sub(sub2)      ! 把副程式sub1當參數傳出去
  stop
end program

subroutine sub(sub_name)
  implicit none
  external sub_name ! 宣告sub_name是個副程式
  call sub_name()   ! 呼叫傳入的副程式sub_name
  return
end subroutine

subroutine sub1()
  implicit none
  write(*,*) "sub1"
end subroutine

subroutine sub2()
  implicit none
  write(*,*) "sub2"
end subroutine
