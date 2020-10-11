module TextGraphLib
  implicit none
  integer, save   :: ScreenWidth        ! 定義可以畫圖的畫面寬度
  integer, save   :: ScreenHeight       ! 定義可以畫圖的畫面高度
  character, save :: background  = ' '  ! 定義預設用來清除畫面的字元
  character, save :: CurrentChar = '*'  ! 定義預設用來畫圖的字元 
  character, save, allocatable :: screen(:,:)  ! 用來實際畫圖的記憶體
  integer, parameter :: segments = 100
  real, parameter    :: PI = 3.14159

contains 
! 定義畫面大小
subroutine SetScreen( width, height )
  implicit none
  integer, intent(in) :: width, height
  if ( allocated(screen) ) deallocate(screen)
  ScreenWidth  = width
  ScreenHeight = height
  allocate( screen(width, height) )
  if ( .not. allocated(screen) ) then
    write(*,*) "Allocate buffer error!"
	stop
  end if
  screen  = ' '
  return
end subroutine
! 歸還記憶體使用空間
subroutine DestroyScreen()
  implicit none
  if( allocated(screen) ) deallocate(screen)
  return
end subroutine

! 清除畫面
subroutine ClearScreen( c )
  implicit none
  character, optional :: c
  if ( .not. allocated(screen) ) return
  if ( present(c) ) then
    screen = c
  else
    screen = background
  end if
  return
end subroutine
! 定義預設用來清除畫面的字元
subroutine SetBackground( c )
  implicit none
  character :: c
  background = c
  return
end subroutine
! 定義預設用來畫圖的字元
subroutine SetCurrentChar( char )
  implicit none
  character :: char
  CurrentChar = char
  return
end subroutine
! 把畫好的結果實際秀在螢幕上
subroutine UpdateScreen()
  implicit none
  integer i
  character(len=20) :: str
  if ( .not. allocated(screen) ) return
  write( str, "('(',I3.3,'A1)')" ) ScreenWidth
  do i=1, ScreenHeight
    write(*, str) screen(:,i)
  end do
  return
end subroutine
! 在指定的(x,y)位置畫上一個字元
subroutine PutChar( x, y, char )
  implicit none
  integer, intent(in) :: x,y
  character, optional :: char

  if ( .not. allocated(screen) ) return
  if ( x<1 .or. x>ScreenWidth .or. y<1 .or. y>ScreenHeight ) return
  
  if( present(char) ) then
    screen(x,y) = char
  else
    screen(x,y) = CurrentChar
  end if

  return
end subroutine PutChar
! 在(x0,y0)到(x1,y1)之間畫一條直線
subroutine DrawLine(x0,y0, x1,y1)
  implicit none
  integer, intent(in) :: x0,y0
  integer, intent(in) :: x1,y1
  integer xdiff, ydiff
  integer xinc, yinc
  integer xadd, yadd
  integer x,y
  integer sum

  xdiff = x1-x0
  ydiff = y1-y0
  
  if ( xdiff > 0 ) then
    xinc = 1
	xadd = xdiff
  else if ( xdiff < 0 ) then
    xinc = -1
	xadd = -xdiff
  else 
    xinc = 0
	xadd = 0
  end if

  if ( ydiff > 0 ) then
    yinc = 1
	yadd = ydiff
  else if ( ydiff < 0 ) then
    yinc = -1
	yadd = -ydiff
  else
    yinc = 0
	yadd = 0
  end if

  sum = 0
  x = x0
  y = y0

  if ( xadd > yadd ) then
	do while(x/=x1)
	  call PutChar( x, y )
	  x = x + xinc
	  sum = sum + yadd
	  if ( sum >= xadd ) then 
	    sum = sum - xadd
		y = y + yinc
	  end if
	end do
    call PutChar( x, y )
  else
	do while(y/=y1)
	  call PutChar( x, y )
	  y = y + yinc
	  sum = sum + xadd
	  if ( sum >= yadd ) then 
	    sum = sum - yadd
		x = x + xinc
	  end if
	end do
    call PutChar( x, y )
  end if

  return
end subroutine
! 以(cx,cy)為圓心, 水平軸半徑為radiusA, 垂直軸半徑為radiusB的橢圖
subroutine DrawCircle( cx, cy, radiusA, radiusB )
  implicit none
  integer, intent(in) :: cx, cy, radiusA
  integer, optional :: radiusB
  integer ra, rb
  integer x,y, nx,ny
  integer i
  real    r, rinc
  r=0.0
  rinc = 2.0*PI/real(segments)

  if ( present(radiusB) ) then
    ra = radiusA
	rb = radiusB
  else
    ra = radiusA
	rb = radiusA
  end if
  
  
  x = cx + int(ra*sin(r)+0.5)
  y = cy + int(rb*cos(r)+0.5)
  do while( r < 2*PI )
	r = r + rinc  
    nx = cx + int(ra*sin(r)+0.5)
	ny = cy + int(rb*cos(r)+0.5)
	call DrawLine(x,y, nx,ny)
	x = nx
	y = ny
  end do

end subroutine
! 如果1<=num<=max, 傳回num值.
! num<1 值回1
! num>max 值回max
integer function Bound(num, max)
  implicit none
  integer, intent(in) :: num, max
  bound = num
  if ( num<1 ) Bound = 1
  if ( num>max ) Bound = max
  return
end function
! 以(x0,y0)為左上角, (x1,y1)為右下角畫一個空心的矩形
subroutine DrawRect( x0, y0, x1, y1 )
  implicit none
  integer, intent(in) :: x0, y0, x1, y1
  integer :: rx0, ry0, rx1, ry1

  if ( .not. allocated(screen) ) return
  if ( x0>x1 .or. y0>y1 ) return

  rx0 = Bound(x0, ScreenWidth)
  ry0 = Bound(y0, ScreenHeight)
  rx1 = Bound(x1, ScreenWidth)
  ry1 = Bound(y1, ScreenHeight)

  screen(rx0:rx1, ry0) = CurrentChar
  screen(rx0:rx1, ry1) = CurrentChar
  screen(rx0, ry0:ry1) = CurrentChar
  screen(rx1, ry0:ry1) = CurrentChar

  return
end subroutine
! 以(x0,y0)為左上角, (x1,y1)為右下角畫一個實心的矩形
subroutine DrawFilledRect( x0, y0, x1, y1 )
  implicit none
  integer, intent(in) :: x0, y0, x1,y1
  integer :: rx0, ry0, rx1, ry1
  
  if ( .not. allocated(screen) ) return
  if ( x0>x1 .or. y0>y1 ) return

  rx0 = Bound(x0, ScreenWidth)
  ry0 = Bound(y0, ScreenHeight)
  rx1 = Bound(x1, ScreenWidth)
  ry1 = Bound(y1, ScreenHeight)

  screen( rx0:rx1 , ry0:ry1 ) = CurrentChar

  return
end subroutine

end module