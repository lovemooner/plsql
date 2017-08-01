CREATE OR REPLACE PACKAGE BODY hcm_ess_jobs_util AS
-- -----------------------------------------------------------------------------------
-- function
-- -----------------------------------------------------------------------------------
    FUNCTION get_cnt_by_vp (
        p_vp   VARCHAR2
    ) RETURN NUMBER AS
        v_cnt   NUMBER;
    BEGIN
        SELECT
            COUNT(*)
        INTO
            v_cnt
        FROM
            hcm_ess_jobs_inventory
        WHERE
            dev_contact_vp = p_vp;

        RETURN v_cnt;
    END get_cnt_by_vp;

-------------------------------------------------------------------------------------
-- procedure
-------------------------------------------------------------------------------------

    PROCEDURE procedure_demo (
        p_id   IN VARCHAR2
    ) AS
        v_tmp   VARCHAR(200);
    BEGIN
        SELECT
            checkpoint_already
        INTO
            v_tmp
        FROM
            hcm_ess_jobs_inventory
        WHERE
            id = p_id;

        dbms_output.put_line('procedure_demo:' || v_tmp);
    END;
    
-------------------------------------------------------------------------------------
-- table
-------------------------------------------------------------------------------------

    PROCEDURE type_table_test( p_id   IN number) AS
    -- 按一维数组使用记录表
        TYPE reg_table_type IS
            TABLE OF VARCHAR2(25) INDEX BY BINARY_INTEGER;
        v_reg_table   reg_table_type;
  --按二维数组使用记录表 
        TYPE my_table_type IS
            TABLE OF hcm_ess_jobs_inventory%rowtype INDEX BY BINARY_INTEGER;
        v_table       my_table_type;
    BEGIN
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
        SELECT
            CHECKPOINT_ALREADY,
            CHECKPOINT_ETA,
            id
        INTO
            v_table(1).CHECKPOINT_ALREADY,v_table(1).CHECKPOINT_ETA,v_table(1).id
        FROM
            hcm_ess_jobs_inventory
        WHERE
            id = p_id;

        dbms_output.put_line(
            'CHECKPOINT_ALREADY:'
             ||  v_table(1).CHECKPOINT_ALREADY
             ||  '  CHECKPOINT_ETA：'
             ||  v_table(1).CHECKPOINT_ETA
             ||  '  id：'
             ||  v_table(1).id
        );


    END;
    
    

-------------------------------------------------------------------------------------
-- data_type_test
-------------------------------------------------------------------------------------

    PROCEDURE data_type_test (
        p_id   IN VARCHAR2
    ) AS
        v_tmp                VARCHAR(200);
        v_cnt                NUMBER;
        /********************* VARRAY *************************/
        --定义一个最多保存5个VARCHAR(25)数据类型成员的VARRAY数据类型 
        TYPE reg_varray_type IS
            VARRAY ( 5 ) OF VARCHAR(25);
        v_reg_varray         reg_varray_type; 
        /********************* record *************************/
        TYPE record_type_ess_job IS RECORD (
            checkpoint_already   hcm_ess_jobs_inventory.checkpoint_already%type,
            checkpoint_eta       hcm_ess_jobs_inventory.checkpoint_eta%type
        );
        v_ess_record         record_type_ess_job;
        /********************* cursor *************************/
        CURSOR cur IS
            SELECT DISTINCT
                ( dev_contact_vp ) AS vp
            FROM
                hcm_ess_jobs_inventory;

    BEGIN
       /********************* VARRAY *************************/
        v_reg_varray := reg_varray_type(
            '中国',
        '美国','英国','日本',
            '法国'
        );
        dbms_output.put_line(
            '地区名称：'
             ||  v_reg_varray(1)
             ||  '、'
             ||  v_reg_varray(2)
             ||  '、'
             ||  v_reg_varray(3)
             ||  '、'
             ||  v_reg_varray(4)
        );

        dbms_output.put_line('赋予初值NULL的第5个成员的值：'
         ||  v_reg_varray(5) ); 
        --用构造函数语法赋予初值后就可以这样对成员赋值 
        v_reg_varray(5) := '法国';
        dbms_output.put_line('第5个成员的值：'
         ||  v_reg_varray(5) ); 
        /********************* cursor *************************/
        v_tmp := '';
        FOR rec_d IN cur LOOP
            v_cnt := hcm_ess_jobs_util.get_cnt_by_vp(rec_d.vp);
            v_tmp := v_tmp
             ||  rec_d.vp
             ||  '('
             ||  v_cnt
             ||  ')<br>';
        END LOOP;

        dbms_output.put_line('cursor:' || v_tmp);
        
       /********************* record *************************/
        SELECT
            checkpoint_already,
            checkpoint_eta
        INTO
            v_ess_record
        FROM
            hcm_ess_jobs_inventory
        WHERE
            id = p_id;

        v_tmp := 'Checkpoint Already :'
         ||  v_ess_record.checkpoint_already
         ||  ',CHECKPOINT_ETA :'
         ||  v_ess_record.checkpoint_eta;
        dbms_output.put_line('Record:' || v_tmp);
    END;

END hcm_ess_jobs_util;