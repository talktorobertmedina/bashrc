#!/bin/bash

# TODO: need to add a command line argument parser
# It needs to check for verbose flags
# The reason why I want this is so each function can check if the verbose flag exists and then print to console appropriately


# Error codes are defined here for ease of use
readonly CMD_ARG_ERR=1
readonly BAD_INSTALL_DIR=2
readonly MISSING_INSTALL_REQUIREMENT=3

# Print usage of program
function print_usage {
	echo "Usage:"
	echo "..........install directory - directory where you would like to install bashrc"
}

# Generic user input prompt
# Returns true if the user accepts and false if the user denies
function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

# Check if a command exist
# Arguments: $1 is the command
# Returns true if it does exist and false if it does not.
function command_exist {
    return $(hash "$1" >/dev/null 2>&1)
}

# Checks installation requirements before executing a script
function preinstall_check {
    echo "Checking prerequisites for installation..."
    # check dos2unix exist
    if ! command_exist dos2unix; then
        echo "dos2unix is not installed";
        echo "Aborted";
        exit "$BAD_INSTALL_DIR";
    fi
    echo "Finished"
}

##### Script entry point of execution
### Parse command line arguments
# Check number of arguments
if [ "$#" -ne 1 ]; then
	print_usage
	exit $CMD_ARG_ERR
fi

# Check prerequisites
preinstall_check

readonly BASHRC_INSTALL_DIR_ARG=$1
echo "Installation set to $1"

# Directory must exist
if [ ! -d "$BASHRC_INSTALL_DIR_ARG" ]; then
	echo "$BASHRC_INSTALL_DIR_ARG is not a directory"
	exit $BAD_INSTALL_DIR
fi

if [ -f "$BASHRC_INSTALL_DIR_ARG"/.bashrc.bak ]; then
	yes_or_no "This will override $BASHRC_INSTALL_DIR_ARG/.bashrc.bak. Continue?(Y/N): " || exit 0
fi

# Rename bashrc file if it exists
if [ -f "$BASHRC_INSTALL_DIR_ARG"/.bashrc ]; then
	mv -v $BASHRC_INSTALL_DIR_ARG/.bashrc $BASHRC_INSTALL_DIR_ARG/.bashrc.bak
fi

# Copy over the bashrc from this project
cp -v bashrc "$BASHRC_INSTALL_DIR_ARG"/.bashrc
SRC_ABS_PATH=$(pwd)
sed -i "1i BASHRC_SRC_DIR=\"$SRC_ABS_PATH\"" $BASHRC_INSTALL_DIR_ARG/.bashrc
INSTALL_ABS_PATH=$(realpath $BASHRC_INSTALL_DIR_ARG)
sed -i "2i BASHRC_INSTALL_DIR=\"$INSTALL_ABS_PATH\"" $BASHRC_INSTALL_DIR_ARG/.bashrc
dos2unix "$BASHRC_INSTALL_DIR_ARG"/.bashrc
echo "Run \"source $BASHRC_INSTALL_DIR_ARG/.bashrc\" to use it."
