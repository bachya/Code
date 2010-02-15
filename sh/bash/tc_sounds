#!/bin/bash

# Script to encrypt/decrypt a specific TrueCrypt volume via Cygwin.
# Copyright AB 2008

# VARIABLES

# mFlags
# These are flags that I need to successfully mount the TrueCrypt volume
#    /q         - Quit immediately after (Cygwin won't terminate TrueCrypt otherwise)
#    /a devices - Automatically mount all TrueCrypt devices
#    /lf        - Assign the volume to the label F:
#    /p		- Specify that we're going to use a password 
mFlags="/q /a devices /lh /p"

# dFlags
# These are flags I need to successfully dismount the TrueCrypt volume
#    /q		- Quit immediately after
#    /d		- Dismount
#    /f		- Force the dismount
dFlags="/q /d /f"

# FUNCTIONS

# executeTC
# This function executes the manipulation of the TrueCrypt drive.  
# PARAMETERS:
#	 1. $type      - Mount (m) or Dismount (d)
#	 2. $password  - Entered password
executeTC () {
    if [ $1 == "m" ]; then
        echo "Mounting..."
        /cygdrive/c/Program\ Files/TrueCrypt/TrueCrypt $mFlags $2
	RETVAL=$?
	if [ "$RETVAL" == "0" ]; then
	    echo "Mounted"
	else
	    echo "Mounting failed"
	fi
    else
        if [ $1 == "d" ]; then
            echo "Dismounting..."
            /cygdrive/c/Program\ Files/TrueCrypt/TrueCrypt $dFlags
        else
            echo "Bad arguments"
        fi
    fi  
}

# MAIN SCRIPT

case "$1" in
    # Mount the drive
    m)
        # Get password invisibly 
        stty_orig=$(stty -g)
        echo -n "Enter password: "
        stty -echo
        read mpw
        stty $stty_orig
        echo ""

        # Execute
        executeTC "m" $mpw
        ;;
    # Dismount the drive
    d)
        # Execute
        executeTC "d"
        ;;
    # Usage
    *)
        echo "Usage: tc {m|d}"
	;;
esac
