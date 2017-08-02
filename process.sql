set serveroutput on;
declare
   TYPE jobids_varray IS VARRAY(12) OF VARCHAR2(10); 
   v_jobids JOBIDS_VARRAY; 
   v_howmany NUMBER; 
v_tmp  number;
begin
dbms_output.put_line('---------------------   if-else ------------------------------');
 v_tmp :=10;
 if v_tmp>1 then
    dbms_output.put_line('v_tmp:' || v_tmp);
 end if;
 
  if v_tmp>20 then
    dbms_output.put_line('v_tmp:' || v_tmp);
  else 
     dbms_output.put_line('if-else v_tmp:' || v_tmp);
 end if;
 
  if v_tmp>20 then
    dbms_output.put_line('v_tmp:' || v_tmp);
  elsif v_tmp>5 then 
     dbms_output.put_line('elsif v_tmp:' || v_tmp);
  else 
     dbms_output.put_line('v_tmp:' || v_tmp);
 end if;
 dbms_output.put_line('---------------------   loop ------------------------------');
  v_tmp :=0;
  LOOP 
     v_tmp := v_tmp + 1; 
     dbms_output.put_line('LOOP-v_tmp 的当前值为:'||v_tmp); 
  EXIT WHEN v_tmp =5; 
  END LOOP; 
  v_tmp :=0;
  WHILE v_tmp<=5 LOOP 
       DBMS_OUTPUT.PUT_LINE('WHILE-v_tmp的当前值为:'||v_tmp); 
        v_tmp:= v_tmp+1; 
  END LOOP; 
  
  FOR cnt in 1..10 LOOP 
       DBMS_OUTPUT.PUT_LINE('for-cnt 的当前值为: '||cnt); 
  END LOOP; 
  

  
end;

