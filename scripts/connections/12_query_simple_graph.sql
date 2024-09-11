-- Which nodes are directly connected to node I?
select from_node
from graph_table (simple_graph
  match (src)-[]->(dst)
  where dst.node_id = 'I'
  columns (src.node_id as from_node))
order by from_node;

-- Which nodes are indirectly connected to node I with 1 or 2 hops?
select from_node
from graph_table (simple_graph
  match (src)-[]->{1,2}(dst)
  where dst.node_id = 'I'
  columns (src.node_id as from_node))
order by from_node;

-- Which are the paths that connect node A to node I with any path length?
select from_node
from graph_table (simple_graph
  match (src)-[e]->+(dst)
  keep any
  where
    src.node_id = 'A' and
    dst.node_id = 'I'
  columns (src.node_id as from_node))
order by from_node;

-- Which is a path between node A and node I that is exactly 3 hops long?
select from_node
from graph_table (simple_graph
  match (src)-[]->{3}(dst)
  where
    src.node_id = 'A' and
    dst.node_id = 'I'
  columns (src.node_id as from_node))
order by from_node;

-- List all paths starting from node A that are between 2 to 6 hops long.
select distinct nodes, path
from graph_table ( simple_graph
  match (src)(-[e]->(dst)){2,6}
  where src.node_id = 'A'
columns (listagg(dst.node_id, ',') as nodes,
         count(e.id) as path))
order by path asc, nodes;