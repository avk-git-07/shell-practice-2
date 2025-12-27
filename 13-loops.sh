#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$G $2 is uninstalled successfully...!!! $N"
    else
        echo -e "$R $2 is failed to uninstall ...!! $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo -e "$R please run this script with root user..!!! $N"
    exit 1
fi

for pkg in $@
do
    dnf list installed $pkg
    if [ $? -eq 0 ]
    then
        echo -e "$R the $pkg is there in the server, we are removing it now ...!!! $N"
        dnf remove $pkg -y
        VALIDATE $? $pkg
    else
        echo -e "$G the $pkg is already removed, nothing to do...!!! $N"
    fi
done

