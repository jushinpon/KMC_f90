subroutine picktime
USE mt19937
USE information
implicit real*8(a-h,o-z)      


total_rate = 0.d0
do i=1,nreact
total_rate=total_rate+ react_rate(i) !!i�O����?�C�ӵo�ͪ�����
enddo

rand=grnd()
!	write(*,*)'rand = ',rand
picked_react=total_rate*rand

temp_rate = 0.d0
do i=1,nreact
temp_rate=temp_rate+ react_rate(i)    !!i�O����?
if(temp_rate.ge.picked_react)then 
npicked_react=i
!	 write(*,*) temp_rate,picked_react
!	write(*,*)npick_nreact
!	pause
goto 123
endif
enddo

123   continue

del_t=-log(grnd())/total_rate

Time_go=Time_go+del_t

!      write(*,*)'end-picktime',del_t,ntype(npicked_react)
!	i=npicked_react
!	 if(ntype(i).eq.1)then
!	     write(*,*)REACTION: ,i
!           write(*,*)ADSORPTION
!	     write(*,*)At site,nsite(i)
!	     write(*,*)ADSORBED SPECIES: ,specname(nspec(i))
!	     write(*,*)SPECIES No.: ,nspec(i)
!		 write(*,*)RATE CONSTANT: ,react_rate(i)
!	     write(*,*) 
!	  elseif(ntype(i).eq.2)then
!	     write(*,*)REACTION: ,i
!           write(*,*)DESORPTION
!	     write(*,*)At site,nsite(i)
!	     write(*,*)DESORBED SPECIES: ,specname(nspec(i))
!	     write(*,*)SPECIES No.: ,nspec(i)
!	     write(*,*)RATE CONSTANT: ,react_rate(i)
!	     write(*,*) 
!        elseif(ntype(i).eq.3)then
!	     write(*,*)REACTION: ,i
!           write(*,*)COMBINATION
!	     write(*,*)At site1 and site2,nsite(i),ncomsite(i)
!	     write(*,*)REACTANTS: ,specname(nspec(i))
!     &	           ,specname(ncomspec(i))
!	     write(*,*)PRODUCTS: ,specname(ncomp1(i))
!     &               ,specname(ncomp2(i))
!	     write(*,*)RATE CONSTANT: ,react_rate(i)
!	     write(*,*) 
!        elseif(ntype(i).eq.4)then
!	     write(*,*)REACTION: ,i
!           write(*,*)TRANSFORMATION
!	     write(*,*)At site,nsite(i)
!           write(*,*)TRANSFERRED SPECIES: ,
!     &        	 specname(ibspecies(nsite(i)))
!	     write(*,*)OUTPUT SPECIES: ,specname(nspec(i))
!	     write(*,*)SPECIES No.: ,nspec(i)
!	     write(*,*)RATE CONSTANT: ,react_rate(i)
!	     write(*,*) 
!        endif
!
!      write(*,*) 

return
end


