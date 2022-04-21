subroutine channels      
USE information
implicit real*8(a-h,o-z)

!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
nreact = 0 !counting the possible reaction number in the current system
ntype=0
nsite = 0
nspec = 0
react_rate =  0.d0
ncomsite=0
nspec=0
ncomspec =0
ncomp1=0
ncomp2=0
ndads_des= 0
!++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

do 26 i=1,ncell

ntemp=ibspecies(i) !ntemp:species index at site i
!	 write(*,*)777,i,ibspecies(i),ntemp

!	write(*,*)i,ntemp,nreact_type(ntemp,1)
!	pause
!.....check adsorption
do iad=1,nreact_type(ntemp,1)   !!KMCinput.dat���Ĥ@�ث����� �� �@�غ���(�b�o�Ovan)���i���������(�o�̬O5��)   
nreact = nreact +1


ntype(nreact)=1
nsite(nreact) = i
nspec(nreact) = nad(ntemp,iad)
react_rate(nreact) =  rate_ads(ntemp,iad)	
!		write(*,*)1111,i,ntemp,nreact,react_rate(nreact)
!		write(*,*)1111,ntype(nreact),nsite(nreact), nspec(nreact),iad

enddo

!*********** end checking adsorption

!.....check desorption

do ide=1,nreact_type(ntemp,2)

nreact = nreact +1
!		write(*,*)2222,i,ntemp,nreact
!	pause
ntype(nreact)=2
nsite(nreact) = i
nspec(nreact) = nde(ntemp,ide)
react_rate(nreact) =rate_des(ntemp,ide)
enddo

!*********** end checking desorption

!..... check transformation
do itr=1,nreact_type(ntemp,4)

nreact = nreact +1
!			write(*,*)4444,i,ntemp,nreact
!	pause
ntype(nreact)=4
nsite(nreact) = i
nspec(nreact) = ntr(ntemp,itr)
react_rate(nreact) =rate_tra(ntemp,itr)
enddo
!*********** end checking transformation

!..   getting all information about all neighbor cells by jbegin and jend.
!.... use binning method!
jbegin=npoint(i)
jend=npoint(i+1)-1

do 27 jx=jbegin,jend

j =list(jx)

ntemp1=ibspecies(j)!ntemp1:species index at site j(neighbor cell of site i)

!      write(*,*)ntemp,ntemp1
!	write(*,*)nreact_type(ntemp,3)
!	pause

!.....check combination
if(ntemp.le.ntemp1)then	
do ico=1,nreact_type(ntemp,3)      

if(ntemp1.eq.ncom1(ntemp,ico) )then
nreact = nreact +1
!			write(*,*)3333,i,ntemp,nreact
!	pause
ntype(nreact)=3
nsite(nreact) = i
ncomsite(nreact)=j
nspec(nreact)=ntemp
ncomspec(nreact) =ntemp1
ncomp1(nreact)=nprod1(ntemp,ico)
ncomp2(nreact)=nprod2(ntemp,ico)
react_rate(nreact) = rate_comb(ntemp,ico)     
endif

enddo

else

do ico=1,nreact_type(ntemp1,3)      

if(ntemp.eq.ncom1(ntemp1,ico) )then

nreact = nreact +1
! 				write(*,*)33332,i,ntemp,nreact
! pause
ntype(nreact)=3
nsite(nreact) = i
ncomsite(nreact)=j
nspec(nreact)=ntemp
ncomspec(nreact) =ntemp1
ncomp1(nreact)=nprod1(ntemp1,ico)
ncomp2(nreact)=nprod2(ntemp1,ico)
react_rate(nreact) = rate_comb(ntemp1,ico)      
endif

enddo

endif

!*********** end checking combination!
!     check dissociative adsorptio!
!       write(*,*)55557,!
do ida=1,nreact_type(ntemp,5)      
! c       write(*,*)'dissociative adsorption'
!	write(*,*)ntemp,nreact_type(ntemp,5)
!	write(*,*)'ntemp1: ',ntemp1,'ndads1: ',ndads1(ntemp,ida)
if(ntemp1.eq.ndads1(ntemp,ida) )then
nreact = nreact +1

!	pause
ntype(nreact)=5
ndads_des(nreact)= ndads2(ntemp,ida)

!	write(*,*)ndads_des(nreact),ndads2(ntemp,ida)
!	pause
nsite(nreact) = i
ncomsite(nreact)=j
nspec(nreact)=ntemp
ncomspec(nreact) =ntemp1
ncomp1(nreact)=ndadsp1(ntemp,ida) ! also used for dads and ddes
ncomp2(nreact)=ndadsp2(ntemp,ida) ! also used for dads and ddes
react_rate(nreact) = rate_dads(ntemp,ida)
!			write(*,*)5555,i,ntemp,nreact,react_rate(nreact)
!	write(*,*)5555,ntype(nreact),nsite(nreact),ncomsite(nreact)
!      write(*,*)5555,nspec(nreact), ncomspec(nreact)
!     &	,ncomp1(nreact),ncomp2(nreact),ida

!	  write(*,*) react_rate(nreact)
!	  pause
endif
!        write(*,*)'out if'
!	  pause
enddo



!*********** end checking dissociative adsorption!
!     check desorption from the dissociative adso!ption




if(ntemp.le.ntemp1)then
do idd=1,nreact_type(ntemp,6) 
if(ntemp1.eq.nddes1(ntemp,idd) )then
nreact = nreact +1
!				write(*,*)6666,i,ntemp,nreact
!	pause
ntype(nreact)=6

ndads_des(nreact)= nddesp3(ntemp,idd)
nsite(nreact) = i
ncomsite(nreact)=j
nspec(nreact)=ntemp
ncomspec(nreact) =ntemp1
ncomp1(nreact)=nddesp1(ntemp,idd) ! also used for dads and ddes
ncomp2(nreact)=nddesp2(ntemp,idd) ! also used for dads and ddes
react_rate(nreact) = rate_ddes(ntemp,idd)     
endif
enddo

else
do idd=1,nreact_type(ntemp1,6) 
if(ntemp1.eq.nddes1(ntemp1,idd) )then
nreact = nreact +1
!				write(*,*)66662,i,ntemp,nreact
!	pause
ntype(nreact)=6
ndads_des(nreact)= nddesp3(ntemp1,idd)
nsite(nreact) = i
ncomsite(nreact)=j
nspec(nreact)=ntemp
ncomspec(nreact) =ntemp1
ncomp1(nreact)=nddesp1(ntemp1,idd) ! also used for dads and ddes
ncomp2(nreact)=nddesp2(ntemp1,idd) ! also used for dads and ddes
react_rate(nreact) = rate_ddes(ntemp1,idd)     
endif
enddo


endif


!*********** end checking desorption from the dissociative adsorption!
27      continue 

26   continue        

ibspecieso=ibspecies !keep species at all sites before updated
!      write(*,*)'end-channels'
return
end


