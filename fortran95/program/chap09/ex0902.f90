program ex0902
  implicit none
  character(len=20) :: string

  open(unit=10, file="test.txt")
  write(10,"(A20)") "Good morning." ! 寫到檔案中
  rewind(10)
  read(10,"(A20)") string ! 從檔案中讀出來
  write(*,"(A20)") string ! 寫到螢幕上

  stop
end 
