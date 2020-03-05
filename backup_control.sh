#!/bin/sh
#Script to make copies of ctl and init files and to make the remaining configuration changes
#for the Disaster Recovery Test
#Craig Bell - 08/09/17

#Ask user for input
echo "Enter in DR4 host name and hit [Enter]"

#Store value in SITE
read SITE
echo $SITE "is the credit union (host name)."

#Store value of the Sys Password for CU
echo "Enter in the Sys Password for the CU and hit [Enter]"
read MAIN_PASS

#Make copies of ctl and init files
cp /oradata/devdb12c/standby.ctl /oradata/devdb12c/control01.ctl
cp /oradata/devdb12c/control01.ctl /home/devdb12c/control02.ctl
cp $ORACLE_HOME/dbs/init$SITE.ora $ORACLE_HOME/dbs/init$SITE.ora_copy

#*.control_files = '/oradata/devdb12c/control01.ctl','/home/devdb12c/control02.ctl'"
#*.db_recovery_file_dest='/backup/recovery_area/'"
#*.log_archive_dest_1='LOCATION=/home/devdb12c/archives'"

# To comment lines 4 through 14 of the init file:
sed -i '4,13 s/^/#/' $ORACLE_HOME/dbs/init$SITE.ora

#Open VI to edit the init file
#vi $ORACLE_HOME/dbs/init$SITE.ora 

#Insert the following into the document
#The "1i" command tells sed to go to line 1 and insert the text there: 
#Source: https://stackoverflow.com/questions/487894/how-can-i-add-a-line-to-a-file-in-a-shell-script/488488#488488
sed -i "14i*.db_recovery_file_dest='/backup/recovery_area/'" $ORACLE_HOME/dbs/init$SITE.ora
sed -i "15i*.log_archive_dest_1='LOCATION=/home/devdb12c/archives'" $ORACLE_HOME/dbs/init$SITE.ora
sed -i "16i*.control_files = '/oradata/devdb12c/control01.ctl','/home/devdb12c/control02.ctl'" $ORACLE_HOME/dbs/init$SITE.ora

#Open the init file in less and quit
less $ORACLE_HOME/dbs/init$SITE.ora
#:q!

#Open then activate the standby database 
export TWO_TASK=
echo exit | sqlplus / as sysdba @/home/[USERNAME]/activate.sql $SITE

#Database Check
export TWO_TASK=[ORASERVICE]
echo exit | sqlplus scu/$MAIN_PASS

##Check to see if the Listener has started.
lsnrctl start;

###The config_server.sql updates some records in order for the system to be perserved
###on the date that the credit union ran the reports and sets URLs for webout and reports.
export TWO_TASK=[ORASERVICE]
echo exit | sqlplus scu/$MAIN_PASS @/home/[USERNAME]/config_server.sql $SITE

#Move sources and output to live directories 
####Need them mounted on the app server
mv /tmp/sources/* /udd/sources_live12
mv /tmp/output_live/* /udd/output_live

echo "Done!"
echo "*Go on to the App server to edit the formsweb.cfg!"
echo "*You will find a shortcut on the desktop for editing the formsweb.cfg. Open this up."
echo "The SYS password is: "$MAIN_PASS
echo "Thanks!"
