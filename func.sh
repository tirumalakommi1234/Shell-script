#!/bin/bash

# Get the current user ID
USERID=$(id -u)

# Function to validate command execution
VALIDATE() {
    if [ $1 -ne 0 ]
    then
        echo "$2 ... FAILURE"
        exit 1
    else
        echo "$2 ... SUCCESS"
    fi
}

# Check if the user has root or sudo access
if [ $USERID -ne 0 ]
then
    echo "ERROR: You must have root or sudo access to execute the script."
    exit 1
fi

echo "You have root access. Continuing with installation..."

# -------------------------
# Install MySQL
# -------------------------
dnf list installed mysql &>/dev/null

if [ $? -ne 0 ]
then
    echo "MySQL is not installed. Installing..."
    dnf install mysql -y
    VALIDATE $? "Installing MySQL"
else
    echo "MySQL is already installed."
fi

# -------------------------
# Install Git
# -------------------------
dnf list installed git &>/dev/null

if [ $? -ne 0 ]
then
    echo "Git is not installed. Installing..."
    dnf install git -y
    VALIDATE $? "Installing Git"
else
    echo "Git is already installed."
fi

echo "Script execution completed successfully."