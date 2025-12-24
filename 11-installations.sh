#!/bin/bash

USERID=$(id -u)
echo "The user's id is $USERID"

if [ $USERID -ne 0 ]
then 
    echo "Plese run the script with root user"
    exit 1
fi
