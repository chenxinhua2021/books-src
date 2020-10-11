program ex0812
implicit none
  integer :: a,b
  common a,b          ! a,bぃㄣ办跑计丁い
  integer :: c,d
  common /group1/ c,d ! c,dgroup1办跑计丁い
  integer :: e,f
  common /group2/ e,f ! e,fgroup2办跑计丁い

  write(*,"(6I4)") a,b,c,d,e,f

  stop
end

block data
implicit none
  integer a,b
  common  a,b          ! a,bぃㄣ办跑计丁い
  data    a,b /1,2/    ! 砞﹚a,b
  integer c,d
  common  /group1/ c,d ! c,dgroup1办跑计丁い
  data    c,d /3,4/    ! 砞﹚c,d
  integer e,f
  common  /group2/ e,f ! e,fgroup2办跑计丁い
  data    e,f /5,6/    ! 砞﹚e,f
end block data
