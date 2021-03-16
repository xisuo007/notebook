#!/bin/bash

cd `dirname $0`
d=`date +%Y%m%d`
d7=`date -d'7 day ago' +%Y%m%d`

cd  ../logs/

cp catalina.out catalina.out.{d}
mv catalina.out.{d} catalina${d}.out
echo "" > catalina.out
rm -rf catalina${d7}.out
rm -rf catalina.*.log
rm -rf l*
rm -rf h*

