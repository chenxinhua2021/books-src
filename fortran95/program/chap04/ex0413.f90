program ex0413
  character(len=20) string 
  string = "Good morning."
  write(*,*) string
  string(6:) = "evening." ! 重設設定從第6個字元之後的字串
  write(*,*) string
end
