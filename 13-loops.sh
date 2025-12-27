#!/bin/bash

USERID=$(id -u)
B="\e[33m"
G="\e[31m"
R="\e[32m"
Y="\e[35m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
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
    if [ $? -e 0 ]
    then
        echo -e "$Y The $pkg is there in the server. So, we are uninstalling it...!!! $N"
        dnf remove $pkg -y
        VALIDATE $? $pkg
    else
        echo -e "$G The $pkg is not available, nothing to do...!!! $N"
    fi
done


