program ex0813
implicit none
  real a
  common a ! р疊翴计a办跑计い
  a = 1.0
  call ShowCommon()
  stop
end

subroutine ShowCommon()
implicit none
  integer a
  common a ! р俱计a办跑计い
  write(*,*) a
  return
end