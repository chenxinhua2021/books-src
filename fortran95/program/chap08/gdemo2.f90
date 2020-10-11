program gdemo2
  use TextGraphLib
  implicit none
  
  call SetScreen( 20, 20 )
  call SetCurrentChar('o')       ! 改用o來作為填充字元
  call DrawCircle( 8, 4 , 3, 4)  ! 畫圓
  call SetCurrentChar('#')       ! 改用#來作為填充字元
  call DrawFilledRect( 4, 8, 13, 18 )  ! 畫矩形
  call UpdateScreen()            ! 顯示繪圖結果

  stop
end