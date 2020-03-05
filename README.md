# :repeat_one: DR-Test-Setup :repeat_one:
The following files were created for the setup for a Disaster Recovery Test for credit unions when I worked in a previous company:

- The <em>get_data.sh</em> was a script created by a former colleague to transfer the datafiles across from the replication server of the credit union to the Linux server that we would use for the test.
- I decided that I wanted a way to quickly edit this file rather than manually going via VI in the Linux terminal or copying across a file using sFTP.
- I created the file <em>changes.sh</em> to prompt the user for the necessary information and displayed the current credit union that was set up in the file.
- Later on I decided I wanted to automate the whole configuration process in order for the setup to be done much quicker and without mishap. I created the <em>backup_control.sh</em> and <em>activate.sql</em>.
- The <em>config_server.sql</em> was already on the Linux, however, there was one record that needed to be added in order to stop the STORED JOBS. The stored jobs ran particular programs especially the End of Day processing which would change the date on the application (which can be problematic when the credit union wants a snapshot of the system). There are other programs that run automatically like a module that updates accounts after an EFT file is processed on the server.  The UPDATE SQL statement that I added was another quick fix that would tackle this overall problem where these stored jobs would run on the test app server.
- I am quite new to shell scripting and it came to me quite easily but of course with help from Google, StackOverflow and friends! :blush:

:v: Enjoy! :v:
