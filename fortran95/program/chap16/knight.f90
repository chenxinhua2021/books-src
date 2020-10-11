module STACK_UTILITY
  implicit none
  private
  integer, parameter :: TOP=50
  integer, save :: current = 0
  integer, save :: stack(TOP)
  public push, pop
contains
  ! 把資料放入堆疊中  
  subroutine push(value)
    integer value
	if ( current>TOP ) then ! 超過容量
	  write(*,*) "Stack full."
	  return
	end if
	current = current+1
	stack(current)=value
  end subroutine
  ! 從堆疊中取出資料
  integer function pop(value)
    integer value
    if ( current<=0 ) then ! 已經沒有東西可以拿了
	  pop=1
	  return
	end if
	value = stack(current)
	current = current-1
	pop = 0
  end function

end module
!
! 騎士走棋盤的示範
! By Perng 1997/9/1
program knight
  use STACK_UTILITY
  implicit none
  integer, parameter :: n=5 ! 定義棋盤有多大
  integer board(n,n)      ! 記錄棋盤的狀態
  integer, parameter :: total = n*n ! 棋盤有幾個格子要走
  integer x_move(8)       ! 騎士有8 種移動的步法
  integer y_move(8)       !
  integer x_pos,y_pos     ! 騎士目前在棋盤上的位置
  integer x_new,y_new     ! 暫時算出的下一落腳處
  integer move            ! 所要使用的步法
  integer step            ! 完成了多少步
  integer sol             ! 計算總共有幾種走法可以走完
  integer error
  data x_move /1,2, 2, 1,-1,-2,-2,-1/
  data y_move /2,1,-1,-2,-2,-1, 1, 2/
  data board / total*0 /  ! 全設為0 ,代表都還沒走過
  data sol /0/            ! 解的數目先設為0
        
! 假設從棋盤的正中央開始走
  x_pos=(n+1)/2           
  y_pos=(n+1)/2           
  step=1
  board(x_pos,y_pos)=step ! 第一步在此

  move=1        ! 先試第一種走法
  do while(.true.)
    do while( move <= 8 )     ! 因為只有8種走法
      ! 算出下一步
      x_new=x_pos+x_move(move)
      y_new=y_pos+y_move(move)
      ! 不能超出棋盤
      if ( x_new < 1  .or.  x_new > n ) then
        move=move+1
        cycle
      end if
      if ( y_new < 1  .or.  y_new > n ) then
        move=move+1
        cycle
      end if
      ! 當這個下一步的位置是空位時, 才可讓騎士進入
      if ( board(x_new,y_new) == 0 ) then
        x_pos=x_new
        y_pos=y_new
        step=step+1 
        board(x_pos,y_pos)=step ! 成功的踏出下一步
        call push(move)   ! 把目前的步法送入堆疊
        move=1            ! 下一步再從第一種步法開始試
      else
        move=move+1             ! 地點早已來過, 換個新的步法
      end if
    end do
    ! setp=total=n*n 時代表全部都踏遍了
    if ( step == total ) then
      sol=sol+1
      write(*,"('第',I3,'個解')") sol
      call show_board(board,n)
    end if
    ! 往回退一步再向下試
    step=step-1
    ! step<=0 代表無路可退了, 跳出迴圈
    if ( step <= 0 ) exit 
    board(x_pos,y_pos)=0  ! 向回退, 所以這個地方要設成沒來過
    error = pop(move)      ! 從堆疊中取出上一個步法
	if ( error/=0 ) then
	  write(*,*) "Stack empry"
	  stop
	end if
    ! 向回退一步
    x_pos=x_pos-x_move(move)
    y_pos=y_pos-y_move(move)
    ! 換一個新的步法來試試
    move=move+1
  end do
  write(*,"('編共有',I3,'種解法')") sol
  stop
end program
!
! 顯示棋盤狀態的副程式
!
subroutine show_board(board,n)
  implicit none
  integer n
  integer board(n,n)
  integer i,j
  character*(20) :: for = '(??(1x,i3))'
! 用字串來設定輸出格式
  write( for(2:3), '(i2)' ) n
  do i=n,1,-1
    write( *, fmt=for ) board(:,i)
  end do
  return
end
