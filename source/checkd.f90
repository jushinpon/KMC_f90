subroutine checkd

USE information
implicit real*8(a-h,o-z)
character*20 fname

WRITE(fname,'(a4,i3.3,a4)')'dKMC',nloop,'.dat'

open(113,file=fname,status='unknown')
write(113,*)'THE TOTAL POSSIBLE CHANNELS: ',nreact

write(113,*) 
do i=1,nreact
if(ntype(i).eq.1)then
write(113,*)"REACTION: ",i
write(113,*)"ADSORPTION"
write(113,*)"At site ",nsite(i)
write(113,*)"ADSORBED SPECIES: ",specname(nspec(i))
write(113,*)"SPECIES No.: ",nspec(i)
write(113,*)"RATE CONSTANT: ",react_rate(i)	    
write(113,*) 
elseif(ntype(i).eq.2)then
write(113,*)"REACTION: ",i          
write(113,*)"DESORPTION"
write(113,*)"At site ",nsite(i)
write(113,*)"DESORBED SPECIES: ",specname(nspec(i))
write(113,*)"SPECIES No.: ",nspec(i)
write(113,*)"RATE CONSTANT: ",react_rate(i)
write(113,*) 
elseif(ntype(i).eq.3)then
write(113,*)"REACTION: ",i           
write(113,*)"COMBINATION"
write(113,*)"At site1 and site2 ",nsite(i),ncomsite(i)
write(113,*)"REACTANTS: ",specname(nspec(i)),specname(ncomspec(i))
write(113,*)"PRODUCTS: ",specname(ncomp1(i)),specname(ncomp2(i)) 	  
write(113,*)"RATE CONSTANT: ",react_rate(i)
write(113,*) 
elseif(ntype(i).eq.4)then
write(113,*)"REACTION: ",i           
write(113,*)"TRANSFORMATION"
write(113,*)"At site ",nsite(i)
write(113,*)"TRANSFERRED SPECIES: ",specname(ibspecieso(nsite(i)))
write(113,*)"OUTPUT SPECIES: ",specname(nspec(i))
write(113,*)"SPECIES No.: ",nspec(i)
write(113,*)"RATE CONSTANT: ",react_rate(i)
write(113,*) 
elseif(ntype(i).eq.5)then
write(113,*)"REACTION: ",i           
write(113,*)"dissociative adsorption"
write(113,*)"At site1 and site2 ",nsite(i),ncomsite(i)
write(113,*)"REACTANTS: ",specname(nspec(i)),specname(ncomspec(i))
write(113,*)"PRODUCTS: ",specname(ncomp1(i)),specname(ncomp2(i)) 	  
write(113,*)"RATE CONSTANT: ",react_rate(i)
write(113,*) 
elseif(ntype(i).eq.6)then
write(113,*)"REACTION: ",i           
write(113,*)"desorption from dissociative adsorption"
write(113,*)"At site1 and site2 ",nsite(i),ncomsite(i)
write(113,*)"REACTANTS: ",specname(nspec(i)),specname(ncomspec(i))
write(113,*)"PRODUCTS: ",specname(ncomp1(i)),specname(ncomp2(i)) 	  
write(113,*)"RATE CONSTANT: ",react_rate(i)
write(113,*) 


endif 
enddo



write(113,*) 
write(113,*)"***************************************" 
write(113,*) 
write(113,*)"PICKED REACTION: ",npicked_react



i=npicked_react
if(ntype(i).eq.1)then
write(113,*)"REACTION: ",i
write(113,*)"ADSORPTION"
write(113,*)"At site ",nsite(i)
write(113,*)"ADSORBED SPECIES: ",specname(nspec(i))
write(113,*)"SPECIES No.: ",nspec(i)
write(113,*)"RATE CONSTANT: ",react_rate(i)	    
write(113,*) 
elseif(ntype(i).eq.2)then
write(113,*)"REACTION: ",i          
write(113,*)"DESORPTION"
write(113,*)"At site ",nsite(i)
write(113,*)"DESORBED SPECIES: ",specname(nspec(i))
write(113,*)"SPECIES No.: ",nspec(i)
write(113,*)"RATE CONSTANT: ",react_rate(i)
write(113,*) 
elseif(ntype(i).eq.3)then
write(113,*)"REACTION: ",i           
write(113,*)"COMBINATION"
write(113,*)"At site1 and site2 ",nsite(i),ncomsite(i)
write(113,*)"REACTANTS: ",specname(nspec(i)),specname(ncomspec(i))
write(113,*)"PRODUCTS: ",specname(ncomp1(i)),specname(ncomp2(i)) 	  
write(113,*)"RATE CONSTANT: ",react_rate(i)
write(113,*) 
elseif(ntype(i).eq.4)then
write(113,*)"REACTION: ",i           
write(113,*)"TRANSFORMATION"
write(113,*)"At site ",nsite(i)
write(113,*)"TRANSFERRED SPECIES: ",specname(ibspecies(nsite(i)))
write(113,*)"OUTPUT SPECIES: ",specname(nspec(i))
write(113,*)"SPECIES No.: ",nspec(i)
write(113,*)"RATE CONSTANT: ",react_rate(i)
write(113,*) 
elseif(ntype(i).eq.5)then
write(113,*)"REACTION: ",i           
write(113,*)"dissociative adsorption"
write(113,*)"At site1 and site2 ",nsite(i),ncomsite(i)
write(113,*)"REACTANTS: ",specname(nspec(i)),specname(ncomspec(i))
write(113,*)"PRODUCTS: ",specname(ncomp1(i)),specname(ncomp2(i)) 	  
write(113,*)"RATE CONSTANT: ",react_rate(i)
write(113,*) 

elseif(ntype(i).eq.6)then
write(113,*)"REACTION: ",i           
write(113,*)"desorption from dissociative adsorption"
write(113,*)"At site1 and site2 ",nsite(i),ncomsite(i)
write(113,*)"REACTANTS: ",specname(nspec(i)),specname(ncomspec(i))
write(113,*)"PRODUCTS: ",specname(ncomp1(i)),specname(ncomp2(i)) 	  
write(113,*)"RATE CONSTANT: ",react_rate(i)
write(113,*) 
endif

write(113,*)"***************************************" 
write(113,*) 
write(113,*)"The system at time of ",Time_go," second"

do i=1,ncell 

if(ntype(npicked_react).eq.3.or.ntype(npicked_react).eq.5.or. &
       ntype(npicked_react).eq.6)then  
if(i.eq.nsite(npicked_react).or.i.eq. &
            		  ncomsite(npicked_react))then	       
write(113,*)'*',i,specname(ibspecieso(i)), &
	    specname(ibspecies(i))
else
write(113,*)i,specname(ibspecieso(i)),&
		            specname(ibspecies(i))
endif
else
if(i.eq.nsite(npicked_react))then
write(113,*)'*',i,specname(ibspecieso(i)), &
	    specname(ibspecies(i))
else
write(113,*)i,specname(ibspecieso(i)), &
         			specname(ibspecies(i))
endif
endif
enddo



close(113)

end  
