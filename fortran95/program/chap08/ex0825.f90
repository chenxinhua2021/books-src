program ex0825
implicit none
  interface ! 定義函式func的使用介面
    function random10(lbound, ubound)
	implicit none
	real :: lbound, ubound
	real :: random10(10) ! 傳回值是個陣列
	end function
  end interface
  real :: a(10)
  CALL RANDOM_SEED()     ! 庫存副程式, 使用亂數前呼叫
  a = random10(1.0, 10.0)! 產生10個1.0～1.0之間的亂數
  write(*,"(10F6.2)") a  ! 輸出陣列a的內容
end

! random10會傳回10個範圍在lbound到ubound之間的亂數
function random10(lbound, ubound)
implicit none
  real :: lbound, ubound
  real :: len
  real :: random10(10)
  real    t
  integer i
  len = ubound - lbound  ! 計算範圍大小
  do i=1,10
    call random_number(t) ! t會是0～1之間的亂數
    random10(i) = lbound + len * t ! 把t轉換成lbound～ubound間的亂數
  end do
  return
end