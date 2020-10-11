module LinearAlgebra
  implicit none
contains
! Gauss_Jordan�k
subroutine Gauss_Jordan(A,S,ANS)
  implicit none
  real    :: A(:,:)
  real    :: S(:)
  real    :: ANS(:)
  real, allocatable :: B(:,:)
  integer :: i, N
  N = size(A,1)  
  allocate(B(N,N))
  ! �O�s������x�}A,�ΰ}�CS
  B=A 
  ANS=S  
  ! ��B�Ʀ��﨤�u�x�}(���F�﨤�u�~,����0)
  call Upper(B,ANS,N) ! ����B�Ʀ��W�T���x�}
  call Lower(B,ANS,N) ! �A��B�Ʀ��U�T���x�}
  ! �D��
  forall(i=1:N)
    ANS(i)=ANS(i)/B(i,i) 
  end forall
  return
end subroutine Gauss_Jordan
! ��X����
subroutine output(M,S)
  implicit none
  real    :: M(:,:), S(:)
  integer :: N,i,j
  N = size(M,1)
  ! write���[�Wadvance="no",�i�H�����_��o��,�ϤU�@����
  ! write����b�P�@���.
  do i=1,N
    write(*,"(1x,f5.2,a1)", advance="NO") M(i,1),'A'
    do j=2,N
      if ( M(i,j) < 0 ) then
        write(*,"('-',f5.2,a1)",advance="NO") -M(i,j),char(64+j)
      else
        write(*,"('+',f5.2,a1)",advance="NO") M(i,j),char(64+j)
      end if
    end do
    write(*,"('=',f8.4)") S(i)
  end do
  return
end subroutine output
! �D�W�T���x�}���Ƶ{��
subroutine Upper(M,S,N)
  implicit none
  integer :: N
  real    :: M(N,N)
  real    :: S(N)
  integer :: I,J
  real :: E
  do I=1,N-1
    do J=I+1,N              
      E=M(J,I)/M(I,I)
      M(J,I:N)=M(J,I:N)-M(I,I:N)*E
      S(J)=S(J)-S(I)*E
    end do
  end do
  return
end subroutine Upper
! �D�U�T���x�}���Ƶ{��
subroutine Lower(M,S,N)
  implicit none
  integer :: N
  real    :: M(N,N)
  real    :: S(N)
  integer :: I,J
  real :: E
  do I=N,2,-1
    do J=I-1,1,-1           
      E=M(J,I)/M(I,I)
      M(J,1:N)=M(J,1:N)-M(I,1:N)*E
      S(J)=S(J)-S(I)*E
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
  real :: A(N,N)=reshape( (/1,2,3,4,5,6,7,8,8/),(/N,N/) )
  real :: S(N)=(/12,15,17/)
  real :: ans(N)
  integer :: i
  write(*,*) 'Equation:'
  call output(A,S)
  call Gauss_Jordan(A,S,ANS)
  write(*,*) 'Ans:'
  do i=1,N
    write(*,"(1x,a1,'=',F8.4)") char(64+i),ANS(i) 
  end do
  stop
end program
