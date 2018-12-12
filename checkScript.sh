#!/bin/bash
FILE=""
FILENAME=""
EXTENSION=".txt" # *nix doesn't care about extensions. We must specify it.
DESTINATION_FOLDER="Installation_Folder" #Folder to install
CURRENT_DIR="$PWD" #Get the current directory of the bash
echo "$CURRENT_DIR"
CURRENT_DATE="`date "+%Y-%m-%d %H:%M:%S"`"
DATE_OF_DAY="`date "+%Y-%m-%d"`"
echo $DATE_OF_DAY
DIR="$CURRENT_DIR/Drop_Folder"
# init
# look for empty dir

echo "Creating backup directory."
if $(mkdir $CURRENT_DIR/BackUp_Directory) ; then
echo "Creation of backup directory correctly."
else
echo "Creation of backup directory failed. Already created or problem with BASH."
fi

echo "Creating backUp folder of the day."
DIRECTORY_OF_DAY="$CURRENT_DIR/BackUp_Directory/$DATE_OF_DAY"
echo $DIRECTORY_OF_DAY
if $(mkdir $DIRECTORY_OF_DAY) ; then
echo "Folder of the day created."
else
echo "Folder of the day failed. Already created or problem with BASH."
fi

if [ "$(ls -A $DIR)" ]; then
echo "Take action $DIR is not Empty."
echo "Current date is: $CURRENT_DATE"
echo "Files in the folder:"
echo $(ls -A $DIR)
FILENAME="$(ls -A $DIR)"
FILE="$DIR/$FILENAME"
echo $FILE

echo "Copying file $FILE  to $CURRENT_DIR/$DESTINATION_FOLDER"

if  $(cp $FILE $CURRENT_DIR/$DESTINATION_FOLDER) ; then
echo "File copied."

#restart service.

#Copy file to backup.
echo "Copying file $FILE to $DIRECTORY_OF_DAY"
if $(cp $FILE $DIRECTORY_OF_DAY) ; then
echo "File copied to backup."
echo "Renaming file to $CURRENT_DATE"

if $(mv $DIRECTORY_OF_DAY/$FILENAME $DIRECTORY_OF_DAY/"$CURRENT_DATE$EXTENSION") ; then
echo "Rename was correct."
else
echo "Rename failed."
fi


else
echo "File wasn't copied to backup."
fi

else
echo "File wasn't copied."
fi

else
echo "$DIR is Empty."
fi
echo "Process finished."
# rest of the logic
