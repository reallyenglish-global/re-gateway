# Gateway

## OpenResty

## Functions

### Authentication

https://www.keycloak.org/

### Session Management

## DB
```sql
create database gateway_dev;
create table users (id serial primary key, username varchar(255), password varchar(255));
create table authorities (id serial primary key, username varchar(255), authority varchar(255));
insert into users (username, password) values ('admin', 'admin');
insert into authorities (username, authority) values ('admin', 'ROLE_ADMIN');
```

## Futher development
Keycloak + OpenResty + Redis + Postgres
