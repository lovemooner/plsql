set serveroutput on;
declare
 cursor cur is select distinct ( dev_contact_vp ) as vp from hcm_ess_jobs_inventory;
begin
  dbms_output.put_line('---------------- cursor ---------------------------------------');
        for rec_d in cur loop
             dbms_output.put_line('VP :'||rec_d.vp);
        end loop;
end;

