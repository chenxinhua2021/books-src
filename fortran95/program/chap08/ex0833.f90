program  ex0833
  implicit none
  
  interface  ! 說明函數func的使用介面
    elemental real function func(num)
	implicit none
	real, intent(in) :: num
	end function
  end interface

  integer i
  real :: a(10) = (/ (i,i=1,10) /)
  real :: b(10)

  write(*,"(10F6.2)") a
  a = func(a)
  write(*,"(10F6.2)") a

end program

elemental real function func(num)
  implicit none
  real, intent(in) :: num
  func = sin(num) + cos(num)
  return
end function
