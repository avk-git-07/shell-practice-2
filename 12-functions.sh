#!/bin/bash

USERID=$(id -u)

VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo "$2 installation is failed.."
        exit 1
    else
        echo "$2 installation is successful.."
    fi
}

if [ $USERID -ne 0 ]
then
    echo -e "\e[31m Please run the script with the root user \e[0m"
    exit 1
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo -e "\e[35m MySQL is not installed, so we are installing it now.. \e[0m"
    dnf install mysql -y
    VALIDATE $? "MySQL"
else
    echo -e "\e[36m MySQL is already installed, nothing to do !!! \e[0m"
fi
