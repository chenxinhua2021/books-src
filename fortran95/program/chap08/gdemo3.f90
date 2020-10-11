program gdemo3
  use TextGraphLib
  implicit none
  integer i
  
  call SetScreen(70,24)
  call ClearScreen()
  ! 畫臉
  call DrawCircle( 35, 12, 20, 10 )
  ! 畫兩個眼睛
  call SetCurrentChar('0')
  call DrawCircle( 42, 10, 4, 2 )
  call DrawCircle( 28, 10, 4, 2 )
  ! 畫鼻子
  call SetCurrentChar('#')
  call DrawLine( 35, 10, 30, 15 )
  call DrawLine( 30, 15, 38, 15 )
  ! 畫嘴吧
  call SetCurrentChar('-')
  call DrawLine( 30, 18, 38, 18 )
  ! 把畫圖的結果顯示到螢幕上
  call UpdateScreen()
  
  stop
end