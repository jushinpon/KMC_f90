subroutine update
USE mt19937
USE information
implicit real*8(a-h,o-z)	

if(ntype(npicked_react).eq.1)then
nad_site=nsite(npicked_react)
ibspecies(nad_site)= nspec(npicked_react)

elseif(ntype(npicked_react).eq.2)then

nde_site=nsite(npicked_react)
ibspecies(nde_site)= 1 !!become vacancy
elseif(ntype(npicked_react).eq.3)then

nsite1 = nsite(npicked_react)
nsite2 = ncomsite(npicked_react)
if(grnd().ge.0.5d0)then
ibspecies(nsite1)= ncomp1(npicked_react)
ibspecies(nsite2)= ncomp2(npicked_react)
else
ibspecies(nsite1)= ncomp2(npicked_react)
ibspecies(nsite2)= ncomp1(npicked_react)
endif
elseif(ntype(npicked_react).eq.4)then
ntr_site=nsite(npicked_react)
ibspecies(ntr_site)= nspec(npicked_react)
elseif(ntype(npicked_react).eq.5)then
nsite1 = nsite(npicked_react)
nsite2 = ncomsite(npicked_react)
!	write(*,*)nsite1,nsite2
if(grnd().ge.0.5d0)then
ibspecies(nsite1)= ncomp1(npicked_react)
ibspecies(nsite2)= ncomp2(npicked_react)
else
ibspecies(nsite1)= ncomp2(npicked_react)
ibspecies(nsite2)= ncomp1(npicked_react)
endif
elseif(ntype(npicked_react).eq.6)then
nsite1 = nsite(npicked_react)
nsite2 = ncomsite(npicked_react)
ibspecies(nsite1)= 1
ibspecies(nsite2)= 1
endif	

!      write(*,*)'end-update'
!	write(*,*)ntype(npicked_react),nspec(npicked_react)

return
end


