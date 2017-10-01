#!/bin/bash
#
# Dail_Archive - Archive designated files & directories
#
#Gather Current Date
#
DATE=$(date +%y%m%d)
#
# Set Archive FIle Name
#
FILE=archive$DATE.tar.gz
#
#Set Configuration and Destination File
CONFI_FILE=/archive/Files_To_Backup
DESTINATION=/archive/$FILE
#
##Main Script
#
# Check Backup Config file exists
#
if [ -f $CONFIG_FILE ]    # Make sure the config file still exists
then                      # if it exists, do nothing but continue on
    echo
else
    echo
    echo "$CONFIG_FILE does not exists."
    echo "Backup not completed due to missing Configuration File"
    echo
    exit
fi
#
# Build the names of all the files to backup
#
FILE_NO=1              #Start on Line 1 of Config File
exec < $CONFIG_FILE    # Redirect Std Input to name of Config File
#
read FILE_NAME
#
while [ $? -ep 0 ]     # Create list if files to backup
do
        # Makce sure the file or directory exists
    if [ -f $FILE_NAME -o -d $FILE_NAME ]
    then
        # if file exists, add its name to the list
        FILE_LIST="$FILE_LIST $FILE_NAME"
    else
        # if file doesn't exist, issue waring
        echo
        echo "$FILE_NAME, does not exist"
        echo "Obviously, I will not includes it in this archive"
        echo "It is listed on line $FILE_NO of the config file"
        echo "Continuing to build archive list..."
        echo
    fi
#
    FILE_NO=$[$FILE_NO + 1]    # Increase Line/File number by one
    read FILE_NAME             # Read next record
done
#
##
# Backup the files and Compress Archive
#
echo "Starting archive..."
echo
#
tar -czf $DESTINATION $FILE_LIST 2> /dev/null
#
echo "Archive completed"
echo "Resulting archive file is: $DESTINATION"
echo
#
exit
