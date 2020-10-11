program ex0503
implicit none
  integer rain, windspeed

  write(*,*) "Rain:"
  read(*,*) rain
  write(*,*) "Wind:"
  read(*,*) windspeed

  if ( rain>=500 .or. windspeed >=10 ) then
    write(*,*) "停止上班上課"
  else
    write(*,*) "照常上班上課"
  end if

stop
end