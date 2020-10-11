module linklist
  implicit none
  type :: datalink
    integer :: i
    type(datalink), pointer :: prev ! 指向上一筆資料
    type(datalink), pointer :: next ! 指向下一筆資料
  end type datalink

contains

subroutine outputlist( list )
  implicit none
  type(datalink), pointer :: list, p
  p=>list
  do while( associated(p) )
    write(*,*) p%i
    p=>p%next
  end do
  return   
end subroutine
! 把指標所指到的串列位置釋放
subroutine delitem( item )
  implicit none
  type(datalink), pointer :: item
  type(datalink), pointer :: prev, next

  prev=>item%prev  ! 記錄下item上一筆資料的位置
  next=>item%next  ! 記錄下item下一筆資料的位置
  deallocate(item) ! 釋放item所佔用記憶體
  ! 重新設定prev%next, 原本prev%next=>item, 不過item已經刪除了
  if ( associated(prev) ) prev%next=>next
  ! 重新設定next%prev, 原本next%prev=>item, 不過item已經刪除了
  if ( associated(next) ) next%prev=>prev ! 
  item=>next

  return
end subroutine
! 在pos指標所指到的串列位置中插入item
! after=.true.時, item插在pos之後
! after=.false.時, item插在pos之前
subroutine insitem( pos, item, after )
  implicit none
  type(datalink), pointer :: pos, item
  logical :: after
  if ( after ) then
  ! item插在pos的後面
    item%next=>pos%next
	item%prev=>pos
	if ( associated(pos%next) ) then
      pos%next%prev=>item
    end if
    pos%next=>item
  else
  ! item插在pos的前面
    item%next=>pos
	item%prev=>pos%prev
	if ( associated(pos%prev) ) then
	  pos%prev%next=>item
	end if
    pos%prev=>item
  end if
  return
end subroutine

end module

program ex1015
  use linklist
  implicit none
  type(datalink), pointer :: head
  type(datalink), pointer :: item, p
  integer, parameter :: s=5
  integer :: i,n,error
  
  allocate(head)
  head = datalink(1, null(), null() )
  ! 建立串列
  p=>head
  do i=2,s
    allocate( p%next, stat=error )
	if ( error/=0 ) then
	  write(*,*) "Out of memory!"
	  stop
	end if
	p%next=datalink(i, p, null())
	p=>p%next
  end do
  
  write(*,*) "拿掉第3筆資料"
  call delitem(head%next%next)
  call outputlist(head)

  write(*,*) "插入新的第3筆資料"
  allocate(item)
  item%i=30
  call insitem(head%next,item,.true.)
  call outputlist(head)

stop
end program

