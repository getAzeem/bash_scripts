#!/bin/bash

# Function to add a new user
add_user() {
    read -p "Enter the username you want to add: " username
    sudo useradd -m $username  # Create the user with a home directory
    echo "User $username has been added."
}

# Function to create a directory in the user's home directory
create_directory() {
    read -p "Enter the name of the user for whom the directory should be created: " username

    # Check if the user exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists."
    else
        echo "User $username does not exist. Creating user..."
        sudo useradd -m $username  # Create the user and home directory
        echo "User $username has been created."
    fi

    read -p "Enter the name of the directory to create: " dirname
    dir_path="/home/$username/$dirname"

    # Check if the directory already exists
    if [ ! -d "$dir_path" ]; then
        sudo mkdir "$dir_path"
        sudo chown $username:$username "$dir_path"
        echo "Directory $dir_path has been created."
    else
        echo "Directory $dir_path already exists."
    fi
}

# Main function to choose the action
main() {
    echo "Choose an action:"
    echo "1. Add a new user"
    echo "2. Create a directory for an existing or new user"
    read -p "Enter your choice (1 or 2): " choice

    case $choice in
        1)
            add_user
            ;;
        2)
            create_directory
            ;;
        *)
            echo "Invalid choice. Please run the script again and choose either 1 or 2."
            ;;
    esac
}

# Call the main function
main

