#!/bin/bash

USERID=$(id -u)
R=\e[31m
G=\e[32m
N=\e[0m

for i in {0..10}
do 
    echo $i
done

if [ $USERID -ne 0 ]
then
    echo -e "$R Run this script with root user $N"
    exit 1
fi
