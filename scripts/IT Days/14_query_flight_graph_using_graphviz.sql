----------------------------------------
-- Query the FLIGHT_GRAPH using GraphViz
----------------------------------------


SELECT id_a, id_e, id_b FROM GRAPH_TABLE(
  flight_graph
  MATCH (a)-[e]->(b)
  COLUMNS (VERTEX_ID(a) AS id_a, EDGE_ID(e) AS id_e, VERTEX_ID(b) AS id_b)
)
FETCH FIRST 10 ROWS ONLY;


SELECT * FROM GRAPH_TABLE(
  flight_ext_graph
  MATCH (c1 IS city) <-[l1 IS located_in]- (a1)
         -[r IS route]-> (a2) -[l2 IS located_in]->
        (c2 IS city)
  WHERE
    c1.city = 'Paris' AND c1.country = 'France' AND
    c2.city = 'London' AND c2.country = 'United Kingdom'
  COLUMNS (
    VERTEX_ID(c1) AS src_city,
    EDGE_ID(l1) AS in1,
    VERTEX_ID(a1) AS src_airport,
    EDGE_ID(r) AS connection,
    VERTEX_ID(a2) AS dst_airport,
    EDGE_ID(l2) AS in2,
    VERTEX_ID(c2) AS dst_city
  )
);


---------------------------------
-- Query the FLIGHT_GRAPH in APEX
---------------------------------

SELECT cust_sqlgraph_json('
  SELECT * FROM GRAPH_TABLE(
    flight_ext_graph
    MATCH (c1 IS city) <-[l1 IS located_in]- (a1)
           -[r IS route]-> (a2) -[l2 IS located_in]->
          (c2 IS city)
    WHERE
      c1.city = 'Paris' AND c1.country = 'France' AND
      c2.city = 'London' AND c2.country = 'United Kingdom'
    COLUMNS (
      VERTEX_ID(c1) AS src_city,
      EDGE_ID(l1) AS in1,
      VERTEX_ID(a1) AS src_airport,
      EDGE_ID(r) AS connection,
      VERTEX_ID(a2) AS dst_airport,
      EDGE_ID(l2) AS in2,
      VERTEX_ID(c2) AS dst_city
    )
  )
') AS result FROM DUAL;
