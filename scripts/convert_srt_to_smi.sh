#!/bin/sh

dpkg -l | grep libsubtitles-perl
if [ $? -eq 0 ];then
    echo "CMD OK!"
else
    echo "CMD Failure!"
    sudo apt-get install libsubtitles-perl
fi

for i in `ls *.srt`
do
subs -c smi $i -o smi/$i.smi
done
