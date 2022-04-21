subroutine posidat

USE information
implicit real*8(a-h,o-z)
!	character*20 fname

! c     WRITE(fname,'(a3,i3.3,a4)')'KMC','.dat'

if(npost.eq.1)then       !!�Ynpost����1�����p�����@�˪����N,���M�N���U�h�g
open(113,file='KMC.dat',status='unknown')      
write(113,*)Zone
do i=1,ncelly
do j=1,ncellx
ib=ncellx*(i-1)+j    !!ib�O����?
!	write(*,*)99,i,j,ib
!	pause
write(113,'(i3,i3,i3)')j,i,ibspecies(ib)*2
enddo
enddo
close(113)

else

open(113,file='KMC.dat',status='unknown',ACCESS='APPEND')   !!   ���U�h�g���g�k
write(113,*)Zone 
do i=1,ncelly
do j=1,ncellx
ib=ncellx*(i-1)+j
write(113,'(i3,i3,i3)')j,i,ibspecies(ib)*2      
enddo
enddo
close(113)
endif



!..... Product on surface

nprod_sur =0 !set counters zero for all species  !!�����S������� �l

do i=1,ncell

nprod_sur(ibspecies(i))=nprod_sur(ibspecies(i))+1

enddo

if(npost.eq.1)then
open(114,file='surprod.dat',status='unknown')      
open(1142,file='surprod2.dat',status='unknown')  
write(114,'(2x,a,5x,50a15)')'time(sec.)',(specname(i),i=1,nspecies)     
write(1142,'(2x,a,5x,50a15)')'time(sec.)',(specname(i),i=1,nspecies)            
write(114,'(f11.7,x,50f15.4)')Time_go,(dble(nprod_sur(i))/dble(ncell)*100.d0,i=1,nspecies)              
write(1142,'(f11.7,x,50f15.4)')Time_go, (dble(nprod_sur(i)),i=1,nspecies) 

close(114)
close(1142)

else



open(114,file='surprod.dat',status='unknown',ACCESS='APPEND')      
open(1142,file='surprod2.dat',status='unknown',ACCESS='APPEND')      
write(114,'(f11.7,x,50f15.4)')Time_go,(dble(nprod_sur(i))/dble(ncell)*100.d0,i=1,nspecies)

write(1142,'(f11.7,x,50f15.4)')Time_go,(dble(nprod_sur(i)),i=1,nspecies)

close(114) 
close(1142) 
endif



!..... Product from desorption!!
!set all species zero before sampling

!      do i=1,nprod_des
!
!        nprod_des2(nprod_des1(i))  = nprod_des2(nprod_des1(i))+1
!
!	enddo

if(npost.eq.1)then   



open(115,file='desprod.dat',status='unknown')      
write(115,'(2x,a,5x,50a15)')'time(sec.)',(specname(i),i=1,nspecies)   

write(115,'(f11.7,x,50f15.4)')Time_go,(dble(nprod_des1(i)),i=1,nspecies)

close(115)

else   

open(115,file='desprod.dat',status='unknown',ACCESS='APPEND')      
write(115,'(f11.7,x,50f15.4)')Time_go,(dble(nprod_des1(i)),i=1,nspecies)

close(115) 
endif


!..... Reactants from adsorption!!
!      nprod_ads2 =0 !set all species zero before sampling
!
!      do i=1,nprod_ads
!
!        nprod_ads2(nprod_ads1(i))  = nprod_ads2(nprod_ads1(i))+1
!
!	enddo

if(npost.eq.1)then



open(116,file='adsprod.dat',status='unknown')      
write(116,'(2x,a,5x,50a15)')'time(sec.)',(specname(i),i=1,nspecies)   

write(116,'(f11.7,x,50f15.4)')Time_go,(dble(nprod_ads1(i)),i=1,nspecies)

close(116)

else

open(116,file='adsprod.dat',status='unknown',ACCESS='APPEND')      
write(116,'(f11.7,x,50f15.4)')Time_go,(dble(nprod_ads1(i)),i=1,nspecies)

close(116) 
endif

return
end  
