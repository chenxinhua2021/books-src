! 氣泡排序法示範
! By Perng 1997/8/29
program BUBBLE_SORT_DEMO
  implicit none
  integer, parameter :: N=10
  integer :: A(N)=(/6,2,8,4,0,9,3,5,1,7/) ! 待排序的資料
  write(*,"('Source=>',10I3)") A
  call BUBBLE_SORT(A,N)  ! 呼叫排序的副程式
  write(*,"('Sort=>',10I3)") A
  stop
end program

subroutine BUBBLE_SORT(A,N)
  implicit none
  integer :: N,A(N)
  integer I,J, TEMP
  do I=N-1,1,-1   ! 開始做N-1次的掃瞄
    do J=1,I      ! 一對一對的來比較，I之後的數字不用比較
    ! 如果A(J) > A(J+1) 就把這兩個數值交換
      if ( A(J) > A(J+1) ) then
        TEMP=A(J)
        A(J)=A(J+1)
        A(J+1)=TEMP
      end if
    end do
  end do
  return
end subroutine
