! 處理滑鼠事件的函式
module MouseEvent
use DFLIB
implicit none
Contains
  ! 滑鼠在視窗中每移動一次,就會呼叫這個函式
  subroutine ShowLocation(iunit, ievent, ikeystate, ixpos, iypos)
  implicit none
    integer :: iunit		! 滑鼠所在的視窗的unit值
	integer :: ievent		! 滑鼠發生的訊息碼
	integer :: ikeystate	! 進入這個函式時,其它控制鍵的狀態
	integer :: ixpos,iypos	! 滑鼠在視窗中的位置
    type(xycoord) :: t		 
	integer :: result		 
	character(len=15) :: output	! 設定輸出的字串

	result=SetActiveQQ(iunit)		! 把繪圖工作指向這個視窗
    write(output,100) ixpos,iypos	! 把滑鼠所在位置的訊息寫入output
100 format("(X:",I4," Y:",I4,")")	!
    result=SetColorRGB(#1010FF)		 
    result=Rectangle($GFILLINTERIOR,0,0,120,18) ! 畫一個實心方形
    result=SetColorRGB(#FFFFFF) 
	call MoveTo( 4,2,t)	
	call OutGText(output)	! 寫出訊息
	! 如果滑鼠在移動當中, 左鍵同時被按下, 會順便畫出一個點.
	if ( ikeystate==MOUSE$KS_LBUTTON ) then
	  result=SetColorRGB(#0000FF)
	  result=SetPixel(ixpos,iypos)
	end if
	return
  end subroutine
  ! 滑鼠右鍵按下時, 會執行這個函式
  subroutine MouseClearScreen(iunit, ievent, ikeystate, ixpos, iypos )
  implicit none
    integer :: iunit		! 滑鼠所在的視窗的unit值
	integer :: ievent		! 滑鼠發生的訊息碼
	integer :: ikeystate	! 進入這個函式時,其它控制鍵的狀態
	integer :: ixpos,iypos	! 滑鼠在視窗中的位置
    type(xycoord) :: t		 
	integer :: result		 

	result=SetActiveQQ(iunit)		! 把繪圖動作設定在滑鼠所在視窗上
    call ClearScreen($GCLEARSCREEN)	! 清除整個螢幕
    
	return
  end subroutine    
end module

program Mouse_Demo
use DFLIB
use MouseEvent
implicit none
  integer :: result
  integer :: event
  integer :: state,x,y

  result=AboutBoxQQ("Mouse Draw Demo\r By Perng 1997/09"C)
  ! 開啟視窗
  open( unit=10, file='user', title='Mouse Demo', iofocus=.true. )
  ! 使用字形前, 一定要呼叫InitializeFonts
  result=InitializeFonts()
  ! 選用Courier New的字形在視窗中來輸出			
  result=setfont('t''Courier New''h14w8')
  call ClearScreen($GCLEARSCREEN)	! 先清除一下螢幕
  ! 設定滑鼠移動或按下左鍵時, 會呼叫ShowLocation
  event=ior(MOUSE$MOVE,MOUSE$LBUTTONDOWN)
  result=RegisterMouseEvent(10, event, ShowLocation)
  ! 設定滑鼠右鍵按下時, 會呼叫MouseClearScreen
  event=MOUSE$RBUTTONDOWN
  result=RegisterMouseEvent(10, event, MouseClearScreen )
  ! 把程式放入等待滑鼠輸入的狀態
  do while(.true.)
    result=WaitOnMouseEvent( MOUSE$MOVE .or. MOUSE$LBUTTONDOWN .or.&
  	MOUSE$RBUTTONDOWN, state, x, y )
  end do
end program
