module sgl_util
  use sgl
  implicit none
contains
  subroutine Display()
    call sglClearBuffer() ! 清除畫面
	call sglColor3f(1.0,0,0) ! 使用紅色
	call sglRectV(0.2, 0.2, 0.8, 0.8) ! 以(0.2,0.2)和(0.8,0.8)為端畫矩形
    call sglColor3i(0,255,0) ! 使用綠色
    call sglCircleV(0.5,0.5,0.5) ! 以(0.5,0.5)為圓心, 畫半徑為0.5的圓
	call sglColor3i(0,0,255) ! 使用藍色
	call sglLineV(0.5,0, 0.5, 1.0) ! 在(250,0)到(250,500)兩點間畫線
	call sglLineV(0.0,0.5, 1.0,0.5) ! 在(0,250)到(500,250)兩點間畫線
	call sglUpdateBuffer();
  end subroutine
end module

program main
  use sgl_util
  implicit none
  call sglDisplaySub(Display)
  ! 設定視窗左上角的虛擬座標為(0,0)右下角為(1.0,1.0)
  call sglSetVirtual(0.0, 0.0, 1.0, 1.0)
  call sglCreateWindow(100,100,500,500,1)
  call sglMainLoop()
  stop
end program