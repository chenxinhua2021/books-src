program ex0806
implicit none
  integer, parameter :: players = 5
  real :: angle(players) = (/ 30.0, 45.0, 35.0, 50.0, 40.0 /)
  real :: speed(players) = (/ 25.0, 20.0, 21.0, 27.0, 22.0 /)
  real :: distance(players)
  integer :: I

  do I=1, players
     call Get_Distance( angle(i), speed(i), distance(i) )
	 write(*,"('Player ',I1,' =',F8.2)") I, distance(i)
  end do

  stop
end
! 把0～360的角度轉換成0～2PI的徑度
subroutine Angle_TO_Rad( angle, rad )
  implicit none
  real angle, rad
  real, parameter :: pi=3.14159

  rad = angle*pi/180.0
  
  return
end
! 由角度、切線速度來計算投射距離
subroutine Get_Distance( angle, speed, distance )
implicit none
  real angle, speed  ! 傳入的參數
  real distance      ! 準備傳回去的結果
  real rad, Vx, time ! 內部使用
  real, parameter :: G=9.81

  call Angle_TO_Rad( angle, rad ) ! 單位轉換
  Vx   = speed*cos(rad)           ! 水平方向速度
  time = 2.0*speed*sin(rad) / G   ! 在空中飛行時間
  distance = Vx * time            ! 距離 = 水平方向速度 * 飛行時間

  return
end
