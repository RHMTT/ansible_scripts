#!/bin/bash

# Check if the script is run as root, since accessing all users might require it
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# List all users from /etc/passwd file
echo "User List with Last Login Time:"
echo "---------------------------------"

# Iterate over each user
cut -d: -f1 /etc/passwd | while read user; do
    # Skip system users that don't have login privileges
    if id "$user" &>/dev/null && [ -n "$(lastlog -u "$user" | grep -v "Never logged in")" ]; then
        last_login=$(lastlog -u "$user" | tail -n 1 | awk '{print $4, $5, $6, $7}')
        echo "$user: $last_login"
    fi
done
