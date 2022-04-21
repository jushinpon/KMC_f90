subroutine Read_Dump

USE information
implicit real*8(a-h,o-z)	





open(112,file='dump.dat',status='old')

Read(112,*)ncell


do 233 i=1,ncell
Read(112,*)ibspecies(i)  
233   continue

close(112)
!      pause
return
end




