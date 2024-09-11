-- Insert more data

insert into simple_nodes (node_id)
values ('J'),('K'),('LJ'),('M'),('N');

commit;

insert into simple_edges (from_node_id, to_node_id)
select distinct
    (select n1.id from simple_nodes n1 where n1.node_id = 'I') as from_node_id,
    (select n2.id from simple_nodes n2 where n2.node_id = 'J') as to_node_id
from
    dual;

insert into simple_edges (from_node_id, to_node_id)
select distinct
    (select n1.id from simple_nodes n1 where n1.node_id = 'J') as from_node_id,
    (select n2.id from simple_nodes n2 where n2.node_id = 'K') as to_node_id
from
    dual;


insert into simple_edges (from_node_id, to_node_id)
select distinct
    (select n1.id from simple_nodes n1 where n1.node_id = 'K') as from_node_id,
    (select n2.id from simple_nodes n2 where n2.node_id = 'L') as to_node_id
from
    dual;

insert into simple_edges (from_node_id, to_node_id)
select distinct
    (select n1.id from simple_nodes n1 where n1.node_id = 'L') as from_node_id,
    (select n2.id from simple_nodes n2 where n2.node_id = 'M') as to_node_id
from
    dual;


insert into simple_edges (from_node_id, to_node_id)
select distinct
    (select n1.id from simple_nodes n1 where n1.node_id = 'A') as from_node_id,
    (select n2.id from simple_nodes n2 where n2.node_id = 'M') as to_node_id
from
    dual;


insert into simple_edges (from_node_id, to_node_id)
select distinct
    (select n1.id from simple_nodes n1 where n1.node_id = 'G') as from_node_id,
    (select n2.id from simple_nodes n2 where n2.node_id = 'K') as to_node_id
from
    dual;

commit;
