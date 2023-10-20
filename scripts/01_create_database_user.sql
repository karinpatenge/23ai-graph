-------------------------------------------------
-- Set up a database user in a Pluggable Database
--
-- Notes:
--   Change the password as you like
--
-- Author: Karin Patenge
-- Last updated: Oct 20, 2023
-------------------------------------------------

create user graphuser identified by "TohoraPuru_1234#";

-- Grant privileges and set quota on tablespace users
grant connect, resource to graphuser;
alter user graphuser quota unlimited on users;
