subroutine product     
USE information
implicit real*8(a-h,o-z)      

!...... Product by desorption !





if(ntype(npicked_react).eq.2)then !desorption
!      nprod_des = nprod_des +1

!      nprod_des1(nprod_des)= nspec(npicked_react)

nprod_des1(nspec(npicked_react))  =	 nprod_des1(nspec(npicked_react))+1

elseif(ntype(npicked_react).eq.6)then !products of two VANs

! c     nprod_des = nprod_des +1
!
!      nprod_des1(nprod_des)= nspec(npicked_react)
!
!      nprod_des = nprod_des +1
!
!      nprod_des1(nprod_des)= ncomspec(npicked_react)


nprod_des1(ndads_des(npicked_react))  = nprod_des1(ndads_des(npicked_react))+1       

endif


if(ntype(npicked_react).eq.1)then !adsorption
!      nprod_ads = nprod_ads +1

!      nprod_ads1(nprod_ads)= nspec(npicked_react)
nprod_ads1(nspec(npicked_react))  = nprod_ads1(nspec(npicked_react))+1

elseif(ntype(npicked_react).eq.5)then !adsorption
!      nprod_ads = nprod_ads +1
!      write(*,*)ndads_des(nreact)
!      nprod_ads1(nprod_ads)= nspec(npicked_react)
nprod_ads1(ndads_des(npicked_react))  = nprod_ads1(ndads_des(npicked_react))+1


endif
!	if(nprod_des.ge.1)then
!      write(*,*)'Nloop = ',nloop
!	write(*,*)nprod_des
!      write(*,*)nprod_des1(nprod_des)
!	write(*,*)specname(nprod_des1(nprod_des))
!	pause
!	endif






!      write(*,*)'end-product'

return
end


