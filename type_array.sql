declare
   --定义一个最多保存5个VARCHAR(25)数据类型成员的VARRAY数据类型 
    type my_array_type is
        varray ( 5 ) of varchar(25);
    v_varray my_array_type;
begin
    dbms_output.put_line('---------------- VARRAY ---------------------------------------');
    v_varray := my_array_type(
        'a','b','c','d','e'
    );
    dbms_output.put_line(
        'ENTRIES :' ||v_varray.count() ||',CAPACITY :' ||v_varray.limit()
    );

    for i in 1..v_varray.count () loop
        dbms_output.put_line(
            'V(' ||i ||')=' ||v_varray(i)
        );
    end loop;

    v_varray(5) := 'chi';
    dbms_output.put_line('v5：' ||v_varray(5) );
   

end;

