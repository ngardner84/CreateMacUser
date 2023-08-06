#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root."
  exit 1
fi

# Variables
USERNAME="Temp User"
USERID="501"
PASSWORD="tempPassword"

# Create the user
sysadminctl -addUser "$USERNAME" -password "$PASSWORD" -UID "$USERID" -fullName "$USERNAME" -home "/Users/$USERNAME" -admin

# Check if the user was created successfully
if [ $? -eq 0 ]; then
  echo "User '$USERNAME' created successfully."
else
  echo "Failed to create user '$USERNAME'."
fi
