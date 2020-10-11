! 循序搜尋法示範
! By Perng 1997/8/31
program SEQUENTIAL_SEARCH_DEMO
  implicit none
  integer, parameter :: N=10
  integer :: A(N)=(/6,2,8,4,0,9,3,5,1,7/) ! 存放數據組的陣列
  integer KEY             ! 記錄所要找的值
  integer LOC
  integer, external :: SEQUENTIAL_SEARCH

  write(*,"('Source=>',10I3)") A
  write(*,*) 'Input KEY:'
  read (*,*) KEY                    ! 鍵入待尋資料
  ! 呼叫循序搜尋的函數
  LOC = SEQUENTIAL_SEARCH(A,N,KEY)
  if ( LOC/=0 ) then
    write(*,"('A(',I2,' )='I3)") LOC,KEY
  else
    write(*,*) "Not found"
  end if
  stop
end program
!
! 循序搜尋法的副程式
!
integer function SEQUENTIAL_SEARCH(A,N,KEY)
  implicit none
  integer N, A(N)
  integer KEY             ! 所要尋找的值
  integer I               ! 迴圈的計數器

  do I=1,N  ! 開始做掃瞄, 最多做N次.
    if ( KEY==A(I) ) then
      ! 找到了, 傳回數字在陣列中的位置
	  SEQUENTIAL_SEARCH=I
	  return
	end if
  end do
  ! 沒找到時傳回-1
  SEQUENTIAL_SEARCH=0
  return
end function
