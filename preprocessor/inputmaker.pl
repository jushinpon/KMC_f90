#2011.11.24 at UQ!
#2012.06.13-- include dissociative adsorption!

print "This perl code helps you to creat the input file of Ju's kMC Fortran code!\n";
print "It was developed by Prof. Shin-Pon Ju.\n";
print "It can only be used in Ju's group or with Ju's permission!\n";

open(checkfile,">inputcheck.dat");



open(check,">checkcode.dat");

$eventfile =undef;
open(Event,"<Event.dat");
while($_= <Event>){$eventfile.=$_;}
close (event);
#print "$eventfile";
@all=split(/\n/,$eventfile);
$lineNo =@all;
$allchannels = ($lineNo-1)*2;
#print "$line";
#Skip the first line in the Event.dat! 
@species = undef;
$nspecies = 0;

for($i=1;$i<$lineNo;$i++){
	
   $line=$all[$i]; chomp($line);
   $line =~s/^\s+//g;
   @line = split(/\s+/,$line);
   $eleNo=@line; 
       for($j=1;$j<$eleNo-2;$j++){
          if($line[$j] ne "->" and $line[$j] ne "+") {
             $temp= $line[$j];
             $temp =~s/\*//g;
             $temp =~s/^[1-9]//g;	
          	if($temp ne undef){	  
	          $species[$nspecies]=$temp;
#	          print "$species[$nspecies]\n";
	          $nspecies=$nspecies+1;
	        }
	  }
	
       }	
}

$temp = @species;
##getting secies Number!
$specfin[0]="*";
$speccount = 1;
for($i=0;$i<$temp;$i++){
    $check=1;	
	for($j=0;$j<$speccount;$j++){		
	   if($species[$i] eq $specfin[$j]) { 
	       $check=0;	   		
	   }	
        }        
        if($check ==1) {	   
	   $specfin[$speccount] = $species[$i];
	   $speccount= $speccount +1;	   		
	}	     
        		
#   print "$species[$i]\n";	
}	 

print "CHECK THE TOTAL SPECIES:\n";
$finNo = @specfin;
print "SPECIES NO.: $finNo\n";
%pointer=undef;

for($i=0;$i<$finNo;$i++){
#print "$specfin[$i]\n";
$pointer{$specfin[$i]}=$i;
$i1=$i+1;
print "$specfin[$i] -> $i1\n";	
}
#starting generating kMC input file!

$rnad= int(rand()*1000000);
$temp = 600.;
$Species = $finNo;
$cellx = 25;
$celly = 25;
#Randomseed: 876543
#Temperature: 800.
#Species: 10
#Cellx: 10
#Celly: 10

$part1= "Randomseed: %d
Temperature: %.1f
Species: %d
Cellx: %d
Celly: %d";

