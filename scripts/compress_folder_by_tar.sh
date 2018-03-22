#!/bin/sh

DIRS=`ls -l $PWD | egrep '^d' | awk '{print $9}'`

# "ls -l $MYDIR"      = get a directory listing
# "| egrep '^d'"           = pipe to egrep and select only the directories
# "awk '{print $9}'" = pipe the result from egrep to awk and print only the 9th field

for DIR in $DIRS
do
    echo ${DIR}
    tar czvf ${DIR}.tar.gz ${DIR}
    #rm -rf ${DIR}
done
