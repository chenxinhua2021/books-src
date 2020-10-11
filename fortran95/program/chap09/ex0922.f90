program ex0922
  use typedef
  implicit none
  integer, parameter :: recl_unit = 4
  integer, parameter :: buffer_size = 256*256
  character :: cbuffer(buffer_size)
  integer   :: ibuffer(buffer_size)
  integer   :: error, i, code

  open(10, file="lena.raw", form="unformatted", access="direct",&
       recl=256*256/recl_unit, status="old", iostat=error)
  if ( error/=0 ) then
    write(*,*) "open lena.raw fail."
	stop
  end if
  ! 一個圖素佔1 byte, 剛好可以用字元陣列來讀入
  read(10, rec=1) cbuffer
  close(10)

  do i=1, buffer_size
    ! 要取出每個字元的數值
    code = ichar( cbuffer(i) )
	! code傳回值會是-128～127之間，要把它轉換成0～255之間的數字
    if ( code>=0 ) then
      ibuffer(i)=code
	else
	  ibuffer(i)=256+code
	end if
  end do
  ! 把亮度值反相
  do i=1, buffer_size
    cbuffer(i)=char(255-ibuffer(i))
  end do
  ! 檔案代碼10在上面已經close了, 可以再使用一次
  open(10, file="newlena.raw", form="unformatted", access="direct",&
        recl=256*256/recl_unit, status="replace")
  write(10, rec=1) cbuffer
  close(10)

  stop
end