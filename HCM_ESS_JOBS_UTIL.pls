create or replace package hcm_ess_jobs_util as 

    function get_cnt_by_vp (
        p_vp varchar2
    ) return number;
    procedure procedure_demo(
        p_id in varchar2
    );
       procedure data_type_test(
        p_id in varchar2
    );
    
   procedure type_table_test(p_id in number);
end hcm_ess_jobs_util;