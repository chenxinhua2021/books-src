program ex0415
  character(len=20) string
  character(len=5) substring
  string = "Have a nice day."
  substring = "nice"
  write(*,*) ichar('A') ! 輸出字元A的ASCII碼
  write(*,*) char(65)   ! 輸出ASCII碼65所代表的字元,也就是A
  write(*,*) len(string) ! 輸出字串string宣告時的長度
  write(*,*) len_trim(string) ! 輸出字串string內容的長度
  write(*,*) index(string, substring) ! nice在Have a nice day的第8個位置
end
