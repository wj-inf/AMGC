#!/bin/sh 

exe="AMGC" #发布的程序名称

des="/mnt/hgfs/shared-18-test1/package18-3" #创建文件夹的位置

deplist=$(ldd $exe | awk  '{if (match($3,"/")){ printf("%s "),$3 } }') 

cp $deplist $des
