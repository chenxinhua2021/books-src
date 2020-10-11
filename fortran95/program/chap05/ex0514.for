	PROGRAM ex0514
	IMPLICIT NONE
	REAL height ! 記錄身高
	REAL weight ! 記錄體重

	WRITE(*,*) "height:"
	READ(*,*)   height     ! 讀入身高
	WRITE(*,*) "weight:"
	READ(*,*)   weight     ! 讀入體重
	
	IF ( weight > height-100 ) GOTO 200
	! 上面不成立, 沒有跳到200才會執行這裏
100	WRITE(*,*) "Under control." 
	GOTO 300  ! 下一行不能執行所以要跳到300.
200   WRITE(*,*) "Too fat!"
	
300	STOP
	END