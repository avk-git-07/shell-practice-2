#!/bin/bash

USERID=$(id -u)
echo "The user's id is $USERID"

if [ $USERID -ne 0 ]
then 
    echo "Plese run the script with root user"
    exit 1
fi

dnf list installed git
if [ $? -ne 0 ]
then
    echo "The Git is not installed, let us install it.."
    dnf install git -y
    if [ $? -ne 0 ]
    then
        echo "Git instllation is failure.."
        exit 1
    else    
        echo "Git installation is successful.."
    fi
else
    echo "The Git is already installed, nothing to do.."
    