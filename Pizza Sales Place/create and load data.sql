CREATE DATABASE PIZZA;
USE PIZZA;

CREATE TABLE IF NOT EXISTS pizzas (
	pizza_id VARCHAR(20),
    pizza_type_id VARCHAR(20),
    size VARCHAR(5),
    price DOUBLE,
    PRIMARY KEY (pizza_id),
    FOREIGN KEY (pizza_type_id) REFERENCES pizza_types (pizza_type_id)
);

LOAD DATA INFILE 
"F:/DataAnalysis_and_Visualization_Projects/Pizza Sales Place/datasets/pizzas.csv"
INTO TABLE pizzas 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS pizza_types (
	pizza_type_id VARCHAR(50),
    `name` VARCHAR(100),
    category VARCHAR(20),
    ingredients TEXT,
    PRIMARY KEY (pizza_type_id)
);

LOAD DATA INFILE 
"F:/DataAnalysis_and_Visualization_Projects/Pizza Sales Place/datasets/pizza_types.csv"
INTO TABLE pizza_types 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS orders (
	order_id INT,
    date DATE,
    time TIME,
    PRIMARY KEY (order_id)
);

LOAD DATA INFILE 
"F:/DataAnalysis_and_Visualization_Projects/Pizza Sales Place/datasets/orders.csv"
INTO TABLE orders 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS order_details (
	order_details_id INT,
    order_id INT,
    pizza_id VARCHAR(20),
    quantity INT,
    PRIMARY KEY (order_details_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
);

LOAD DATA INFILE 
"F:/DataAnalysis_and_Visualization_Projects/Pizza Sales Place/datasets/order_details.csv"
INTO TABLE order_details 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;