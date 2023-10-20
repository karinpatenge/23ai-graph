-------------------------------------------------
-- Set up a database user in a Pluggable Database

-- Notes:
--   The scripts refer to an Oracle Database 23c FREE,
--   which has one Pluggable Database (FREEPDB1).
--
-- Author: Karin Patenge
-- Last updated: Oct 20, 2023
-------------------------------------------------

-- Connect as SYSDBA user to your Pluggable Database using SQLcl:
-- sql <username>@<hostname>:<port>/<servicename>
--
-- Before executing the statement, change the connection parameters if needed
sql sys@localhost:1521/freepdb1 as sysdba

-- Choose a password you like
create user graphuser identified by "TohoraPuru_1234#";

-- Grant privileges and set quota on tablespace users
grant connect, resource to graphuser;
alter user graphuser quota unlimited on users;
