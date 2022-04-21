Subroutine Table      
USE information
implicit real*8(a-h,o-z)    


nabors=0
do 1 iy=1,ncelly	  
do 2 ix=1,ncellx
ib=(iy-1)*ncellx+ix 
npoint(ib)=nabors+1

if(ncelly.eq.1)then !one-dimensional cell only!           
ib1=ix-1
if(ix.eq.1)ib1=ncellx		
if(ib.le.ib1)then
nabors=nabors+1
list(nabors)=ib1
endif

ib2=ix+1
if(ix.eq.ncellx)ib2=1
if(ib.le.ib2)then
nabors=nabors+1
list(nabors)=ib2		
endif


else !! for two-dimensional cell
!.....search neighbor cells in x direction for cell ib!!
ib1=(iy-1)*ncellx+ix-1
if(ix.eq.1)ib1=(iy-1)*ncellx+ncellx	!PBC	
if(ib.le.ib1)then
nabors=nabors+1
list(nabors)=ib1
endif

ib2=(iy-1)*ncellx+ix+1
if(ix.eq.ncellx)ib2=(iy-1)*ncellx+1 !PBC
if(ib.le.ib2)then
nabors=nabors+1
list(nabors)=ib2		
endif
!.....search neighbor cells in y direction for cell ib!!
ib3=(iy-1-1)*ncellx+ix
if(iy.eq.1)ib3=(ncelly-1)*ncellx+ix		
if(ib.le.ib3)then
nabors=nabors+1
list(nabors)=ib3
endif

ib4=(iy-1+1)*ncellx+ix
if(iy.eq.ncelly)ib4=ix
if(ib.le.ib4)then
nabors=nabors+1
list(nabors)=ib4		
endif


endif

2     continue 
1     continue
npoint(ncell+1)=nabors+1      

return
end




