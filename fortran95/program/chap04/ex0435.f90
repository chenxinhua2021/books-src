program ex0435
implicit none
! 耞癘魁9计俱计kind
integer, parameter :: long_int  = selected_int_kind( 9 )  
! 耞癘魁3计俱计kind
integer, parameter :: short_int = selected_int_kind( 3 ) 
! 耞Τ10Τ计, 计癘魁50疊翴计kind
integer, parameter :: long_real = selected_real_kind( 10, 50 )
! 耞Τ3Τ计, 计癘魁3疊翴计kind
integer, parameter :: short_real= selected_real_kind( 3, 3 )

integer(kind=long_int)  :: a = 12345678
integer(kind=short_int) :: b = 12
real(kind=long_real)    :: c = 1.23456789D45
real(kind=short_real)   :: d = 1230

write(*, "(I3,1X,I10)" )    long_int,   a
write(*, "(I3,1X,I10)" )    short_int,  b
write(*, "(I3,1X,E10.5)" )  long_real,  c
write(*, "(I3,1X,E10.5)" )  short_real, d

stop
end