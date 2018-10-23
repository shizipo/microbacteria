for j in 100 200 300 400 500 600;
do mkdir $j;
m=`awk 'BEGIN{print '$j'+10}'`;
for i in  2000 3000 4000 5000 6000 7000 8000 9000 10000 11000;
do echo cd "`pwd`/$j" >> ./$j/tiaoshi_$j.sh&& sed "s/--min_len \w*/--min_len $i /g" run_falcon_asm.sh |sed "s/--max_diff \w*/--max_diff $j /g" - |sed "s/--max_cov \w*/--max_cov $m /g" -  >>./$j/tiaoshi_$j.sh;
echo ";mv p_ctg.fa p_ctg.fa_$i " >>./$j/tiaoshi_$j.sh;
done ;
cd $j ;
qsub tiaoshi_$j.sh -l nodes=1:ppn=4 -q cu ;
cd .. ;
done
