program ex0814
implicit none
  real a,b
  common a,b ! р疊翴计a,b办跑计い
  a = 1.0
  b = 2.0
  call ShowCommon()
  stop
end

subroutine ShowCommon()
implicit none
  real a(2)
  common a ! р皚a办跑计い
  write(*,*) a(1), a(2)
  return
end