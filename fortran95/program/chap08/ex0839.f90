program ex0839
  implicit none
  integer :: a

  read(*,*) a
  call sub( a, *100, *200 ) 
  ! 特別另外指定兩個折返點, 分別是行代碼100及200這兩個地方
  write(*,*) "Default"
  stop
  100 write(*,*) "Return 1"
  stop
  200 write(*,*) "Return 2"
  stop 

end 

subroutine sub( a, *, * )
  implicit none
  integer :: a
  if ( a<=0 ) then
    return    ! 返回內定的折返點
  else if ( a==1 ) then
    return 1  ! 返回特別指定的第1個折返點
  else
    return 2  ! 返回特別指定的第2個折返點
  end if
end subroutine