program gdemo1
  use TextGraphLib
  implicit none
  
  call SetScreen( 10, 10 )      ! 設定解析度為10x10
  call DrawLine( 1, 1, 10, 10 ) ! 在(1,1)到(10,10)這兩點間畫一條線
  call UpdateScreen()           ! 顯示繪圖的結果

  stop
end