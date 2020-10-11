program  ex0609
implicit none
  integer  ::  i,j

  loop1: do i=1,3
    loop2: do j=1,3
      if ( i==3 ) exit  loop1  ! ¸õÂ÷loop1°j°é
      if ( j==2 ) cycle loop2  ! ­«°µloop2°j°é
      write(*, "('(',i2,',',i2,')')" ) i, j
    end do loop2
  end do loop1
  stop
end
