drop table if exists connections purge;

create table if not exists connections (
    id char(1),
    depends_on char(1)
);

insert into connections (id, depends_on) values
    ('A','B'),
    ('A','D'),
    ('B','C'),
    ('C','I'),
    ('C','D'),
    ('D','E'),
    ('E','F'),
    ('E','G'),
    ('F','G'),
    ('F','H'),
    ('G','I'),
    ('H','I')
);

commit;

drop table if exists simple_nodes purge;

create table if not exists simple_nodes (
    id number generated always as identity,
    node_id char(1),
    primary key (id)
);

insert /*+ append */ into simple_nodes (node_id)
select distinct id as node_id from connections
union
select distinct depends_on as node_id from connections
order by node_id;

commit;

select * from simple_nodes order by id;

drop table if exists simple_edges purge;

create table if not exists simple_edges (
    id number generated always as identity,
    from_node_id number,
    to_node_id number,
    primary key (id)
);


insert /*+ append */ into simple_edges (from_node_id, to_node_id)
select distinct
    (select n1.id from simple_nodes n1 where c.id = n1.node_id) as from_node_id,
    (select n2.id from simple_nodes n2 where c.depends_on = n2.node_id) as to_node_id
from
    connections c
order by 1,2;

commit;
