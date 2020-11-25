#!/bin/bash

((!$#)) && echo "usage: $0 <UAT#>" && exit -1
UAT=$1
for DAY in {-3..0}; do
  DATE=$(date -d "-$DAY days" +%Y%m%d)
  LOGFILENAME="/var/log/nginx/atg-access.log-$DATE"
  for HOST in atg-ps0{1,2}-$UAT; do 
    printf $(ssh $HOST  "sudo zgrep -v contacts $LOGFILENAME* 2>/dev/null | wc -l" )  && printf "\t" && echo $LOGFILENAME
  done  # |  awk '{printf "%s\t%s\n", $1, $3}'
done
