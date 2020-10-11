! 選擇排序法示範
! By Perng 1997/8/29
program SHELL_SORT_DEMO
  implicit none
  integer, parameter :: N=10
  integer :: A(N)=(/6,2,8,4,0,9,3,5,1,7/) ! 排序的資料

  write(*,"('Source=>',10I3)") A
  call SHELL_SORT(A,N)
  write(*,"('Sort=>',10I3)") A

  stop
end program
!
! 選擇排序法的副程式
!
subroutine SHELL_SORT(A,N)
  implicit none
  integer :: N,A(N) ! 傳入的資料
  integer I,J       ! 迴圈計數器
  integer TEMP      ! 交換數值用
  integer K         ! K 值

  K=N/2             ! K 的初值

  do while( K>0 )
    do I=K+1,N
      J=I-K
      do while( J>0 )
      ! 如果A(J)>A(J+K),要交換它們的數值,並往回取出
      ! A(J-K)、A(J)為新的一組來比較。
        if ( A(J) .GT. A(J+K) ) then
          TEMP=A(J)
          A(J)=A(J+K)
          A(J+K)=TEMP
          J=J-K
        else
          exit ! A(J)<A(J+K)時可跳出迴圈
        end if
	  end do
	end do
    K=K/2 ! 設定新的K值
  end do

  return
end subroutine
                
        
