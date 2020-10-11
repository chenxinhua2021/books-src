program ex0502
implicit none
  real(kind=4) :: height ! 記錄身高
  real(kind=4) :: weight ! 記錄體重

  write(*,*) "height:"
  read(*,*)   height     ! 讀入身高
  write(*,*) "weight:"
  read(*,*)   weight     ! 讀入體重
	
  if ( weight > height-100 ) then 
    ! 如果體重大於身高減去100, 會執行下面的程式
    write(*,*) "Too fat!"
  else
    ! 如果體重不大於身高減去100, 會執行下面的程式
    write(*,*) "Under control."
  end if

stop
end