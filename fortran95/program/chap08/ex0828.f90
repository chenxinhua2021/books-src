program  ex0828
  implicit none
  integer :: n
  integer, external :: fact
  write(*,*) 'N='
  read(*,*) n
  write(*, "(I2,'! = ',I8)" ) n, fact(n)
  stop
end

recursive integer function fact(n) result(ans)
  implicit none
  integer , intent(in) :: n
  
  if ( n < 0 ) then ! 不合理的輸入
	ans = -1        ! 隨便設定一個值
	return          ! n不合理, 直接return 
  else if ( n <= 1 ) then
    ans = 1          
    return          ! 不用再向下遞迴了, return 
  end if
  ! 會執行到這, 代表n>1, 從n*(n-1)!來計算n!
  ans = n * fact(n-1) 
  return
end
