SET SERVEROUTPUT ON;
DECLARE
    TYPE record_type_ess_job IS RECORD (
        checkpoint_already   hcm_ess_jobs_inventory.checkpoint_already%type,
        checkpoint_eta       hcm_ess_jobs_inventory.checkpoint_eta%type
    );
    v_ess_record  record_type_ess_job;
    v_tmp varchar(200);
BEGIN
    dbms_output.put_line('---------------- record ---------------------------------------');
    SELECT
        checkpoint_already,
        checkpoint_eta
    INTO
        v_ess_record
    FROM
        hcm_ess_jobs_inventory
    WHERE
        id = 400;

    v_tmp := 'Checkpoint Already :'
     ||  v_ess_record.checkpoint_already
     ||  ',CHECKPOINT_ETA :'
     ||  v_ess_record.checkpoint_eta;
    dbms_output.put_line('Record:' || v_tmp);
END;