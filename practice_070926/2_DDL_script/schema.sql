drop table if exists order_items cascade;
drop table if exists orders cascade;
drop table if exists products cascade;
drop table if exists partners cascade;

create table if not exists partners (
	id serial primary key,
	inn varchar(12) not null unique,
	email varchar(50) not null,
	created_at timestamptz default now()
);
create table if not exists products (
	id serial primary key,
	article varchar(50) not null unique,
	product_name varchar(100) not null,
	description varchar(300),
	created_at timestamptz default now()
);
create table if not exists orders (
	id serial primary key,
	order_code varchar(50) not null,
	partner_id integer references partners(id),
	status varchar(20) default 'new' check (status in ('new', 'in progress', 'completed')),
	created_at timestamptz default now() not null
);
create table if not exists order_items (
	id serial primary key,
	order_id integer not null references orders(id) on delete cascade,
	product_id integer references products(id) on delete restrict,
	quantity integer not null check (quantity > 0),
	price decimal(10,2) not null check (price > 0),
	total decimal(10,2) generated always as (quantity * price) stored,
	created_at timestamptz default now() not null
);
