program ex0513
implicit none
  real a,b,ans
  character operator
  
  read(*,*) a
  read(*,"(A1)") operator ! 不使用格式有些機器會讀不到除號"/" 
  read(*,*) b

  select case(operator)
  case('+')
    ans = a+b
  case('-')
    ans = a-b
  case('*')
    ans = a*b
  case('/')
    ans = a/b
  case default ! 輸入其它符號不處理
    write(*,"('Unknown operator ',A1)") operator
	stop ! 結果程式
  end select

  write(*,"(F6.2,A1,F6.2,'=',F6.2)") a,operator,b,ans

  stop
end