include 'mt19937.f90'
include 'information.f90'

program KMC_MAIN
USE mt19937
USE information
implicit real*8(a-h,o-z)	
ibspecies=1 ! A clean surface at the very beginning! 

call parameters

if(First_Run .eq. "F")then
write(*,*)'*************Read Dump.dat' 
call Read_Dump
endif

Call init_genrand(nseed)

call table     


write(*,*) 789,D0,D0ad,D0df


Time_go=0.d0
nprod_sur = 0
nprod_des = 0
nprod_ads = 0
nprod_des1 =0 !product sampling for desorption  
nprod_ads1 =0 !reactant sampling for adsorption

!      open(113,file='KMC.dat',status='new') !animation file
!      close(113)
nloop = 0
npost = 0
!      do i=1,500
do while(Time_go .le.500.)
!      do while(nloop.le.10)
nloop= nloop+1
!       write(*,*)'nloop = ',nloop
!	write(*,*)'1'

call channels
!      write(*,*)'2'

call picktime
!	write(*,*)'3'
if(mod(nloop,100).eq.0.and.Time_go .le. 1E-5 ) write(*,*)"Nloop :" ,nloop,'Time: ',Time_go,' sec.'
if(mod(nloop,100).eq.0 .and.Time_go .gt. 1E-11)then  !!�ɶ�reach 1E-6�N�g�X��,��call posidat
write(*,*)'KMC STEP:',nloop
write(*,*)'Time: ',Time_go,' sec.'
write(*,*) 
npost = npost+1
call posidat		              

endif



call product
!	  write(*,*)'4'
call update      
!          write(*,*)'5'
call checkr

!        call checkd

if(mod(nloop,100000).eq.0 .and.Time_go .gt. 1E-11)call dump    
!        if(mod(nloop,10).eq.0 )call dump
enddo

stop
end

include 'channels.f90'
include 'parameters.f90'
include 'checkr.f90'
include 'checkd.f90'
include 'table.f90'
include 'update.f90'
include 'picktime.f90' 
include 'posidat.f90'
include 'product.f90'
include 'dump.f90'
include 'Read_Dump.f90'
