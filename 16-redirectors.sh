#!/bin/bash

LOGS_FOLDER_2="/var/logs/shell-script2/"
LOG_FILE_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER_2-$LOG_FILE_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER_2

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USAGE(){
    echo -e "$R USAGE: sudo sh 16-redirectors.sh package-1 package-2 etc., like this..$N" | tee -a $LOG_FILE
    exit 1
}

if [ $USERID -ne 0 ]
then
    echo -e "$R run this script with root user" | tee -a $LOG_FILE
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$R $2 failed the installation..!! $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$G $2 installation is successfull...!!! $N" | tee -a $LOG_FILE
        echo ""
    fi
}

if [ $# -eq 0 ]
then
    USAGE
fi

for pkg in $@
do 
    dnf list installed $pkg &>> $LOG_FILE
    if [ $? -ne 0 ]
    then
        echo -e "$R the $pkg is not installed, so let us install it...!!! $N" | tee -a $LOG_FILE
        echo ""
        dnf install $pkg -y &>> $LOG_FILE
        echo "************************************** $pkg is installed *****************************************" | tee -a $LOG_FILE
        echo"" | tee -a $LOG_FILE
        VALIDATE $? $pkg
    else
        echo -e "$G the $pkg is already installed, nothing to do...!!! $N"
        echo ""
    fi
done


