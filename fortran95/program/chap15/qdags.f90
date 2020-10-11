program main
  use IMSL
  implicit none
  integer NOUT
  real, external :: F
  real A, B
  real, parameter :: ERRABS = 1E-5
  real, parameter :: ERRREL = 1E-5
  real ANS, ERR

  A = 0.0
  B = 3.14159
  CALL QDAGS (F, A, B, ERRABS, ERRREL, ANS, ERR)
  write(*,"('¿n¤À­È='F5.2,' ¦ô­p»~®t½d³ò:'F6.4)") ANS, ERR

END

real function F(X)
  implicit none
  real X
  F = sin(X)
  return
end function
