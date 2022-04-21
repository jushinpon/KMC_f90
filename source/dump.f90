subroutine dump
USE mt19937
USE information
implicit real*8(a-h,o-z)	





open(112,file='dump.dat')

write(112,*)ncellx*ncelly


do 233 i=1,ncellx*ncelly
write(112,*)ibspecies(i)  
233   continue

close(112)
!      pause
return
end




