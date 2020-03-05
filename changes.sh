#!/bin/sh
#Script to replace the IP address of the replication server to sync with and to change the name of the credit union
#Craig Bell - 08/09/17

#Prompt the user for the IP address
echo ">>>Enter in the IP address of the Replication server and hit [Enter]"
#Store the IP address of the replication server that the CU is stored on
read newip

#Prompt the user for the CU name
echo ">>>Enter in the CU name (stored in the DR Hosts file [cd /{DR4_SCRIPTS_LOCATION}/]) and hit [Enter]"
#Store the IP address of the replication server that the CU is stored on
read cuname

# Read the script file
cat "get_data.sh"

echo ">>>Enter in the CU name stored in get_data and hit [Enter]"
read oldname
  
# While loop to read in the lines where the IP address is and changes the value to the new one

while read line; 
do
  oldip="$(grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' <<< $line)"
  # Write to the file the new IP address
  sed -i "s/$oldip/$newip/" get_data.sh <<< $oldip
  
  # newpath = "/home/dr4/"$cuname
  sed -i "s/$oldname/$cuname/" get_data.sh <<< $oldname
  #If the string is the same then replace it with cuname
  
done < "get_data.sh"


# Get rid of all sed files
find . -type f -name sed\* -exec rm -f {} \;


# Display the old IP address to the user
echo '~Before:	'$oldip
echo '~After:		'$newip
