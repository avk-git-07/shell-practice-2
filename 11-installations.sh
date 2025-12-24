#!/bin/bash

USERID=$(id -u)
echo "The user's id is $USERID"

if [ $USERID -ne 0 ]
then 
    echo "Plese run the script with root user"
    exit 1
fi

dnf list installed git
if [$? -ne 0]
then
    echo "The git is not yet installed, let us installed it..."
    dnf install git -y
    if [$? -ne 0]
    then
        echo "the git installation is failed.."
    else
        echo "the git installation is successful"
    fi
else
    echo "Git is already installed, nothing to do"
fi
