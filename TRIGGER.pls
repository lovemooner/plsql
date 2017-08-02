create or replace trigger HCM_ESS_JOBS_INVENTORY_ID
before insert on FUSION.HCM_ESS_JOBS_INVENTORY
for each row 
 begin 
  if inserting then 
      if :NEW.id is null then 
         select HCM_ESS_JOBS_INVENTORY_ID_SEQ.nextval into :NEW.id from dual;
      end if; 
   end if; 
end;