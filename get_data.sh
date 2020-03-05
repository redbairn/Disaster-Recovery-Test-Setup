# Following script retrieves relevant files from DR4 server -- MF
# Edit by CB (11-09-17)

now=$(date +"%T")
echo "Current time : $now"

/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/home/dr4/CREDIT_UNION_NAME_HERE/archives/ /home/devdb12c/archives/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/oradata/dr4/CREDIT_UNION_NAME_HERE/* /oradata/devdb12c/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/{SOURCES_LOCATION}/CREDIT_UNION_NAME_HERE/icons /udd/cu/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/{SOURCES_LOCATION}/CREDIT_UNION_NAME_HERE/include /udd/cu/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/{SOURCES_LOCATION}/CREDIT_UNION_NAME_HERE/libs /udd/cu/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/{SOURCES_LOCATION}/CREDIT_UNION_NAME_HERE/sources /udd/cu/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/{SOURCES_LOCATION}/CREDIT_UNION_NAME_HERE/sql /udd/cu/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/{SOURCES_LOCATION}/CREDIT_UNION_NAME_HERE/templates /udd/cu/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/{SOURCES_LOCATION}/CREDIT_UNION_NAME_HERE/todays_output/* /udd/cu/output/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/{SOURCES_LOCATION}/CREDIT_UNION_NAME_HERE/util /udd/cu/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/{SOURCES_LOCATION}/CREDIT_UNION_NAME_HERE/work /udd/cu/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/u01/app/oracle12/product/12.1.0/dbs/initCREDIT_UNION_NAME_HERE.ora /u01/app/oracle12/product/12.1.0/dbs/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/{SOURCES_LOCATION}/CREDIT_UNION_NAME_HERE/output_live/* /tmp/output_live/
/usr/bin/rsync -rvlt --compress --progress --rsh=ssh USERNAME@IP_ADDRESS_HERE:/{SOURCES_LOCATION}/CREDIT_UNION_NAME_HERE/sources_live12/* /tmp/sources/

echo "Current time : $now"

