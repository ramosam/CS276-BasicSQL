create user student identified by abc123
default tablespace users
temporary tablespace temp;

grant connect, resource to student;

alter user student quota unlimited on users;