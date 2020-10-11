! 快速排序法示範
! By Perng 1997/8/30
program QuickSort_Demo
implicit none
  integer, parameter :: N=10
  real :: B(N)
  integer :: A(N)
  
  ! 用亂數來產生數列
  call random_seed()
  call random_number(B)
  A = B*100
  write(*,"('Source=>',10I3)") A

  ! 呼叫Quick_Sort時除了要傳入陣列的資訊外,還要給定要排列陣列元素
  ! 的上下限位置範圍. 在此當然是要給 1,N ,表示要從頭排到尾.
  call Quick_Sort(A,N,1,N)
  write(*,"('Sort=>',10I3)") A

  stop
end program QuickSort_Demo
!
! 快速排序法的副程式
!
recursive subroutine Quick_Sort(A,N,S,E)
implicit none
  integer :: N    ! 表示陣列的大小
  integer :: A(N) ! 存放數據的陣列
  integer :: S    ! 傳入的參數, 這一組的陣列起始位置
  integer :: E    ! 傳入的參數, 這一組的陣列結束位置
  integer :: L,R  ! 用來找A(L)>K及A(R)<K時用的
  integer :: K    ! 記錄鍵值A(S)
  integer :: temp ! 交換兩個數值時用的
  ! 首先要先給定L,R的初值. L要從頭開始,E則要從尾開始
  L=S  
  R=E+1
  ! Right值 > Left值 時才有必要進行排序  
  if ( R<=L ) return

  K=A(S)  ! 設定鍵值
  do while(.true.)
    ! 找出A(L)<K的所在
    do while( .true. )
      L=L+1
      if ( (A(L) > K) .or. (L>=E) ) exit
    end do
    ! 找出A(R)>K的所在
    do while( .true. )
      R=R-1
      if ( (A(R) < K) .or. (R<=S) ) exit
    end do
    ! 如果Right 跑到 Left的左邊時, 迴圍就該結束了
    if ( R <= L ) exit
    ! 交換A(L),A(R)的數值
    temp=A(L)
    A(L)=A(R)
    A(R)=temp
  end do
  ! 交換A(S),A(R)的數值
  temp=A(S)
  A(S)=A(R)
  A(R)=temp
  ! 把R之前的數據重新分組,再做排序
  call Quick_Sort(A,N,S,R-1)
  ! 把R之後的數據重新分組,再做排序
  call Quick_Sort(A,N,R+1,E)
  return
end subroutine Quick_Sort
                
