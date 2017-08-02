set serveroutput on;
declare
    -- ��һά����ʹ�ü�¼��
  
    type reg_table_type is
        table of varchar2(25) index by binary_integer;
    v_reg_table reg_table_type;
    --����ά����ʹ�ü�¼�� 
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
        '�������ƣ�' ||v_reg_table(1) ||'��' ||v_reg_table(2) ||'��' ||v_reg_table(3) ||'��' ||v_reg_table(4)
    );

    dbms_output.put_line('v_reg_table(5)��' ||v_reg_table(5) );
         
        ----------  ����ά����ʹ�ü�¼�� ---------
    select
        checkpoint_already,
        checkpoint_eta,
        id
    into
        v_table(1).checkpoint_already,v_table(1).checkpoint_eta,v_table(1).id
    from hcm_ess_jobs_inventory where id = 400;

    dbms_output.put_line(
        'CHECKPOINT_ALREADY:' ||v_table(1).checkpoint_already ||'  CHECKPOINT_ETA��' ||v_table(1).checkpoint_eta ||'  id��' ||v_table(1).id
    );

end;