create or replace package body hcm_ess_jobs_util as
-- -----------------------------------------------------------------------------------
-- function
-- -----------------------------------------------------------------------------------
    function fuction_demo (
        p_vp varchar2
    ) return number as
        v_cnt number;
    begin
        select count(*) into
            v_cnt
        from hcm_ess_jobs_inventory where dev_contact_vp = p_vp;

        return v_cnt;
    end ;

-------------------------------------------------------------------------------------
-- procedure
-------------------------------------------------------------------------------------

    procedure procedure_demo (
        p_id in varchar2
    ) as
        v_tmp varchar(200);
    begin
        select checkpoint_already into
            v_tmp
        from hcm_ess_jobs_inventory where id = p_id;

        dbms_output.put_line('procedure_demo:' || v_tmp);
    end;
    

end ;