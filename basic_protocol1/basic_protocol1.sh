#!/usr/bin/bash
#
# Basic protocol 
# all commands in sequence
#
tempdir='temp_protocol1'
echo "creates a directory $tempdir and then runs"
echo " all 3 examples for the basic protocol"
mkdir -p $tempdir
cd $tempdir
cp ../infile.modern infile
cp ../parmfile_tooshort .
cp ../parmfile_short .
cp ../parmfile_default parmfile
time=`date`
echo "$time migrate-n parmfile_tooshort running now"
nohup migrate-n parmfile_tooshort -nomenu > parm_tooshort.log 2>parm_tooshort.err
time=`date`
echo "$time migrate-n parmfile_short running now"
nohup migrate-n parmfile_short -nomenu > parm_short.log 2> parm_short.err
time=`date`
echo "$time migrate-n parmfile running now"
nohup migrate-n parmfile -nomenu > parm_default.log 2> parm_default.err
echo "done"