open(input,">KMCinput.dat");
print input "First_RUN: T\n";
printf input "$part1\n",$rnad,$temp,$Species,$cellx,$celly;
#starting the analysis on all events related to each species!
$checkchannelNo=0;
for($ispe=0;$ispe<$finNo;$ispe++){

# increasing more reaction mechanism here!   	
   $nads=0;
   $ndes=0;
   $ncom=0;
   $ntra=0;
   $ndads=0;
   $nddes=0;
   
   @nads1=undef;
   @ndes1=undef;
   
   @ncom1=undef;
   @ncomp1=undef;
   @ncomp2=undef;
   
   @ntra1=undef;
   
   @ndads1=undef;
   @ndads2=undef;
   @ndadsp1=undef;
   @ndadsp2=undef;
   
   @nddes1= undef;
   @nddesp1=undef; #van
   @nddesp2=undef; #van
   @nddesp3=undef; #desorption product!
   
   
   @adsbar=undef;
   @desbar=undef;
   @combar=undef;
   @trabar=undef;
   @dadsbar=undef;
   @ddesbar=undef;
#    		
     for($i=1;$i<$lineNo;$i++){
     	$line=$all[$i]; chomp($line);
        $line =~s/^\s+//g;
        @line = split(/\s+/,$line);
        $eleNo=@line;
        $check =0;
        $reac=0;
        @reac1=undef;
        $prod =0;
        @prod1 =undef;
#check forward reaction channel!        
            for($j=1;$j<$eleNo-2;$j++){
              	
                 if($line[$j] eq "->") {$check =1;}
                   if($check ==0 and $line[$j] ne "+"){
                     $reac1[$reac]= $line[$j];
                     $reac = $reac+1;                     	
                   }elsif($check ==1 and $line[$j] ne "+" and $line[$j] ne "->"){
                     $prod1[$prod]= $line[$j];
                     $prod = $prod+1;                   	
                   }                                 	
             } #analysing reaction channel one by one!             
             $reacNo = @reac1;
             $prodNo =@prod1;
             
             
## check adsorption!
        if($ispe == 0){ 
             $adcheck =0; 
             $starNo =0;
             for ($wr=0;$wr<$reacNo;$wr++){
             	   if( $reac1[$wr] eq "*"){$starNo =$starNo +1;}                                           
             } 
             if( $starNo == 1){$adcheck =1;}     
             if($adcheck == 1){
                 for ($wr=0;$wr<$reacNo;$wr++){
                    if( $reac1[$wr] ne "*" and $prodNo < $reacNo){
                   	$nads1[$nads]= $reac1[$wr];                   	
                   	$adsbar[$nads]=$line[$eleNo-2];	
                        $nads =	$nads+1;
                    }                        
                 }             
             }
             
             $adcheck =0;
             $starNo =0; 
             for ($wr=0;$wr<$prodNo;$wr++){             	
               if( $prod1[$wr] eq "*"){$starNo =$starNo +1;}                                              
             } 
             if( $starNo == 1){$adcheck =1;}       
             if($adcheck == 1){
                 for ($wr=0;$wr<$prodNo;$wr++){
                    if( $prod1[$wr] ne "*" and $reacNo < $prodNo){
                   	$nads1[$nads]= $prod1[$wr];                   	
                   	$adsbar[$nads]=$line[$eleNo-1];	
                        $nads =	$nads+1;
                    }                                            
                 }          
             }
        }
             
#           print "ispe $ispe\n"; 
#           print "line No. $i\n"; 
#           print "adsorption Number is $nads\n";
#                   for ($wr=0;$wr<$nads;$wr++){
#                   print " rectants $nads1[$wr]\n";
#                   }             
             	   	      
## check desorption!
        
             $decheck =0;
             $starNo =0; 
             for ($wr=0;$wr<$reacNo;$wr++){
              if( $reac1[$wr] eq "*"){$starNo =$starNo +1;}                            
             }
             if( $starNo == 1){$decheck =1;} 
             
#             print " $reacNo  $prodNo\n";
#             print "decheck $decheck\n";    
             if($decheck == 1){
               if( $prodNo < $reacNo  ){
                 for ($wr=0;$wr<$prodNo;$wr++){
                 	$temp = $prod1[$wr];
                 	$temp =~s/\*//g;
#                 	print "check desorption\n";
#                 	print " 
                 	if($specfin[$ispe] eq  $temp){                
                   	$ndes1[$ndes]= $temp;
                   	$desbar[$ndes]=$line[$eleNo-1];	
                        $ndes =	$ndes+1;
                        }
                 }                        
               }             
             }
             
             $decheck =0;
             $starNo =0;
             for ($wr=0;$wr<$prodNo;$wr++){             	
                   if( $prod1[$wr] eq "*"){$starNo =$starNo +1;}                                           
             }             
             if( $starNo == 1){$decheck =1;}                  
             if($decheck == 1){
             	if( $reacNo < $prodNo ){
                   for ($wr=0;$wr<$reacNo;$wr++){
                   	$temp = $reac1[$wr];
                 	$temp =~s/\*//g;
                   	if($specfin[$ispe] eq  $temp){                     
                   	$ndes1[$ndes]= $temp;
                   	$desbar[$ndes]=$line[$eleNo-2];	
                        $ndes =	$ndes+1;
                        }
                    }                                            
                 }          
             }
       
#           print "ispe $ispe\n"; 
#           print "line No. $i\n"; 
#           print "desorption Number is $ndes\n";
#                   for ($wr=0;$wr<$ndes;$wr++){
#                   print " rectants $ndes1[$wr]\n";
#                   } 

## check combination!
   ##the first case!

             $starNo =0;
             for ($wr=0;$wr<$reacNo;$wr++){
             	   if( $reac1[$wr] eq "*"){$starNo =$starNo +1;}                                           
             }
             if( $starNo >= 2 and $specfin[$ispe] eq "*"){        
   ## when VAN No. is more than 1 for dissociated adsorption.
                  for ($wr=0;$wr<$reacNo;$wr++){
             	   if( $reac1[$wr] ne "*"){$ndads2[$ndads]=$reac1[$wr]}                                           
                 }
   
               $ndads1[$ndads]= "*";
               $temp = $prod1[0];
               $temp=~s/\*//g;
               $ndadsp1[$ndads]=$temp;
               $temp = $prod1[1];
               $temp=~s/\*//g;
               $ndadsp2[$ndads]=$temp;
               $dadsbar[$ndads]=$line[$eleNo-2];
               $ndads=$ndads+1; 
# $reacNo eq $prodNo and $reacNo gt 1 and $starNo lt 2               
             }elsif($prodNo == $reacNo and $starNo < 2){
           #   $pointer{$specfin[$i]}               
                 $temp1 = $reac1[0];
                 $temp1=~s/\*//g;
                 if($temp1 eq undef){$temp1="*";}
                 $temp2 = $reac1[1];
                 $temp2=~s/\*//g;
                 if($temp2 eq undef){$temp2="*";}
                   if($pointer{$temp1} < $pointer{$temp2} and $specfin[$ispe] eq $temp1){
                   	$ncom1[$ncom]= $temp2;
                        $temp = $prod1[0];
                        $temp=~s/\*//g;
                        $ncomp1[$ncom]=$temp;
                        if($ncomp1[$ncom] eq undef){$ncomp1[$ncom]="*";}
                        $temp = $prod1[1];
                        $temp=~s/\*//g;
                        $ncomp2[$ncom]=$temp;
                        if($ncomp2[$ncom] eq undef){$ncomp2[$ncom]="*";}
                        $combar[$ncom]=$line[$eleNo-2];
                        $ncom=$ncom+1;
                   }elsif($pointer{$temp2} <= $pointer{$temp1} and $specfin[$ispe] eq $temp2){
                   	$ncom1[$ncom]= $temp1;
                        $temp = $prod1[0];
                        $temp=~s/\*//g;
                        $ncomp1[$ncom]=$temp;
                        if($ncomp1[$ncom] eq undef){$ncomp1[$ncom]="*";}
                        $temp = $prod1[1];
                        $temp=~s/\*//g;
                        $ncomp2[$ncom]=$temp;
                        if($ncomp2[$ncom] eq undef){$ncomp2[$ncom]="*";}
                        $combar[$ncom]=$line[$eleNo-2];
                        $ncom=$ncom+1;                  	
                    }

              }elsif($prodNo > $reacNo and $reacNo >= 2 and $starNo < 2){
              	
              	 for ($wr=0;$wr<$prodNo;$wr++){
             	   if( $prod1[$wr] ne "*"){$nddesp3[$nddes]=$prod1[$wr]}                                           
                 }
                 
### for desorption from dissociative adsorption!   
               $nddesp1[$nddes]= "*";
               $nddesp2[$nddes]= "*";
               

                 $temp1 = $reac1[0];
                 $temp1=~s/\*//g;
                 if($temp1 eq undef){$temp1="*";}
                 $temp2 = $reac1[1];
                 $temp2=~s/\*//g;
                 if($temp2 eq undef){$temp2="*";}
                   if($pointer{$temp1} < $pointer{$temp2} and $specfin[$ispe] eq $temp1){
                   	$nddes1[$nddes]= $temp2;
                        
                        $ddesbar[$nddes]=$line[$eleNo-2];                       
#               print "output $reacNo +++++++++++++\n";
#               print "temp1= $temp1  temp2= $temp2\n";
#               print "$nddes $nddes1[$nddes] $nddesp1[$nddes] $nddesp2[$nddes] $nddesp3[$nddes]\n ";
#               print "barrier $ddesbar[$nddes]\n";
#               print "end output**********\n";
                       $nddes=$nddes+1; 
                   }elsif($pointer{$temp2} <= $pointer{$temp1} and $specfin[$ispe] eq $temp2){
                   	$nddes1[$nddes]= $temp1;                        
                        $ddesbar[$nddes]=$line[$eleNo-2];                        
                 
#               print "output $reacNo +++++++++++++\n";
#               print "temp1= $temp1  temp2= $temp2\n";
#               print "$nddes $nddes1[$nddes] $nddesp1[$nddes] $nddesp2[$nddes] $nddesp3[$nddes]\n ";
#               print "barrier $ddesbar[$nddes]\n";
#               print "end output**********\n";      
                       $nddes=$nddes+1;               	
               }              
        }  
   ## backward for combination search! 

             $starNo =0;
             for ($wr=0;$wr<$prodNo;$wr++){
             	   if( $prod1[$wr] eq "*"){$starNo =$starNo +1;}                                           
             }
             if( $starNo >= 2 and $specfin[$ispe] eq "*"){        
   ## when VAN No. is more than 1 for dissociated adsorption.
                  for ($wr=0;$wr<$prodNo;$wr++){
                  if( $prod1[$wr] ne "*"){$ndads2[$ndads]=$prod1[$wr]}                                           
                 }
   
               $ndads1[$ndads]= "*";
               $temp = $reac1[0];
               $temp=~s/\*//g;
               $ndadsp1[$ndads]=$temp;
               $temp = $reac1[1];
               $temp=~s/\*//g;
               $ndadsp2[$ndads]=$temp;
               $dadsbar[$ndads]=$line[$eleNo-1];
               $ndads=$ndads+1;   
               
#$reacNo eq $prodNo and $reacNo gt 1 and $starNo lt 2                 
             }elsif($prodNo == $reacNo and $starNo < 2){
           #   $pointer{$specfin[$i]}               
                 $temp1 = $prod1[0];
                 $temp1=~s/\*//g;
                 if($temp1 eq undef){$temp1="*";}
                 $temp2 = $prod1[1];
                 $temp2=~s/\*//g;
                 
                  if($specfin[$ispe] eq O and ($temp1 eq O or $temp2 eq O) ){ 
                 print check "main loop species: $ispe $specfin[$ispe]\n";
                 print check "pointer{temp1}= $pointer{$temp1}\n pointer{temp2} =$pointer{$temp2} \n";
                 print check "temp1 = $temp1 temp2= $temp2\n";
                 print check "\n\n"; 
                               }
                 
                 
                 if($temp2 eq undef){$temp2="*";}
                   if($pointer{$temp1} <= $pointer{$temp2} and $specfin[$ispe] eq $temp1){
                   	
                   	if($specfin[$ispe] eq O and ($temp1 eq O or $temp2 eq O) ){
                 print check "********temp1 le temp2\n"; 
                 print check "main loop species: $ispe $specfin[$ispe]\n";
                 print check "pointer{temp1}= $pointer{$temp1}\n pointer{temp2} =$pointer{$temp2} \n";
                 print check "$temp1 $temp2\n";
                 print check "\n\n"; 
                               } 
                   	
                   	
                   	
                   	
                   	$ncom1[$ncom]= $temp2;
                        $temp = $reac1[0];
                        $temp=~s/\*//g;
                        $ncomp1[$ncom]=$temp;
                        if($ncomp1[$ncom] eq undef){$ncomp1[$ncom]="*";}
                        $temp = $reac1[1];
                        $temp=~s/\*//g;
                        $ncomp2[$ncom]=$temp;
                        if($ncomp2[$ncom] eq undef){$ncomp2[$ncom]="*";}
                        $combar[$ncom]=$line[$eleNo-1];
                        $ncom=$ncom+1;
                   }elsif($pointer{$temp2} < $pointer{$temp1} and $specfin[$ispe] eq $temp2){
                   	
                   	 if($specfin[$ispe] eq O and ($temp1 eq O or $temp2 eq O) ){
                 print check "************temp1 gt temp2\n"; 
                 print check "main loop species: $ispe $specfin[$ispe]\n";
                 print check "pointer{temp1}= $pointer{$temp1}\n pointer{temp2} =$pointer{$temp2} \n";
                 print check "$temp1 $temp2\n";
                 print check "\n\n"; 
                              }                  	
                   	$ncom1[$ncom]= $temp1;
                        $temp = $reac1[0];
                        $temp=~s/\*//g;
                        $ncomp1[$ncom]=$temp;
                        if($ncomp1[$ncom] eq undef){$ncomp1[$ncom]="*";}
                        $temp = $reac1[1];
                        $temp=~s/\*//g;
                        $ncomp2[$ncom]=$temp;
                        if($ncomp2[$ncom] eq undef){$ncomp2[$ncom]="*";}
                        $combar[$ncom]=$line[$eleNo-1];
                        $ncom=$ncom+1;                  	
                    }
                }elsif($prodNo < $reacNo and $prodNo >= 2 and $starNo < 2){
              	
              	      for ($wr=0;$wr<$reacNo;$wr++){
             	   if( $reac1[$wr] ne "*"){$nddesp3[$nddes]=$reac1[$wr]}                                           
                 }
                 
### for desorption from dissociative adsorption!   
               $nddesp1[$nddes]= "*";
               $nddesp2[$nddes]= "*";
               

                 $temp1 = $prod1[0];
                 $temp1=~s/\*//g;
                 if($temp1 eq undef){$temp1="*";}
                 $temp2 = $prod1[1];
                 $temp2=~s/\*//g;
                 if($temp2 eq undef){$temp2="*";}
                   if($pointer{$temp1} < $pointer{$temp2} and $specfin[$ispe] eq $temp1){
                   	$nddes1[$nddes]= $temp2;
                        
                        $ddesbar[$nddes]=$line[$eleNo-1];                       
#               print "output $reacNo +++++++++++++\n";
#               print "temp1= $temp1  temp2= $temp2\n";
#               print "$nddes $nddes1[$nddes] $nddesp1[$nddes] $nddesp2[$nddes] $nddesp3[$nddes]\n ";
#               print "barrier $ddesbar[$nddes]\n";
#               print "end output**********\n";
                       $nddes=$nddes+1; 
                   }elsif($pointer{$temp2} <= $pointer{$temp1} and $specfin[$ispe] eq $temp2){
                   	$nddes1[$nddes]= $temp1;                        
                        $ddesbar[$nddes]=$line[$eleNo-1];                        
                 
#               print "output $reacNo +++++++++++++\n";
#               print "temp1= $temp1  temp2= $temp2\n";
#               print "$nddes $nddes1[$nddes] $nddesp1[$nddes] $nddesp2[$nddes] $nddesp3[$nddes]\n ";
#               print "barrier $ddesbar[$nddes]\n";
#               print "end output**********\n";      
                       $nddes=$nddes+1;               	
               }
        }
              

## check transformation!
             if($reacNo == $prodNo and $reacNo == 1){
             	 $temp=$reac1[0];
#             	 print "temp is $temp\n";
             	 $temp=~s/\*//g;
#             	 print "temp is $temp and $specfin[$ispe]\n";
      	           if ($specfin[$ispe] eq $temp){
      	           	$temp=$prod1[0];
             	        $temp=~s/\*//g;
      	             $ntra1[$ntra]=$temp;
      	             $trabar[$ntra]=$line[$eleNo-2];
      	             $ntra = $ntra+1;      	 
                   }
             }	                                   
             if($reacNo == $prodNo and $reacNo == 1){
             	  $temp=$prod1[0];
             	  $temp=~s/\*//g;
      	            if ($specfin[$ispe] eq $temp){
      	              $temp=$reac1[0];
             	      $temp=~s/\*//g;
      	              $ntra1[$ntra]=$temp;
      	              $trabar[$ntra]=$line[$eleNo-1];
      	              $ntra = $ntra+1;      	 
                    }
             }                    	
      }
      $ispe1=$ispe+1;
      $temp=$specfin[$ispe];
      if($temp eq "*"){$temp="VAN";}
###################### For writing input file##########
          printf input "***species $ispe1 $temp\n";
          printf input "%d\n",$nads;
              for($wr=0;$wr<$nads;$wr++){                  
                   $pointer1 =	$pointer{$nads1[$wr]}+1;	
                   printf input "%d %.3f\n", $pointer1,$adsbar[$wr];                   
              }
          printf input "%d\n",$ndes;
              for ($wr=0;$wr<$ndes;$wr++){                 
                   $pointer1 =	$pointer{$ndes1[$wr]}+1;
                   printf input "%d %.3f\n", $pointer1,$desbar[$wr];                   
              }
          printf input "%d\n",$ncom;          
              for ($wr=0;$wr<$ncom;$wr++){                  
                   $pointer1 =	$pointer{$ncom1[$wr]}+1;                   
                   $pointer2 =	$pointer{$ncomp1[$wr]}+1;                   
                   $pointer3 =	$pointer{$ncomp2[$wr]}+1;
                   printf input "%d %d %d %.3f\n",$pointer1,$pointer2,$pointer3,$combar[$wr];                   
              }
          printf input "%d\n",$ntra;          
              for ($wr=0;$wr<$ntra;$wr++){                   
                   $pointer1 = $pointer{$ntra1[$wr]}+1;
                   printf input "%d %.3f\n", $pointer1,$trabar[$wr];
                   }
          printf input "%d\n",$ndads;          
              for ($wr=0;$wr<$ndads;$wr++){                  
                   $pointer1 =	$pointer{$ndads1[$wr]}+1;                   
                   $pointer2 =	$pointer{$ndads2[$wr]}+1;                   
                   $pointer3 =	$pointer{$ndadsp1[$wr]}+1;
                   $pointer4 =	$pointer{$ndadsp2[$wr]}+1;
                   printf input "%d %d %d %d %.3f\n",$pointer1,$pointer2,$pointer3,$pointer4,$dadsbar[$wr];                   
              }
           printf input "%d\n",$nddes;          
              for ($wr=0;$wr<$nddes;$wr++){                  
                   $pointer1 =	$pointer{$nddes1[$wr]}+1;                   
                   $pointer2 =	$pointer{$nddesp1[$wr]}+1;                   
                   $pointer3 =	$pointer{$nddesp2[$wr]}+1;
                   $pointer4 =	$pointer{$nddesp3[$wr]}+1;
                   printf input "%d %d %d %d %.3f\n",$pointer1,$pointer2,$pointer3,$pointer4,$ddesbar[$wr];                   
              }   
                        
                   
                   
                     
#######################################################      
#            print "\n";
            
            print checkfile "=====ispe $ispe1 $specfin[$ispe]\n"; 
            $checkchannelNo=$checkchannelNo+$nads;
            print checkfile "adsorption Number is $nads\n";
                   for ($wr=0;$wr<$nads;$wr++){
                   $wr1=$wr+1;
                   print checkfile "Adsorption No: $wr1\n";
                   $pointer1 =	$pointer{$nads1[$wr]}+1;	
                   print checkfile "species: $nads1[$wr] $pointer1\n";
                   print checkfile "adsbar: $adsbar[$wr]\n";
                   print checkfile "\n";
                   }
#            print  "\n";
            $checkchannelNo=$checkchannelNo+$ndes;           
            print checkfile "desorption Number is $ndes\n";
                   for ($wr=0;$wr<$ndes;$wr++){
                   $wr1=$wr+1;
                   print checkfile "Desorption No: $wr1\n";
                   $pointer1 =	$pointer{$ndes1[$wr]}+1;	
                   print checkfile "species: $ndes1[$wr] $pointer1\n";
                   print checkfile "desbar: $desbar[$wr]\n";
                   print checkfile "\n";
                   }
            print checkfile "\n";
            $checkchannelNo=$checkchannelNo+$ncom;       
            print checkfile "combination Number is $ncom\n";
                   for ($wr=0;$wr<$ncom;$wr++){
                   	$wr1=$wr+1;
                   print checkfile "Combination No: $wr1\n";
                   $pointer1 =	$pointer{$ncom1[$wr]}+1;
                   print checkfile "species ncom1: $ncom1[$wr] $pointer1\n";
                   $pointer2 =	$pointer{$ncomp1[$wr]}+1;
                   print checkfile "species ncomp1: $ncomp1[$wr] $pointer2\n";
                   $pointer3 =	$pointer{$ncomp2[$wr]}+1;
                   print checkfile "species ncomp2: $ncomp2[$wr] $pointer3\n";
                   print checkfile "combar: $combar[$wr]\n";
                   print checkfile "\n";
                   }
            print checkfile "\n";
            $checkchannelNo=$checkchannelNo+$ntra;
            print checkfile "transformation Number is $ntra\n";
                   for ($wr=0;$wr<$ntra;$wr++){
                   $wr1=$wr+1;
                   $pointer1 = $pointer{$ntra1[$wr]}+1;
                   print checkfile "Transformation No: $wr1\n";	
                   print checkfile "species: $ntra1[0] $pointer1\n";
                   print checkfile "trabar: $trabar[0]\n";
                   }
            print checkfile "\n";     
            $checkchannelNo=$checkchannelNo+$ndads;       
            print checkfile "dissociative adsorption Number is $ndads\n";
                   for ($wr=0;$wr<$ndads;$wr++){
                   	$wr1=$wr+1;
                   print checkfile "dissociative adsorption No: $wr1\n";
                   $pointer1 =	$pointer{$ndads1[$wr]}+1;
                   print checkfile "species ndads1: $ndads1[$wr] $pointer1\n";
                   $pointer2 =	$pointer{$ndads2[$wr]}+1;
                   print checkfile "species ndads2: $ndads2[$wr] $pointer2\n";
                   $pointer3 =	$pointer{$ndadsp1[$wr]}+1;
                   print checkfile "species ndadsp1: $ndadsp1[$wr] $pointer3\n";
                   $pointer4 =	$pointer{$ndadsp2[$wr]}+1;
                   print checkfile "species ndadsp2: $ndadsp2[$wr] $pointer4\n";                  
                   }
               print checkfile "\n"; 
                   
            $checkchannelNo=$checkchannelNo+$nddes;       
            print checkfile "desorption number for dissociative adsorption is $ndads\n";
                   for ($wr=0;$wr<$nddes;$wr++){
                   	$wr1=$wr+1;
                   print checkfile "desorption No of dissociative adsorption : $wr1\n";
                   $pointer1 =	$pointer{$nddes1[$wr]}+1;
                   print checkfile "species nddes1: $nddes1[$wr] $pointer1\n";
                   $pointer2 =	$pointer{$nddesp1[$wr]}+1;
                   print checkfile "species nddesp1: $nddesp1[$wr] $pointer2\n";
                   $pointer3 =	$pointer{$nddesp2[$wr]}+1;
                   print checkfile "species nddesp2: $nddesp2[$wr] $pointer3\n";
                   $pointer4 =	$pointer{$nddesp3[$wr]}+1;
                   print checkfile "species nddesp3: $nddesp3[$wr] $pointer4\n";                  
                   }    
                              
            print checkfile "\n";      
}
print checkfile "all reaction channel Number: $allchannels\n";
print checkfile "all channels considered by this Perl code: $checkchannelNo\n";



if($allchannels != $checkchannelNo){
	print  "all reaction channel Number: $allchannels\n";
        print  "all channels considered by this Perl code: $checkchannelNo\n\n";	
	print "*************************\n";
	print "Required reaction channels are not equal to the total Number obtained by this Perl!\n";
	print "Wrong kMC INPUT FILE!!!\n";
	print "*************************\n";
}
close(input);

close(check);
close(checkfile);	