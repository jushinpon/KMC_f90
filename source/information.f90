MODULE INFORMATION
IMPLICIT REAL*8(A-H,O-Z)

PARAMETER(nrecnum=5000000)!The maximal possible reaction No.
INTEGER,SAVE:: ntype(nrecnum),nsite(nrecnum),nspec(nrecnum)
REAL*8,SAVE:: react_rate(nrecnum),Time_go
INTEGER,SAVE:: ibspecies(100000),ibspecieso(100000)
INTEGER,SAVE:: ncomsite(nrecnum),ncomspec(nrecnum)
INTEGER,SAVE:: ncomp1(nrecnum),ncomp2(nrecnum),ndads_des(nrecnum)

INTEGER,SAVE:: npoint(500000),list(2000000)

PARAMETER(nspecies1=150,nkind= 59)  	
INTEGER,SAVE:: nreact_type(nspecies1,6)
INTEGER, SAVE::nprod(nspecies1),nsurprod(nspecies1)
!     nad(species,iad)
INTEGER,SAVE:: nad(nspecies1,nkind) 
INTEGER,SAVE:: nde(nspecies1,nkind)
INTEGER,SAVE:: ncom1(nspecies1,nkind),nprod1(nspecies1,nkind),&
               nprod2(nspecies1,nkind)
INTEGER,SAVE:: ntr(nspecies1,nkind)
INTEGER,SAVE:: ndads1(nspecies1,nkind),ndads2(nspecies1,nkind),&
	           ndadsp1(nspecies1,nkind),ndadsp2(nspecies1,nkind)

INTEGER,SAVE:: nddes1(nspecies1,nkind),nddesp1(nspecies1,nkind),&
	           nddesp2(nspecies1,nkind),nddesp3(nspecies1,nkind)

REAL*8,SAVE:: rate_ads(nspecies1,nkind)
REAL*8,SAVE:: rate_des(nspecies1,nkind)
REAL*8,SAVE:: rate_comb(nspecies1,nkind)
REAL*8,SAVE:: rate_tra(nspecies1,nkind)      
REAL*8,SAVE:: rate_dads(nspecies1,nkind)
REAL*8,SAVE:: rate_ddes(nspecies1,nkind),D0,D0ad,D0df

INTEGER,SAVE :: ncellx,ncelly,ncell,nspecies,nreact 
INTEGER,SAVE :: Npicked_react,nseed,npost,nloop
INTEGER,SAVE :: nprod_des,nprod_sur(nspecies1)
INTEGER,SAVE :: nprod_des1(nspecies1),nprod_ads,&
nprod_ads1(nspecies1)


CHARACTER(LEN=10)::specname(150)
CHARACTER First_Run

ENDMODULE
