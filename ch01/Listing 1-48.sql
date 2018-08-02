create or replace type num_array as varray(32767) of number 
/ 
create table tc (id int, nums num_array) 
/