
/* Create people table  with following fields: 
 - first_name - 20 char limit
 - last_name - 20 char limit
 - age 
 
 Insert: (single row insert )
  first_name | last_name | age
	Tina 		Belcher		13			( in same order )
	Bob			Belcher		42			( in different order )
    
 Insert: (Multiple rows insert)
   first_name | last_name |  age
	Linda		Belcher		 45
    Philip 		Frond		 38
    Calvin		Fischoeder	 70
 */
 
USE ultimate_mysql_bootcamp;

CREATE TABLE people (
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	age INT
);

INSERT INTO people (first_name, last_name, age)
VALUES('Tina', 'Belcher', 13);

INSERT INTO people (last_name, first_name, age)
VALUES('Bob', 'Belcher', 42);

INSERT INTO people (first_name, last_name, age)
VALUES ('Tina', 'Belcher', 13),
	   ('Linda', 'Belcher', 45),
       ('Philip', 'Frond', 38),
       ('Calvin', 'Fischoeder', 70);
       
SELECT * 
FROM people;


/*
Define an Employees table, with the following fields:
id - number(automatically increments), mandatory, primary key
last_name - text, mandatory
first_name - text, mandatory
middle_name - text, not mandatory
age - number mandatory
current_status - text, mandatory, defaults to 'employed'
*/

CREATE TABLE employees (
	id INT AUTO_INCREMENT NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    age INT NOT NULL,
    current_status VARCHAR(100) NOT NULL DEFAULT 'EMPLOYED',
    PRIMARY KEY (id)
);

INSERT INTO employees (first_name, last_name, age)
VALUES('Dora', 'Smith', 58);

SELECT *
FROM EMPLOYEES;