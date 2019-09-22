#!/usr/bin/bash
# assume that we are in currentprotocols
# 
cd advanced_protocol
mkdir temp_advanced
cd temp_advanced
cp ../../basic_protocol2/temp_protocol2/outfile_* .
grep "All     " outfile_* | sort -n -k 4,4 | python ../bf.py
