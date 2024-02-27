------------------------------------------------------------
-- Sample SQL/PGQ queries for the OPENFLIGHTS property graph
--
-- Notes:
--   The scripts refer to an Oracle Database 23c FREE,
--   which has one Pluggable Database (FREEPDB1).
--
-- Author: Karin Patenge
-- Last updated: Oct 20, 2023
------------------------------------------------------------

-- Connect to your Pluggable Database using SQLcl:
-- sql <username>@<hostname>:<port>/<servicename>
--
-- Before executing the statement, change the connection parameters if needed

sql graphuser@localhost:1521/freepdb1

-------------------------
-- Sample SQL/PGQ queries
-------------------------

select from_city, from_airport, to_city, to_airport, stops, distance_in_km, equipment, icao
from graph_table (
	openflights_graph
	match (c1 is city)<-[l1 is located_in]-(a1)-[r is route]->(a2)-[l2 is located_in]->(c2 is city)
	columns (
		c1.city as from_city
		, c2.city as to_city
		, a1.name as from_airport
		, a2.name as to_airport
		, r.distance_in_km as distance_in_km
		, r.stops as stops
		, r.equipment as equipment
		, r.airline_icao as icao)
)
fetch first 10 rows only;