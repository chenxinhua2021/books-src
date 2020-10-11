!
! 二元搜尋法示範
! By Perng 1997/8/31
program BINARY_SEARCH_DEMO
  implicit none
  integer, parameter :: N=10      ! 陣列的大小
  integer :: A(N)=(/2,5,7,9,10,11,13,17,21,23/)
  integer KEY
  integer LOC 
  integer, external :: BINARY_SEARCH

  write(*,"('Source=>',10I3)") A
  write(*,*) 'Input KEY:'
  read (*,*) KEY
  ! 呼叫循序搜尋的副程式
  LOC=BINARY_SEARCH(A,N,KEY)
  if ( LOC/=0 ) then
    write(*,"('A(',I2,' )='I3)") LOC,KEY
  else
    write(*,*) "Not found"
  end if
  
  stop
end program
!
! 二元搜尋法的副程式
!
integer function BINARY_SEARCH(A,N,KEY)
  implicit none
  integer N,A(N)
  integer KEY    ! 所要尋找的值
  integer L      ! 記錄每一個小組的陣列起始位置
  integer R      ! 記錄每一個小組的陣列結束位置
  integer M      ! 記錄每一個小組的陣列中間位置

  ! 一開始的小組範圍就是整個陣列
  L=1                     
  R=N
  M=(L+R)/2
  ! 如果KEY值超出範圍, 鐵定不存在陣列中
  if ( (KEY < A(L)) .OR. (KEY > A(R)) ) then
    BINARY_SEARCH = 0
    return
  end if

  do while( L <= R )
    if ( KEY > A(M) ) then
    ! 如果 key > 中間值，那資料就落在上半部
      L=M+1
      M=(L+R)/2
    else if ( KEY < A(M) ) then
    ! 如果 key < 中間值，那資料就落在下半部
      R=M-1
      M=(L+R)/2
    else if ( KEY .EQ. A(M) ) then
	  BINARY_SEARCH = M
	  return
    end if
  end do

  BINARY_SEARCH = 0
  return
end function
