-- Scion App server config:
update  report_init_params
set     gateway = 'http://IP_ADDRESS_FOR_APP_SERVER:PORT_NUMBER/reports/rwservlet',
        server = 'rep_wls_reports_dev-appsrv_deploy'
/

commit;

-- Change webserver
update  control_params
set     value='http://IP_ADDRESS_FOR_LINUX/webout'
where   code='WEBSERVER_PREFIX'
/

commit;


-- Stop Stored Jobs
update  stored_jobs
set     date_run=fdb_max_date
/

commit;

exit;
