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

# Function to check if the USERID exists
user_id_exists() {
  if dscl . -list /Users UniqueID | awk '{print $2}' | grep -q "^$1$"; then
    return 0
  else
    return 1
  fi
}

# Increment USERID if it already exists
while user_id_exists $USERID; do
  USERID=$((USERID + 1))
done

# Create the user
sysadminctl -addUser "$USERNAME" -password "$PASSWORD" -UID "$USERID" -fullName "$USERNAME" -home "/Users/$USERNAME" -admin

# Check if the user was created successfully
if [ $? -eq 0 ]; then
  echo "User '$USERNAME' created successfully with UID $USERID."
else
  echo "Failed to create user '$USERNAME'."
fi
