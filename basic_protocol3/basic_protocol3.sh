#!/usr/bin/bash
# we assume your are in currentprotocols
cd basic_protocol3
mkdir temp_protocol3
cd temp_protocol3
cp ../../basic_protocol1/infile .
cp ../../basic_protocol2/temp_protocol2/parmfile_model3 parmfile_priorx
sed 's/bayes-priors= THETA .*/bayes-priors= THETA * * EXPPRIOR: 0.000000 0.060000 0.100000/g;s/bayes-priors= SPLITSTD .*/bayes-priors= SPLITSTD * * UNIFORMPRIOR: 0.000000 0.100000 0.010000/g;s/bayes-priors= SPLIT \*.*/bayes-priors= SPLIT * * UNIFORMPRIOR: 0.000000 0.100000 0.010000/g;s/_model3/_prior/g;' < parmfile_priorx > parmfile_prior
rm parmfile_priorx
migrate-n parmfile_prior -nomenu
