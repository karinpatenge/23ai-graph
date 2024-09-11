--------------------------------------------------------
-- Create tables for SCM dataset
--
-- Database version: 19c or higher
--
-- Author: Karin Patenge
-- Last updated: Sep, 2024
--------------------------------------------------------

-- Connect to your Pluggable Database using SQLcl:
-- sql <username>/<pwd>@<hostname>:<port>/<servicename>

create table scm_customer_demographics (
   id number not null enable,
   customer_demographics varchar2(100 char) not null enable,
   constraint scm_customer_demographics_pk primary key (id)
);

create table scm_inspection_results (
   id number not null enable,
   inspection_results varchar2(100 char) not null enable,
   constraint scm_inspection_results_pk primary key (id)
);

create table scm_locations (
   id number not null enable,
	location varchar2(100 char) not null enable,
   constraint scm_locations_pk primary key (id)
);

create table scm_product_types (
   id number not null enable,
	product_type varchar2(100 char) not null enable,
   constraint scm_product_types_pk primary key (id)
);

create table scm_routes (
   id number not null enable,
	routes varchar2(100 char) not null enable,
   constraint scm_routes_pk primary key (id)
);

create table scm_shipping_carriers (
   id number not null enable,
	shipping_carriers varchar2(26 char) not null enable,
   constraint scm_shipping_carriers_pk primary key (id)
);

create table scm_suppliers (
   id number not null enable,
	supplier_name varchar2(26 char) not null enable,
   constraint scm_suppliers_pk primary key (id)
);

create table scm_transportation_modes (
   id number not null enable,
	transportation_modes varchar2(100 char) not null enable,
   constraint scm_transportation_modes_pk primary key (id)
);

create table scm_data (
	id number generated always as identity,
   price number(38,16),
	availability number(38,0),
	number_of_products_sold number(38,0),
	revenue_generated number(38,13),
	stock_levels number(38,0),
	lead_times number(38,0),
	order_quantities number(38,0),
	shipping_times number(38,0),
	shipping_costs number(38,16),
	lead_time number(38,0),
	production_volumes number(38,0),
	manufacturing_lead_time number(38,0),
	manufacturing_costs number(38,16),
	defect_rates number(38,17),
	costs number(38,14),
	product_type_id number,
	customer_demographic_id number,
	shipping_carrier_id number,
	supplier_name_id number,
	location_id number,
	inspection_result_id number,
	transportation_mode_id number,
	route_id number,
	sku varchar2(20 char),
   constraint scm_data_pk primary key (id),
	foreign key (product_type_id) references scm_product_types (id) enable,
   foreign key (customer_demographic_id) references scm_customer_demographics (id) enable,
   foreign key (shipping_carrier_id) references scm_shipping_carriers (id) enable,
   foreign key (supplier_name_id) references scm_suppliers (id) enable,
   foreign key (location_id) references scm_locations (id) enable,
   foreign key (inspection_result_id) references scm_inspection_results (id) enable,
   foreign key (transportation_mode_id) references scm_transportation_modes (id) enable,
   foreign key (route_id) references scm_routes (id) enable
);


