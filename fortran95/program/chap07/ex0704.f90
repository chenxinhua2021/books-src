program ex0704
implicit none
  integer, parameter :: row = 2
  integer, parameter :: col = 2
  integer :: matrixA(row,col)
  integer :: matrixB(row,col)
  integer :: matrixC(row,col)
  integer r ! 用來指定row
  integer c ! 用來指定column

  ! 讀入矩陣A的內容
  write(*,*) "Matrix A"
  do r=1, row
    do c=1, col
      write(*,"('A(',I1,',',I1,')=')") r,c
	  read(*,*) matrixA(r,c)
	end do
  end do

  ! 讀入矩陣B的內容
  write(*,*) "Matrix B"
  do r=1, row
    do c=1, col
      write(*,"('B(',I1,',',I1,')=')") r,c
	  read(*,*) matrixB(r,c)
	end do
  end do
  
  ! 把矩陣A,B相加並輸出結果
  write(*,*) "Matrix A+B="
  do r=1, row
    do c=1, col
	  matrixC(r,c) = matrixB(r,c)+matrixA(r,c) ! 矩陣相加
	  write(*,"('(',I1,',',I1,')=',I3)") r,c,matrixC(r,c)
	end do
  end do

  stop
end
