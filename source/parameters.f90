subroutine parameters
USE mt19937
USE information
implicit real*8(a-h,o-z)	



!	nreact_type(species,ntype):set reaction type number
!
!...  usage==>nreact_type(species,ntype) = number
!
!.....number: reaction number of ntype for a species
!.....ntype =1 :adsorption
!.....ntype =2 :desorption
!.....ntype =3 :combination
!.....ntype =4 :transformation
!.....ntype =5 :dissociative adsorption
!.....ntype =6 :desorption from the dissociative adsorption

character*10 speci
character dummy 
fK_b=1.380658E-23 ! J * K-1 Boltzmann constant
fK_bev=0.00008617385 	  
h=6.626075E-34 ! J * s  Planck constant                                 
open(112,file='KMCinput.dat',status='old')
read(112,'(a11,a)')dummy,First_Run
read(112,'(a11,i7)')dummy,nseed !seed for random number generator
read(112,'(a12,f5.1)')dummy,TempK !temperature in Kevin
read(112,'(a8,i3)')dummy,nspecies !total concerned species    
read(112,'(a6,i3)')dummy,ncellx !cell No. in x dimension
read(112,'(a6,i3)')dummy,ncelly !cell No. in y dimension

write(*,*)"************ SYSTEM INFORMATION *************"
write(*,*)"System temperature: ",TempK
write(*,*)"Total species: ",nspecies
write(*,*)"Cell No. in X: ",ncellx
write(*,*)"Cell No. in Y: ",ncelly
write(*,*)"====================END======================"
write(*,*) 
!..... the following parameters are calculated from the read-in data!!
average_rate = 0.d0
naverage = 0

D0 =1E12
D0ad = 1E18  !!! The prefactor for adsorption mechanism
D0df = 1E12  !!! The prefactor for diffusion,just is combination in this program.
ncell=ncellx*ncelly    
rate1 =fK_bev*TempK     !!Kb*T  
do 22 ispe=1,nspecies
read(112,*)speci,number,specname(ispe)
write(*,*)'reading data for ',speci,' ',specname(ispe)

read(112,*)nreact_type(ispe,1)

write(*,*)'adsorption',nreact_type(ispe,1)

do iad=1,nreact_type(ispe,1) 
read(112,*)nad(ispe,iad),barrier	
rate_ads(ispe,iad)=D0ad*dexp(-barrier/rate1)
average_rate = average_rate+ rate_ads(ispe,iad)
naverage = naverage + 1	
enddo

read(112,*)nreact_type(ispe,2)

write(*,*)'desorption',nreact_type(ispe,2)

do ide=1,nreact_type(ispe,2)
read(112,*)nde(ispe,ide),barrier	
rate_des(ispe,ide)=D0*exp(-barrier/rate1)
average_rate = average_rate+  rate_des(ispe,ide)
naverage = naverage + 1
enddo

read(112,*)nreact_type(ispe,3)

write(*,*)'combination',nreact_type(ispe,3)

do ico=1,nreact_type(ispe,3)     !!We use combination to represent the diffusion mechanism: A + * -> * + A
read(112,*)ncom1(ispe,ico),nprod1(ispe,ico),&
    nprod2(ispe,ico),barrier
rate_comb(ispe,ico)=D0df*exp(-barrier/rate1)
average_rate = average_rate+   rate_comb(ispe,ico)
naverage = naverage + 1 
write(*,*) 5555,average_rate
enddo

read(112,*)nreact_type(ispe,4)     
write(*,*)'transformation',nreact_type(ispe,4)

do itr=1,nreact_type(ispe,4)
read(112,*)ntr(ispe,itr),barrier	
rate_tra(ispe,itr)=D0*exp(-barrier/rate1)
average_rate = average_rate+   rate_tra(ispe,itr)
naverage = naverage + 1 
enddo 

read(112,*)nreact_type(ispe,5)

write(*,*)'dissociative adsorption',nreact_type(ispe,5)

do idad=1,nreact_type(ispe,5)
read(112,*)ndads1(ispe,idad),ndads2(ispe,idad),&
		       ndadsp1(ispe,idad),&
               ndadsp2(ispe,idad),barrier

rate_dads(ispe,idad)=D0ad*exp(-barrier/rate1)
average_rate = average_rate+   rate_dads(ispe,idad)
naverage = naverage + 1 			 	    
write(*,*)"ndads2= ", ndads2(ispe,idad)
write(*,*)ispe,idad


enddo

read(112,*)nreact_type(ispe,6)

write(*,*)'dissociative desorption',nreact_type(ispe,6)

do idde=1,nreact_type(ispe,6)
read(112,*)nddes1(ispe,idde),nddesp1(ispe,idde),&
		       nddesp2(ispe,idde),&
               nddesp3(ispe,idde),barrier

rate_ddes(ispe,idde)=D0*exp(-barrier/rate1)
average_rate = average_rate+   rate_ddes(ispe,idde)
naverage = naverage + 1 	    

enddo	   	   

write(*,*)"read in species ",ispe," succefully!!!!!!"
22    continue !end reading

diss_rate = average_rate/dble(naverage) 
weighting = 0.00000001
rate_dads(1,1)= diss_rate*0.01d0*weighting
rate_dads(1,2)= diss_rate*3.d0*weighting
rate_dads(1,3)= diss_rate*1.d0*weighting


write(*,*)"read in succefully!!!!!!"
close(112)

return
end




