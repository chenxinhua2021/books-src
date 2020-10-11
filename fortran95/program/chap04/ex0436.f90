program ex0436
implicit none
real(kind=4) :: a
real(kind=8) :: b
a=1.0_4 ! 確定1.0這個數字是使用單精確度
b=1.0_8 ! 確定1.0這個數字是使用雙精確度
write(*,*) a,b
stop
end