#su to bin with noise
#ex) obseved_0077.su to observed_0077.su & observed_0077.bin (in noise directory)

input_file=observed		#input file name before file number
fnum_min=1			#min file num
fnum_max=92			#max file num
sn_range=400			#set sn range +- 20%
make_dir=./noise		#make output file directory 
su_dir=${make_dir}/su
bin_dir=${make_dir}/bin

RANDOM=$$
percl=$[$sn_range*120/100]
percr=$[$sn_range*80/100]
sn_num=$[$percl-$percr+1]



mkdir $make_dir
mkdir $su_dir
mkdir $bin_dir


for i in `eval echo {$fnum_min..$fnum_max}` 


do
	if [ $i -lt 10 ]
	then

        num=$[$RANDOM%$sn_num+$percr]
        
	suaddnoise <${input_file}_000$i.su sn=$num noise=gauss seed=from_clock >${su_dir}/${input_file}_000$i.su
        
	sustrip <${su_dir}/${input_file}_000$i.su >${bin_dir}/${input_file}_000$i.bin



elif [ $i -ge 10 ] && [ $i -lt 100 ]
then

        num=$[$RANDOM%$sn_num+$percr]	
	
	suaddnoise <${input_file}_00$i.su sn=$num noise=gauss seed=from_clock >${su_dir}/${input_file}_00$i.su
        
	sustrip <${su_dir}/${input_file}_00$i.su >${bin_dir}/${input_file}_00$i.bin



elif [ $i -ge 100 ] && [ $i -lt 1000 ]
then

        num=$[$RANDOM%$sn_num+$percr]
        
	suaddnoise <${input_file}_0$i.su sn=$num noise=gauss seed=from_clock >${su_dir}/${input_file}_0$i.su
        
	sustrip <${su_dir}/${input_file}_0$i.su >${bin_dir}/${input_file}_0$i.bin



else

      num=$[$RANDOM%$sn_num+$percr]	
      
      suaddnoise <${input_file}.$i.su sn=$num noise=gauss seed=from_clock >${su_dir}/${input_file}_$i.su
      
      sustrip <${su_dir}/${input_file}_$i.su >${bin_dir}/${input_file}_$i.bin


	fi


done






