program main
  use sgl
  implicit none
  external display ! 宣告display是個函式
  ! 設定當視窗需要重繪時,會呼叫副程式display
  call sglDisplaySub(display)  
  ! 開啟視窗, 視窗左上角為(100,100), 長寬同為500
  call sglCreateWindow(100,100,500,500,0)
  write(*,*) "Waiting message."
  ! 等待使用者給程式的訊息
  call sglMainLoop()
  write(*,*) "The End."
  stop
end
! 每當視窗需要更新畫面時, 會呼叫display
subroutine display()
  use sgl
  implicit none
  call sglClearBuffer()          ! 消除螢幕
  call sglColor3f(1.0,0.0,0.0)   ! 設定目前要使用紅色來繪圖
  call sglDrawLine(0,0, 500,500) ! 在(0,0)到(500,500)兩點之間畫線
  return
end subroutine