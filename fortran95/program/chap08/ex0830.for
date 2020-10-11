	PROGRAM  ex0830
	IMPLICIT NONE
	INTEGER  N
	INTEGER  fact

	WRITE(*,*) 'N='
	READ (*,*) n
	WRITE(*, "(I2,'! = ',I8)" ) n, fact(n)
	
	STOP
	END

	INTEGER FUNCTION ifact(n)
	IMPLICIT NONE
	INTEGER fact
	INTEGER n
	
	ifact = fact(n)
	
	RETURN
	END

	INTEGER FUNCTION fact(n)
	IMPLICIT NONE
	INTEGER  n
	INTEGER  count
	INTEGER  localcount, temp  ! 局部變數
	INTEGER  ifact
	EXTERNAL ifact
	SAVE     count
	data     count  /1/

	localcount = count
	count = count+1
	WRITE(6, 100) localcount, n
100   FORMAT(I2,'th enter, n=',I2)
	IF ( n < 0 ) THEN ! 不合理的輸入
	  fact = -1       ! 隨便設定一個值
	  WRITE(6, 200) localcount, n, fact
	  RETURN          ! n不合理, 直接return 
	ELSE IF ( n <= 1 ) THEN
        fact = 1          
        WRITE(6, 200) localcount, n, fact
        RETURN          ! 不用再向下遞迴了, return 
      END IF
      ! 會執行到這, 代表n>1, 從n*(n-1)!來計算n!
      temp = n-1
      fact = n * ifact(temp) ! 呼叫ifact, ifact會直接再呼叫fact
      WRITE(6, 200) localcount, n, fact
200   FORMAT(I2,'th exit, n=',I2, ' ans=',I8)
      RETURN
	END
