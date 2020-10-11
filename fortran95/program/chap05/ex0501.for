	PROGRAM ex0501
	IMPLICIT NONE
	REAL speed

	WRITE(*,*) "speed:"
	READ (*,*) speed
	
	IF ( speed .GT. 100 ) then ! FORTRAN 77要用縮寫.GT.代表大於">"
	  write(*,*) "Slow down."
	END IF

	STOP
	END