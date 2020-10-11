!
! 二元樹排序示範
!
module typedef
  implicit none
  type :: data
    integer :: n       ! 存放的資料	
    integer :: repeat  ! 資料重覆的次數
    type(data), pointer :: left  ! 左枝
    type(data), pointer :: right ! 右枝
  end type data
end module typedef

module bin_tree
  use typedef
  implicit none
  private
  type(data), pointer :: tree, action  
  integer, save :: numbers = 0
  public add, TraceTree
contains
!
! 新加入一筆資料
!
subroutine add( n )
  implicit none
  integer, intent(in) :: n
  integer :: err
  type(data), pointer :: new
  integer :: level
  level=1
  numbers=numbers+1
  write(*, '(1x,a5,i4,a8)' ) "Get :",numbers," numbers"
  ! 配置一塊新的空間
  allocate( new, stat=err )
  if ( err/=0 ) then
    write(*,*) "Out of memory!"
    stop
  end if

  write(*,"('root ')", advance="NO")
  ! 設定資料
  new%repeat=1
  new%n=n
  nullify( new%right, new%left )
  ! 如果是第一筆資料
  if ( numbers==1 ) then
    action=>new
    tree=>new
    write(*,"(': new')")
    return
  end if
  
  action=>tree

  do while( .true. )
    level=level+1
	! 資料大於目前枝幹的數值時
    if ( n>action%n ) then
      if ( associated( action%right ) ) then
        action=>action%right  ! 再向右去尋找立身處
		write(*, "('->R')", advance="NO")
      else
        action%right=>new  ! 建立新的右枝 
        action=>new
		write(*, "('->R: new')")
        exit
      end if
    ! 資料小於目前枝幹的數值時
    else if ( n<action%n ) then
      if ( associated( action%left ) ) then
        action=>action%left   ! 再向左去尋找立身處
		write(*, "('->L')", advance="NO")
      else
        action%left=>new  ! 建立新的左枝
        action=>new
		write(*, "('->L: new')")
        exit
      end if
   ! 資料等於目前枝幹的數值時
    else if ( n==action%n ) then
      action%repeat=action%repeat+1  ! 把重覆的數目加1
      deallocate(new)  ! 可以不需要這個新的空間
      write(*, "(': Repeat')")
      return
    end if
  end do
  return
end subroutine add
!
! 顯示排序的資料
!
subroutine TraceTree()
  implicit none
  call show_tree( tree )
  return
end subroutine TraceTree
!
! 排序資料的副程式
!
recursive subroutine show_tree( show )
  implicit none
  type(data), pointer :: show

  if ( associated( show ) ) then
     call show_tree( show%left )   ! 先取出左枝的資料
     call show_data( show )        ! 再取出目前位置的資料
     call show_tree( show%right )  ! 最後才取右枝的資料
  end if

  return
end subroutine show_tree
!
! 寫出這個枝幹所儲存的資料
!
subroutine show_data( show )
  implicit none
  type(data), pointer :: show
  integer :: i

  do i=1,show%repeat
    write(*,*) show%n
  end do

  return
end subroutine show_data

end module bin_tree
!
! 主程式
!
program main
  use bin_tree
  implicit none
  integer num
  
  do while(.true.)
    write(*,*) "請輸入整數, 輸入0代表結束"
    read(*,*) num
	if ( num==0 ) exit
    call add(num)
  end do
  call TraceTree()

  stop
end program main
