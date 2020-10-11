program ex0916
  implicit none
  integer i
  integer, external :: GetInteger
  i = GetInteger()
  write(*,*) i
  stop
end program

integer function GetInteger()
  implicit none
  character(len=80) :: string
  logical :: invalid
  integer i, code

  invalid = .true.
  do while( invalid )
    write(*,*) "請輸入正整數"
    read(*, "(A80)" ) string
    invalid = .false.
    do i=1, len_trim(string)
	  ! 檢查輸入的字元是否包含'0'～'9'以外的字元
      code = ichar(string(i:i))
      if ( code<ichar('0') .or. code>ichar('9') ) then 
	    invalid=.true.
		exit
	  end if 
    end do
  end do

  read( string, * ) GetInteger
  return
end function