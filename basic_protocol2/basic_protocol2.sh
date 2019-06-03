#!/usr/bin/bash
#
# Basic protocol 
# all commands in sequence
#
tempdir='temp_protocol2'
echo "creates a directory $tempdir and then runs"
echo " all 3 examples for the basic protocol"
mkdir -p $tempdir
cd $tempdir
cp ../../basic_protocol1/infile infile
cp ../parmfile_* .
time=`date`
echo "$time migrate-n parmfile_short (basic model [protocol1]) running now"
nohup migrate-n parmfile_short -nomenu > parm_short.log 2>parm_short.err
time=`date`
echo "$time migrate-n parmfile_model1 running now"
nohup migrate-n parmfile_model1 -nomenu > parm_model1.log 2>parm_model1.err
time=`date`
echo "$time migrate-n parmfile_model2 running now"
nohup migrate-n parmfile_model2 -nomenu > parm_model2.log 2> parm_model2.err
time=`date`
echo "$time migrate-n parmfile_model3 running now"
nohup migrate-n parmfile_model3 -nomenu > parm_model3.log 2> parm_model3.err
echo "Done"
echo "Comparison of the marginal likelihoods from all four models"
grep "All   " outfile_model[123] outfile_short | sort -n -k 4,4 | python ../bf.py
