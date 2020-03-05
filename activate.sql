--SQL Script to make changes for the configuration of the Disaster Recovery Test
--Craig Bell - 08/09/17

-- Open then activate the standby database
shutdown abort;
--- &1 is the parameter for the CU 
startup nomount pfile='$ORACLE_HOME/dbs/init&1..ora';
alter database mount standby database;

-- Renaming the temp Datafiles 
---Part1 Loop through the datafiles that may have stayed the same

--- Show the v$datafile table before the changes
select name from v$datafile;
----Change the names for those datafiles in v$datafile

begin
for i in
(select 'alter database rename file
    '''||name||''' to '''||replace(name,'/dr4/&1/','/devdb12c/')||''''
 as cmd
from v$datafile
where name like '/oradata/dr4/&1/scion/%')
loop
execute immediate i.cmd;
end loop;
end;
/


--Display the table to double check the names are all changed
select name from v$datafile;

---Renaming Temp Datafiles Part2
alter database rename file '/oradata/dr4/&1/temp01.dbf' to '/oradata/devdb12c/temp01.dbf';
alter database rename file '/oradata/dr4/&1/pdbseed/pdbseed_temp01.dbf' to '/oradata/devdb12c/pdbseed/pdbseed_temp01.dbf';
alter database rename file '/oradata/dr4/&1/scion/scion_temp01.dbf' to '/oradata/devdb12c/scion/scion_temp01.dbf';
-- Display the table to double check the names
select name from v$tempfile;

---Apply extra archive logs if exists
alter database open read only;
---REPEAT until database opens without error.
alter database activate standby database;

--Activate the Database
shutdown abort;
startup mount;
alter database open read write;