/* create database */
CREATE DATABASE hello_world_db;

/* check database is created or not */
SHOW DATABASES;

/* DROP DATABASE */
DROP DATABASE hello_world_db;

/* TO USE THE DATABASE */
USE hello_world_db;

/* To know which database I'm currently using */
SELECT DATABASE();

/* create a cat_app database */
CREATE DATABASE cat_app;
USE cat_app;

/* create table cats*/
CREATE TABLE cats (
	`name` VARCHAR(50),
    age INT
);

/*  check if table is created */
SHOW TABLES;

/* table details */
DESC cats;

/* delete a table */
DROP TABLE cats;

SHOW TABLES;

/*
Create a pastries table
It should include 2 columns: name and quantity.  
Name is 50 characters max.
Inspect your table/columns in the CLI
Delete your table!
*/

CREATE DATABASE ultimate_mysql_bootcamp;
USE ultimate_mysql_bootcamp;

CREATE TABLE pastries (
	`name` VARCHAR(50),
    quantity INT
);

SHOW TABLES;

DESC pastries;

DROP TABLE pastries;

SHOW TABLES;