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
    echo "Please run the script with the root user"
    exit 1
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "MySQL is not installed, so we are installing it now.."
    dnf install mysql -y
    VALIDATE $? "MySQL"
else
    echo "MySQL is already installed, nothing to do !!!"
fi
