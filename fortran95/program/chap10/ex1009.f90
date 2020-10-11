module func
! person型態最少佔用18 bytes
! 因為它有10個字元及兩個浮點數
type person
  character(len=10) :: name
  real :: height, weight
end type
! pperson型態通常佔用4 bytes
! 因為它裏面只有一個指標, 指標在PC中固定使用4 bytes
type pperson
  type(person), pointer :: p
end type

contains 
subroutine sort(p)
  implicit none
  type(pperson) :: p(:)
  type(pperson) :: temp
  integer i,j,s

  s = size(p,1)
  do i=1,s-1
    do j=i+1, s
	  if ( p(j)%p%height < p(i)%p%height ) then
	    temp = p(i)
		p(i) = p(j)
		p(j) = temp
	  end if
	end do
  end do

  return
end subroutine

end module

program ex1009
  use func
  implicit none
  type(person), target :: p(5) = (/ person("陳同學", 180.0, 75.0), &
                                    person("黃同學", 170.0, 65.0), &
							        person("劉同學", 175.0, 80.0), &
							        person("蔡同學", 182.0, 78.0), &
							        person("許同學", 178.0, 70.0)  &
						         /) 
  type(pperson) :: pt(5)
  integer i
  ! 把pt陣列中的指標全部指向陣列p
  forall(i=1:5)
    pt(i)%p => p(i)
  end forall
  ! 依照身高從小到大排序
  call sort(pt)
  ! 輸出排序的結果
  write(*,"(5(A8,F6.1,F5.1/))") (pt(i)%p, i=1,5)

  stop
end
