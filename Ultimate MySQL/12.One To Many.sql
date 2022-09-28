/* Relationship types */
-- one to one relationship
-- one to many relationship
-- many to one relationship

/* creating customers and orders table */
CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);
CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);

/* INNER JOIN */
      
/* get the order details of 'Boy George' */
SELECT FIRST_NAME, LAST_NAME, ORDER_DATE, AMOUNT
FROM CUSTOMERS C 
JOIN ORDERS O
ON C.ID = O.CUSTOMER_ID; 

/* JOIN WITH ORDER BY */
SELECT FIRST_NAME, LAST_NAME, ORDER_DATE, AMOUNT
FROM CUSTOMERS C 
JOIN ORDERS O
ON C.ID = O.CUSTOMER_ID
ORDER BY AMOUNT;

/* max spender in the table */
SELECT FIRST_NAME, LAST_NAME, ORDER_DATE, AMOUNT,SUM(AMOUNT)
FROM CUSTOMERS 
JOIN ORDERS 
ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID
GROUP BY ORDERS.CUSTOMER_ID;


/* LEFT JOIN */
-- all records from left table and matching records from right table

/* customers by spending from high to low */
SELECT FIRST_NAME, LAST_NAME, ORDER_DATE, AMOUNT
FROM CUSTOMERS
LEFT JOIN ORDERS
ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID
ORDER BY AMOUNT DESC;

/* customers by spending from high to low (grouping customer id) */
SELECT FIRST_NAME, LAST_NAME, SUM(AMOUNT)
FROM CUSTOMERS
LEFT JOIN ORDERS
ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID
GROUP BY CUSTOMERS.ID
ORDER BY SUM(AMOUNT) DESC;

/* records to see the total amount spend.
null changes to 0 */
SELECT FIRST_NAME, LAST_NAME, IFNULL(SUM(AMOUNT),0)
FROM CUSTOMERS
LEFT JOIN ORDERS
ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID
GROUP BY CUSTOMERS.ID
ORDER BY SUM(AMOUNT) DESC;

/* records to see people who haven't spend anything 
so that we can send them discount coupons to their email */
SELECT FIRST_NAME, LAST_NAME, ORDER_DATE, AMOUNT, EMAIL
FROM CUSTOMERS
LEFT JOIN ORDERS
ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID
WHERE AMOUNT IS NULL;


/* RIGHT JOIN */
-- all records from right table and matching records from left table

SELECT * FROM CUSTOMERS
RIGHT JOIN ORDERS
ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID;


/* ----------------------------------------------- */

-- creating table and inserting data to it
CREATE TABLE STUDENTS (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    FIRST_NAME VARCHAR(100)
);

CREATE TABLE PAPERS (
    TITLE VARCHAR(100),
    GRADE INT,
    STUDENT_ID INT,
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENTS(ID) ON DELETE CASCADE
);

INSERT INTO students (first_name)
VALUES ('Caleb'), 
('Samantha'), 
('Raj'), 
('Carlos'), 
('Lisa');


INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);


/*
+------------+---------------------------------------+-------+
| first_name | title                                 | grade |
+------------+---------------------------------------+-------+
| Samantha   | De Montaigne and The Art of The Essay |    98 |
| Samantha   | Russian Lit Through The Ages          |    94 |
| Carlos     | Borges and Magical Realism            |    89 |
| Caleb      | My Second Book Report                 |    75 |
| Caleb      | My First Book Report                  |    60 |
+------------+---------------------------------------+-------+
*/
SELECT FIRST_NAME, TITLE, GRADE
FROM STUDENTS
INNER JOIN PAPERS
ON STUDENTS.ID = PAPERS.STUDENT_ID
ORDER BY GRADE DESC;

/*
+------------+---------------------------------------+-------+
| first_name | title                                 | grade |
+------------+---------------------------------------+-------+
| Caleb      | My First Book Report                  |    60 |
| Caleb      | My Second Book Report                 |    75 |
| Samantha   | Russian Lit Through The Ages          |    94 |
| Samantha   | De Montaigne and The Art of The Essay |    98 |
| Raj        | NULL                                  |  NULL |
| Carlos     | Borges and Magical Realism            |    89 |
| Lisa       | NULL                                  |  NULL |
+------------+---------------------------------------+-------+
*/
SELECT FIRST_NAME, TITLE, GRADE
FROM STUDENTS
LEFT JOIN PAPERS
ON STUDENTS.ID = PAPERS.STUDENT_ID;


/*
+------------+---------------------------------------+-------+
| first_name | title                                 | grade |
+------------+---------------------------------------+-------+
| Caleb      | My First Book Report                  | 60    |
| Caleb      | My Second Book Report                 | 75    |
| Samantha   | Russian Lit Through The Ages          | 94    |
| Samantha   | De Montaigne and The Art of The Essay | 98    |
| Raj        | MISSING                               | 0     |
| Carlos     | Borges and Magical Realism            | 89    |
| Lisa       | MISSING                               | 0     |
+------------+---------------------------------------+-------+
*/
SELECT FIRST_NAME, IFNULL(TITLE, 'MISSING'), IFNULL(GRADE,0)
FROM STUDENTS
LEFT JOIN PAPERS
ON STUDENTS.ID = PAPERS.STUDENT_ID;

/*
+------------+---------+
| first_name | average |
+------------+---------+
| Samantha   | 96.0000 |
| Carlos     | 89.0000 |
| Caleb      | 67.5000 |
| Raj        | 0       |
| Lisa       | 0       |
+------------+---------+
*/
SELECT FIRST_NAME, IFNULL(AVG(GRADE),0) AS AVERAGE
FROM STUDENTS
LEFT JOIN PAPERS
ON STUDENTS.ID = PAPERS.STUDENT_ID
GROUP BY FIRST_NAME
ORDER BY GRADE DESC;

/*
+------------+---------+----------------+
| first_name | average | passing_status |
+------------+---------+----------------+
| Samantha   | 96.0000 | PASSING        |
| Carlos     | 89.0000 | PASSING        |
| Caleb      | 67.5000 | FAILING        |
| Raj        | 0       | FAILING        |
| Lisa       | 0       | FAILING        |
+------------+---------+----------------+
*/
SELECT FIRST_NAME, IFNULL(AVG(GRADE),0) AS AVERAGE,
	CASE
		WHEN AVG(GRADE) > 75 THEN 'PASSING'
        -- WHEN AVG(GRADE) IS NULL THEN 'FAILING'
        ELSE 'FAILING'
	END AS PASSING_STATUS
FROM STUDENTS
LEFT JOIN PAPERS
ON STUDENTS.ID = PAPERS.STUDENT_ID
GROUP BY FIRST_NAME
ORDER BY AVERAGE DESC;