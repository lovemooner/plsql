create or replace package body hcm_ess_jobs_util as
-- -----------------------------------------------------------------------------------
-- function
-- -----------------------------------------------------------------------------------
    function get_cnt_by_vp (
        p_vp varchar2
    ) return number as
        v_cnt number;
    begin
        select count(*) into
            v_cnt
        from hcm_ess_jobs_inventory where dev_contact_vp = p_vp;

        return v_cnt;
    end get_cnt_by_vp;

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
    
-------------------------------------------------------------------------------------
-- table
-------------------------------------------------------------------------------------

    procedure type_table_test (
        p_id in number
    ) as
    -- 按一维数组使用记录表
        type reg_table_type is
            table of varchar2(25) index by binary_integer;
        v_reg_table reg_table_type;
  --按二维数组使用记录表 
        type my_table_type is
            table of hcm_ess_jobs_inventory%rowtype index by binary_integer;
        v_table my_table_type;
    begin
        v_reg_table(1) := 'Europe';
        v_reg_table(2) := 'Americas';
        v_reg_table(3) := 'Asia';
        v_reg_table(4) := 'Middle East and Africa';
        v_reg_table(5) := 'NULL';
        dbms_output.put_line(
            '地区名称：'
             ||  v_reg_table(1)
             ||  '、'
             ||  v_reg_table(2)
             ||  '、'
             ||  v_reg_table(3)
             ||  '、'
             ||  v_reg_table(4)
        );

        dbms_output.put_line('v_reg_table(5)：'
         ||  v_reg_table(5) );
         
        ----------  按二维数组使用记录表 ---------
        select
            checkpoint_already,
            checkpoint_eta,
            id
        into
            v_table(1).checkpoint_already,v_table(1).checkpoint_eta,v_table(1).id
        from hcm_ess_jobs_inventory where id = p_id;

        dbms_output.put_line(
            'CHECKPOINT_ALREADY:'
             ||  v_table(1).checkpoint_already
             ||  '  CHECKPOINT_ETA：'
             ||  v_table(1).checkpoint_eta
             ||  '  id：'
             ||  v_table(1).id
        );

    end;
    
    

-------------------------------------------------------------------------------------
-- data_type_test
-------------------------------------------------------------------------------------

    procedure data_type_test (
        p_id in varchar2
    ) as
        v_tmp varchar(200);
        v_cnt number;
      
        /********************* record *************************/
        type record_type_ess_job is record (
            checkpoint_already hcm_ess_jobs_inventory.checkpoint_already%type,
            checkpoint_eta hcm_ess_jobs_inventory.checkpoint_eta%type
        );
        v_ess_record record_type_ess_job;
        /********************* cursor *************************/
        cursor cur is select distinct ( dev_contact_vp ) as vp from hcm_ess_jobs_inventory;

    begin
   
        dbms_output.put_line('---------------- cursor ---------------------------------------');
        for rec_d in cur loop
            v_cnt := hcm_ess_jobs_util.get_cnt_by_vp(rec_d.vp);
             dbms_output.put_line(rec_d.vp||'('||v_cnt|| ')');
        end loop;
        
        DBMS_OUTPUT.PUT_LINE('---------------- record ---------------------------------------');
        select
            checkpoint_already,
            checkpoint_eta
        into
            v_ess_record
        from hcm_ess_jobs_inventory where id = p_id;

        v_tmp := 'Checkpoint Already :'
         ||  v_ess_record.checkpoint_already
         ||  ',CHECKPOINT_ETA :'
         ||  v_ess_record.checkpoint_eta;
        dbms_output.put_line('Record:' || v_tmp);
    end;

end hcm_ess_jobs_util;