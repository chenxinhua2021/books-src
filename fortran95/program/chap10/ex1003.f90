program  ex1003
  implicit none
  integer, pointer :: a=>null()
  integer, target  :: b=1,c=2

  write(*,*) associated(a)   ! FALSE, 指標a尚未指定
  a=>c 
  write(*,*) associated(a)   ! TRUE, 指標a已指定
  write(*,*) associated(a,c) ! TRUE, 指標a指向c
  write(*,*) associated(a,b) ! FALSE, 指標a不指向b
  nullify(a)                 ! 把指標a設為沒有指向
  write(*,*) associated(a)   ! FALSE, 指標a尚未指定

  stop
end
