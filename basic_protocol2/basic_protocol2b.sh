#!/usr/bin/bash
#
# Basic protocol 
# all commands in sequence
#
tempdir='temp_protocol2'
echo "creates a directory $tempdir and then runs"
echo "all 3 examples for default runs for the basic protocol 2"
echo "[This script takes hours to run]"
mkdir -p $tempdir
cd $tempdir
cp ../../basic_protocol1/infile infile
cp ../../basic_protocol1/parmfile_* .
time=`date`
echo "$time migrate-n parmfile_default (basic model [protocol1]) running now"
nohup migrate-n parmfile_default -nomenu > parm_default.log 2>parm_default.err
#
time=`date`
echo "$time migrate-n parmfile_model1 running now"
sed 's/_default/_model1b/g;s/population-relabel={1}/population-relabel={1 2 3}/g;s/custom-migration={\*\*}/custom-migration={x00 xx0 0xx}/g;' < parmfile_default > parmfile_model1b
nohup migrate-n parmfile_model1b -nomenu > parm_model1b.log 2>parm_model1b.err
#
time=`date`
echo "$time migrate-n parmfile_model2 running now"
sed 's/_default/_model2b/g;s/population-relabel={1}/population-relabel={1 2 3}/g;s/custom-migration={\*\*}/custom-migration={x00 Dx0 0Dx}/g;' < parmfile_default > parmfile_model2b
nohup migrate-n parmfile_model2b -nomenu > parm_model2b.log 2> parm_model2b.err
#
time=`date`
echo "$time migrate-n parmfile_model3 running now"
sed 's/_default/_model3b/g;s/population-relabel={1}/population-relabel={1 1 2}/g;s/custom-migration={\*\*}/custom-migration={x0 dx}/g;' < parmfile_default > parmfile_model3b
nohup migrate-n parmfile_model3b -nomenu > parm_model3b.log 2> parm_model3b.err
echo "Done"
echo "Comparison of the marginal likelihoods from all four models"
grep "All   " outfile_model[123]b outfile_default | sort -n -k 4,4 | python ../bf.py
