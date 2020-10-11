program main
  implicit none
  integer day
  character(len=20) :: tv

  write(*,*) "請輸入星期幾"
  read(*,*) day

  select case(day)
  case(1,4)
    tv = "新聞"
  case(2,5)
    tv = "日劇"
  case(3,6)
    tv = "卡通"
  case(7)
    tv = "長片"
  case default
    write(*,*) "錯誤的輸入"
	stop
  end select 
  write(*,*) tv

end program