declare
    v_tmp varchar2(100);
    v_str varchar2(300);
    v_cnt number;
    cursor cur is select distinct ( dev_contact_vp ) as vp from hcm_ess_jobs_inventory;

begin
    for rec_d in cur loop
        v_cnt := hcm_ess_jobs_util.get_cnt_by_vp(rec_d.vp);
        v_str := v_str
         ||  rec_d.vp
         ||  '('
         ||  v_cnt
         ||  ')<br>';
    end loop;

    dbms_output.put_line(v_str);
end;

 
--set serveroutput on 