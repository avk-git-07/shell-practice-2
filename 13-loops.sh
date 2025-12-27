#!/bin/bash

USERID=$(id -u)
B="\e[33m"
R="\e[31m"
G="\e[32m"
V="\e[35m"
N="\e[0m"

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$G $2 is uninstalled successfully...!!! $N"
    else
        echo -e "$R $2 is failed to uninstall...!!! $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo -e "$R Run this script with root user only...!!! $N"
    exit 1
fi


for pkg in $@
do
    dnf list installed $pkg
    if [ $? -eq 0 ]
    then
        echo -e "$V The $pkg is there in the server. So, we are uninstalling it...!!! $N"
        dnf remove $pkg -y
        VALIDATE $? $pkg
    else
        echo -e "$B The $pkg is not available, nothing to do...!!! $N"
    fi
done


