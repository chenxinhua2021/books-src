@echo off
REM
REM replace d:\compiler\gcc with whatever your installation root may be.
REM GCC_EXEC_PREFIX is optional, and hardly ever needs to be set (read:
REM leave it alone).
REM
PATH=d:\compiler\gcc\bin;%PATH%
SET GCC_EXEC_PREFIX=d:\compiler\gcc\lib\gcc-lib\
@echo on
