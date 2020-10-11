module typedef
  type player
    character(len=80) :: name
    real weight, height
	real score
  end type
end module

program ex0908
  use typedef
  implicit none
  character(len=20)  :: filename = "ex0908dat.txt"
  integer, parameter :: fileid = 20
  logical :: alive   ! 檢查檔案是否存在
  type(player) :: p  ! 讀取選手資料
  character(len=10)  :: title ! 讀取資料項目
  real tempnum       ! 讀取資料
  logical, external :: GetNextPlayer ! 找出下一位球員資料的函式
  integer i          ! 迴圈記數器
  integer error      ! 檢查檔案讀取是否正常

  inquire(file=filename, exist=alive)
  if ( .not. alive ) then ! 檔案不存在就結束程式
    write(*,*) trim(filename)," doesn't exist."
	stop
  end if
  
  open(unit=fileid, file=filename)
  do while(.true.)
    if ( GetNextPlayer(fileid, p%name) ) then
	  do i=1,3
   	    read(fileid, "(A4,1X,F)", iostat=error ) title, tempnum
		if ( error/=0 ) then
		  write(*,*) "檔案讀取錯誤"
		  stop
		end if
	    ! 要經由每一行最前面兩個中文字來判斷讀入的是什麼資料
	    select case(title)
	    case("身高")
	      p%height = tempnum
	    case("體重")
	      p%weight = tempnum
	    case("得分")
	      p%score = tempnum
		case default
		  write(*,*) "出現不正確的資料"
		  stop
        end select
	  end do
	else
	  exit  
	end if

	if ( p%score > 20.0 ) then ! 印出得分高於20分的選手資料
	  write(*,"('姓名:',A8/,'身高:',F5.1,' 體重:',F5.1,' 得分:',F4.1)") p
	end if
  end do

  stop
end
! GetNextPlayer函式會從檔案中找出下一位球員的資料位置
! 如果檔案中還有資料需要讀取, 傳回.true.
! 如果檔案中沒有資料需要讀取, 傳回.false.
logical function GetNextPlayer(fileid, name)
  implicit none
  integer, intent(in) :: fileid
  character(len=*), intent(out) :: name
  character(len=80) title
  integer  error

  do while(.true.)
    read(fileid,"(A80)",iostat=error) title
	
	if ( error/=0 ) then ! 檔案中已經沒有資料了
	  GetNextPlayer = .false.
	  return
	end if

	if ( title(1:4)=="姓名" ) then
	  name = title(6:)
	  GetNextPlayer = .true.
	  return
	end if
  end do

  return
end function