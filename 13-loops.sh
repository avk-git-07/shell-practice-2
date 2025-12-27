#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$G $2 is installed successfully..!!! $N"
    else
        echo -e "$R $2 installation is failed ...!!! $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo -e "$R Please run this script with root user only..!!!"
    exit 1
fi

for pkg in $@
do 
    dnf list installed $pkg
    if [ $? -ne 0 ]
    then
        echo -e "$R $pkg is not there in the server, so we are installing it...!!! $N"
        dnf install $pkg -y
        VALIDATE $? $pkg
    else
        echo -e "$G $pkg is already installed, so nothing to do..!!! #N"
    fi
done

