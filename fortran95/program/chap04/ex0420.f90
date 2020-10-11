program ex0420
  integer a
  a=100
  write(*,100) a  ! 使用行代碼100地方設定的格式來輸出變數a
  100 format(I4)  ! 最前面的100是行代碼, 把這一行程式碼給一個編號
end
