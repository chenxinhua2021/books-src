module linklist
  type student
    integer :: num
	integer :: Chinese, English, Math, Science, Social
  end type
  
  type datalink
    type(student) :: item
    type(datalink), pointer :: next
  end type

contains

  function SearchList(num, head)
    implicit none
	integer :: num
	type(datalink), pointer :: head, p
	type(datalink), pointer :: SearchList

	p=>head
	nullify(SearchList)
	do while( associated(p) )
	  if ( p%item%num==num ) then
	    SearchList => p
		return
	  end if
	  p=>p%next
	end do
	return
  end function

end module linklist

program ex1016
  use linklist
  implicit none
  character(len=20) :: filename
  character(len=80) :: tempstr
  type(datalink), pointer :: head
  type(datalink), pointer :: p
  type(student), allocatable :: s(:)
  integer i,error,size

  write(*,*) "filename:"
  read(*,*) filename
  open(10, file=filename, status="old", iostat=error)
  if ( error/=0 ) then
    write(*,*) "Open file fail!"
	stop
  end if
  
  allocate(head)
  nullify(head%next)
  p=>head
  size=0
  read(10, "(A80)") tempstr ! 讀入第一行字串, 不需要處理它
  ! 讀入每一位學生的成績
  do while(.true.)
    read(10,fmt=*, iostat=error) p%item
	if ( error/=0 ) exit
	size=size+1
	allocate(p%next, stat=error) ! 新增下一筆資料
	if ( error/=0 ) then
	  write(*,*) "Out of memory!"
	  stop
	end if
	p=>p%next ! 移動到串列的下一筆資料
	nullify(p%next)
  end do
  
  write(*,"('總共有',I3,'位學生')") size
  allocate( s(size) )
  p=>head
  do i=1,size
    s(i)=p%item
	p=>p%next  
  end do
  
  do while(.true.)
    write(*,*) "要查詢幾號同學的成績?"
	read (*,*) i
	if ( i<1 .or. i>size ) exit ! 輸入不合理的座號
    write(*,"(5(A6,I3))") "國文",s(i)%Chinese,&
	                      "英文",s(i)%English,&
				          "數學",s(i)%Math,&
				          "自然",s(i)%Science,&
				          "社會",s(i)%Social
  end do
  write(*,"('座號',I3,'不存在, 程式結束.')") i
  
  stop
end program