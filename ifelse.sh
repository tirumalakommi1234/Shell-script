#!/bin/bash

# Check if MySQL is already installed
if command -v mysql &> /dev/null
then
    echo "MySQL is already installed."
else
    echo "MySQL is not installed."
    echo "Installing MySQL..."

    # Detect the package manager
    if command -v yum &> /dev/null
    then
        sudo yum install -y mysql-server
    elif command -v dnf &> /dev/null
    then
        sudo dnf install -y mysql-server
    elif command -v apt &> /dev/null
    then
        sudo apt update
        sudo apt install -y mysql-server
    else
        echo "Unsupported Linux distribution."
        exit 1
    fi

    # Check if installation was successful
    if [ $? -eq 0 ]
    then
        echo "MySQL installed successfully."

        # Start MySQL service
        sudo systemctl start mysqld 2>/dev/null || sudo systemctl start mysql

        # Enable MySQL service on boot
        sudo systemctl enable mysqld 2>/dev/null || sudo systemctl enable mysql

        echo "MySQL service started and enabled."
    else
        echo "MySQL installation failed."
    fi
fi