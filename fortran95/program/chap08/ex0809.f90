program ex0809
implicit none
  integer, parameter :: players = 5
  real :: angle(players) = (/ 30.0, 45.0, 35.0, 50.0, 40.0 /)
  real :: speed(players) = (/ 25.0, 20.0, 21.0, 27.0, 22.0 /)
  real :: distance(players)
  real, external :: Get_Distance ! 宣告Get_Distance是個函數
  integer :: I

  do I=1, players
     distance(i) = Get_Distance( angle(i), speed(i) )
	 write(*,"('Player ',I1,' =',F8.2)") I, distance(i)
  end do

  stop
end
! 把0～360的角度轉換成0～2PI的徑度
real function Angle_TO_Rad( angle )
  implicit none
  real angle
  real, parameter :: pi=3.14159

  Angle_TO_Rad = angle*pi/180.0
  
  return
end
! 由角度、切線速度來計算投射距離
real function Get_Distance( angle, speed )
implicit none
  real angle, speed  ! 傳入的參數
  real rad, Vx, time ! 內部使用
  real, external  :: Angle_TO_Rad ! 宣告Angle_TO_Rad是個函數
  real, parameter :: G=9.81

  rad  = Angle_TO_Rad( angle )    ! 單位轉換
  Vx   = speed*cos(rad)           ! 水平方向速度
  time = 2.0*speed*sin(rad) / G   ! 在空中飛行時間
  Get_Distance = Vx * time        ! 距離 = 水平方向速度 * 飛行時間

  return
end
