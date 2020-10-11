      PROGRAM ex0420
	INTEGER A
	A=100
	WRITE(*,100) A ! 使用行代碼100地方設定的格式來輸出變數a
100	FORMAT(I4)     ! 最前面的100是行代碼, 把這一行程式碼給一個編號
      END
