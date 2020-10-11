module LinearAlgebra
  implicit none
contains
! �D�ϯx�}
subroutine inverse(A,IA)
  implicit none
  real    :: A(:,:), IA(:,:)
  real, allocatable :: B(:,:)
  integer :: i,j,N
  N = size(A,1)  
  allocate(B(N,N))
  ! ����IA�]�w�����x�}
  forall(i=1:N,j=1:N,i==j) IA(i,j)=1.0
  forall(i=1:N,j=1:N,i/=j) IA(i,j)=0.0
  ! �O�s������x�}A, �ϥ�B�ӭp��
  B=A 
  ! ��B�Ʀ��﨤�u�x�}(���F�﨤�u�~,����0)
  call Upper(B,IA,N) ! ����B�Ʀ��W�T���x�}
  call Lower(B,IA,N) ! �A��B�Ʀ��U�T���x�}
  ! �D��
  forall(i=1:N) IA(i,:)=IA(i,:)/B(i,i) 
  return
end subroutine
! ��X�x�}���Ƶ{��
subroutine output(matrix)
  implicit none
  real    :: matrix(:,:)
  integer :: m,n,i
  character(len=20) :: for='(??(1x,f6.3))'
  m = size(matrix,1)
  n = size(matrix,2)
  ! �Φr��ӳ]�w��X�榡
  write( FOR(2:3), '(I2)' ) N
  do i=1,N
	write( *, FMT=FOR ) matrix(i,:)
  end do
  return
end subroutine output
! �D�W�T���x�}���Ƶ{��
subroutine Upper(M,S,N)
  implicit none
  integer :: N
  real    :: M(N,N)
  real    :: S(N,N)
  integer :: I,J
  real :: E
  do I=1,N-1
    do J=I+1,N              
      E=M(J,I)/M(I,I)
      M(J,I:N)=M(J,I:N)-M(I,I:N)*E
      S(J,:)=S(J,:)-S(I,:)*E
    end do
  end do
  return
end subroutine Upper
! �D�U�T���x�}���Ƶ{��
subroutine Lower(M,S,N)
  implicit none
  integer :: N
  real    :: M(N,N)
  real    :: S(N,N)
  integer :: I,J
  real :: E
  do I=N,2,-1
    do J=I-1,1,-1           
      E=M(J,I)/M(I,I)
      M(J,1:N)=M(J,1:N)-M(I,1:N)*E
      S(J,:)=S(J,:)-S(I,:)*E
    end do
  end do
  return
end subroutine Lower
end module
! �D���p�ߦ�
program main
  use LinearAlgebra
  implicit none
  integer, parameter :: N=3 ! Size of Matrix
  real :: A(N,N) = (/ 1,2,3,4,5,6,7,8,8 /)
  real :: IA(N,N)
  integer :: i
  write(*,*) "��x�}"
  call output(A)
  call inverse(A,IA)
  write(*,*) "�ϯx�}"
  call output(IA)
  stop
end program
