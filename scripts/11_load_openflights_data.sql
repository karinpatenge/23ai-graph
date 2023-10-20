--------------------------------------------------------
-- Create tables and load the OPENFLIGHTS data set
--
-- Notes:
--   The scripts refer to an Oracle Database 23c FREE,
--   which has one Pluggable Database (FREEPDB1).
--
-- Author: Karin Patenge
-- Last updated: Oct 20, 2023
--------------------------------------------------------

-- Connect to your Pluggable Database using SQLcl:
-- sql <username>@<hostname>:<port>/<servicename>
--
-- Before executing the statement, change the connection parameters if needed

sql sys@localhost:1521/freepdb1

-- Create the tables for the OPENFLIGHTS data set
create table if not exists openflights_airports (
    id number(7, 0)
    , name varchar2(128 byte)
    , iata varchar2(10 byte)
    , icao varchar2(10 byte)
    , latitude number(19, 13)
    , longitude number(19, 13)
    , altitude number(6, 0)
    , timezone number(4, 0)
    , dst varchar2(100 byte)
    , tzdbtime varchar2(100 byte)
    , airport_type varchar2(100 byte)
    , source varchar2(100 byte)
    , city_id number(6, 0)
) ;

create table if not exists openflights_cities (
    city varchar2(100 byte)
    , country varchar2(100 byte)
    , id number(6, 0)
) ;

create table if not exists openflights_routes (
    id number(7, 0)
    , src_airport_id number(7, 0)
    , dest_airport_id number(7, 0)
    , codeshare varchar2(26 byte)
    , stops number(3, 0)
    , equipment varchar2(128 byte)
    , distance_in_km number(6, 0)
    , distance_in_mi number(6, 0)
    , airline_icao varchar2(10)
) ;

-- Load the OPENFLIGHTS data set (with option TRUNCATE)
set load truncate on

load openflights_airports ../data/openflights/openflights_airports.csv;
load openflights_cities ../data/openflights/openflights_cities.csv;
load openflights_routes ../data/openflights/openflights_routes.csv;

-- Verify data
select * from openflights_airports fetch first 10 rows only;
select * from openflights_cities fetch first 10 rows only;
select * from openflights_routes fetch first 10 rows only;

-- Add primary keys
alter table openflights_airports add constraint openflights_airports_pk primary key (id);
alter table openflights_cities add constraint openflights_cities_pk primary key (id);
alter table openflights_routes add constraint openflights_routes_pk primary key (id);

-- Add foreign keys
alter table openflights_airports add constraint openflights_airports_city_fk foreign key (city_id) references openflights_cities(id);
alter table openflights_routes add constraint openflights_routes_src_airport_fk foreign key (src_airport_id) references openflights_airports(id);
alter table openflights_routes add constraint openflights_routes_dest_airport_fk foreign key (dest_airport_id) references openflights_airports(id);
