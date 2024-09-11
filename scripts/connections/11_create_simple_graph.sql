drop property graph if exists simple_graph;

create or replace property graph simple_graph
    vertex tables (
        simple_nodes
        key (id)
        label node
        properties (id, node_id)
    )
    edge tables (
        simple_edges
        key (id)
        source key (from_node_id) references simple_nodes (id)
        destination key (to_node_id) references simple_nodes (id)
        label connects
        properties (id, from_node_id, to_node_id)
    );