program  ex0829
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
  integer, save :: count = 1
  integer :: localcount, temp  ! 局部變數
    
  localcount = count
  count = count+1
  write(6,"(I2,'th enter, n=',I2)") localcount, n

  if ( n < 0 ) then ! 不合理的輸入
	ans = -1        ! 隨便設定一個值
    write(6,"(I2,'th exit, n=',I2,' ans=',I8)") localcount, n, ans
	return          ! n不合理, 直接return 
  else if ( n <= 1 ) then
    ans = 1          
    write(6,"(I2,'th exit, n=',I2,' ans=',I8)") localcount, n, ans
    return          ! 不用再向下遞迴了, return 
  end if
  ! 會執行到這, 代表n>1, 從n*(n-1)!來計算n!
  temp = n-1
  ans = n * fact(temp) 
  write(6,"(I2,'th exit, n=',I2,' ans=',I8)") localcount, n, ans
  return
end
