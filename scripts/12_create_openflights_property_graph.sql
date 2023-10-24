--------------------------------------------------------
-- Create a Property Graph for the OPENFLIGHTS tables
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

sql graphuser@localhost:1521/freepdb1

-- Drop an existing property graph for the OPENFLIGHTS database tables
drop property graph openflights_graph;

-- Create the property graph for the OPENFLIGHTS database tables
create property graph openflights_graph
	vertex tables (
		openflights_airports as airports
			key ( id )
			label airport
			properties are all columns,
		openflights_cities as cities
			key ( id )
			label city
			properties are all columns),
	edge tables (
		openflights_routes as routes
			key (id)
			source key ( src_airport_id ) references airports (id)
			destination key ( dest_airport_id ) references airports (id)
			label route
			properties are all columns,
		openflights_airports as airports_in_cities
			source key ( id ) references airports (id)
			destination key ( city_id ) references cities (id)
			label located_in
			no properties
	);
