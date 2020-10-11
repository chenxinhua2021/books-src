module NumLink                          
  implicit none
  integer, parameter :: N=10    
  ! 宣告製作串列的型態
  type :: link
    integer :: num                      ! 儲存數據組
    type(link), pointer :: next         ! 指向下一個環結的指標
  end type link

  type(link), target  :: linking(N) ! 儲存hashing後的資料
  type(link), pointer :: proc      ! 暫時使用的指標

  integer :: Source(N) = (/ 21,53,71,19,61,81,3,17,44,93 /)

contains
  subroutine InitLink()
    integer i
	do i=1,N
	  linking(i)%num = 0
	  nullify(linking(i)%next)
	end do
  end subroutine

! hash函數
  integer function hash(KEY)
    integer KEY
    hash = KEY/10+1
	return
  end function
!
! 把數字經過雜湊處理後放入串列的副程式
!
  subroutine Insert(KEY, INFO)
    integer :: KEY, INFO ! 所要插入的數字及在Source中的位置
    integer :: L         ! hashing 後的結果

    L=hash(KEY)        
    proc=>linking(L) ! 把proc指向陣列linking中hash(L)的位置

    ! 移動到串列中的最後一個位置
    do while( proc%num /= 0 )
      proc=>proc%next
    end do

    proc%num = INFO
    !配置記憶體空間給proc%next
    allocate(proc%next)
	proc=>proc%next
    proc%num = 0
	nullify(proc%next)
  end subroutine Insert 
!
! 在串列中搜尋資料的副程式
!
  subroutine Hash_Search( KEY )
    integer :: KEY  ! 要搜尋的值
    integer :: L    ! 計算hashing後的值

    L=hash(KEY)
    proc=>linking(L)        ! 把proc指向陣列linking中hash(L)的位置

    ! 在這一個串列中一直向下循序搜尋到找到為止
    do while( .true. )
	  if ( proc%num==0 ) then
	    write(*,*) "Not found."
		return
	  end if
	  if ( Source(proc%num)==KEY ) then
	    write(*,"('Source(',I2,' )=',I3)") proc%num, KEY
		return
	  end if
	  if ( associated(proc%next) ) proc=>proc%next
    end do
    return
  end subroutine Hash_Search
!
! 輸出串列中資料的副程式
!
  subroutine OutputLink()
    integer :: i 
    do i=1,N
      proc=>linking(i)
      write(*,"(1X,I2,':')", advance="NO") i
      do while( associated(proc%next) )
        write(*,"('->',I2)", advance="NO" ) Source(proc%num)
        proc=>proc%next
      end do
      write(*,*)
    end do
  end subroutine OutputLink

end module NumLink
!       
!    雜湊搜尋法示範
!                  
program HASHING_SEARCH_DEMO
use NumLink
implicit none
  integer :: KEY  ! 記錄所要找的值
  integer :: I    ! 迴圈記數器

  call InitLink()
  write(*,"('Source=>',10I3)") Source
  do I=1,N
    call Insert( Source(I), I )
  end do
  write(*,*) 'Link List=>'
  call OutputLink()
! 讀入要找的值
  write(*,*) 'Input KEY:'
  read (*,*) KEY
! 呼叫循序搜尋的副程式
  call Hash_Search(KEY)
  stop
end program HASHING_SEARCH_DEMO
