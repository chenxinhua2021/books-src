module sgl_util
  use sgl
  implicit none
contains
  subroutine Display()
    write(*,*) "Update"
    call sglClearBuffer() ! 清除畫面
	call sglColor3f(1.0,0,0) ! 使用紅色
	call sglRect(100,100,300,300) ! 以(100,100)和(300,300)為端畫矩形
    call sglColor3i(0,255,0) ! 使用綠色
    call sglCircle(200,200,200) ! 以(200,200)為圓心, 畫半徑為200的圓
	call sglColor3i(0,0,255) ! 使用藍色
	call sglLine(200,0, 200,400) ! 在(200,0)到(200,400)兩點間畫線
	call sglLine(0,200, 400,200) ! 在(0,200)到(400,200)兩點間畫線
  end subroutine
end module

program main
  use sgl_util
  implicit none
  call sglDisplaySub(Display) ! 設定視窗更新時呼叫Display
  ! 開啟繪圖視窗, 左上角為(100,100), 寬高同為400
  call sglCreateWindow(100,100,400,400,0)
  ! 進入等待訊息的迴圈
  call sglMainLoop()
  stop
end program