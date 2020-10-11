! 選擇排序法示範
! By Perng 1997/8/29
program SELECTION_SORT_DEMO
  implicit none
  integer, parameter :: N=10
  integer :: A(N)=(/6,2,8,4,0,9,3,5,1,7/) ! 排序的資料

  write(*,"('Source=>',10I3)") A
  call SELECTION_SORT(A,N)      ! 呼叫排序的副程式
  write(*,"('Sort=>',10I3)") A
  
  stop
end program
!
! 選擇排序法的副程式
!
subroutine SELECTION_SORT(A,N)
  implicit none
  integer :: N,A(N)
  integer I,J  ! 迴圈計數器
  integer MIN  ! 找出每一輪中的最小值
  integer TEMP ! 交換資料時使用

  do I=1,N
    MIN=A(I)     ! 暫時令A(I)是最小值
    do J=I+1,N
      if ( MIN > A(J) ) then   ! 發現A(I)不是最小
        TEMP=A(J)        ! 把A(I)、A(J)交換
        A(J)=A(I)
        A(I)=TEMP
        MIN=A(I)
      end if
	end do
  end do
                              
  return
end subroutine                
        
