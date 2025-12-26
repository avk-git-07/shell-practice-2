#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
B="\e[33m"
Y="\e[35m"
N="\e[0m"

for i in {0..10}
do 
    echo $i
done

if [ $USERID -ne 0 ]
then
    echo -e "$R Run this script with root user $N"
    exit 1
fi

VALIDATE(){
    if [$1 -ne 0 ]
    then
        echo -e "$R $2 installation is failed..!! $N"
        exit 1
    else
        echo -e "$G $2 installation is successful...!!! $N"
    fi
}

for pkg in $@
do
    dnf list installed $pkg
    if [ $? -ne 0 ]
    then
        echo -e "$B The $? is not installed, so we are installing it now...!!! $N"
        dnf install $pkg -y
        VALIDATE $? $pkg
    else
        echo -e "$Y The $? is already installed, nothing to do ...!!! $N"
    fi
done

