CREATE DATABASE ANONYMOUS;
USE ANONYMOUS;

CREATE TABLE IF NOT EXISTS POWER_TORQUE (
	Row_Type VARCHAR(50),
    Iter_Number	VARCHAR(50),
    Power1 VARCHAR(50),
    Speed1 VARCHAR(50),
    Speed2 VARCHAR(50),
    Electricity	VARCHAR(50),
    Effort VARCHAR(50),
    Weight VARCHAR(50),
    Torque VARCHAR(50),
    Unnamed VARCHAR(50),
    Unnamed1 VARCHAR(50)
);

-- load bulk data into the table
LOAD DATA INFILE 
'F:/DataAnalysis_and_Visualization_Projects/DataCleaning/SQL/Anonymous/data_cleaning.csv'
INTO TABLE POWER_TORQUE 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM POWER_TORQUE;


/* Method 1 */

-- delete last 2 columns
ALTER TABLE POWER_TORQUE
DROP COLUMN Unnamed, 
DROP COLUMN Unnamed1;

DELETE FROM POWER_TORQUE
WHERE Row_Type IN ('first name: Person', '', 'Row Type');


ALTER TABLE POWER_TORQUE
ADD COLUMN first_name varchar(50) DEFAULT 'Person' FIRST,
ADD COLUMN last_name varchar(50) DEFAULT 'Human' AFTER first_name,
ADD COLUMN date varchar(50) DEFAULT 'end of time' AFTER last_name ;

SELECT * FROM POWER_TORQUE;

/* Method 2 */

CREATE TABLE cleaned_data AS
WITH add_columns AS (
	SELECT 	*,
			CASE 
				WHEN Row_Type IN ('first name: Person', '', 'Row Type', 'Iter', 'Average', 'Maximum', 'Std.Dev.', 'Total') THEN 'Person'
			END AS first_name,
			CASE 
				WHEN Row_Type IN ('first name: Person', '', 'Row Type', 'Iter', 'Average', 'Maximum', 'Std.Dev.', 'Total') THEN 'Human'
			END AS last_name,
			CASE 
				WHEN Row_Type IN ('first name: Person', '', 'Row Type', 'Iter', 'Average', 'Maximum', 'Std.Dev.', 'Total') THEN 'end of time'
			END AS date
	FROM	power_torque
)

SELECT 	first_name,
		last_name,
        date,
		Row_Type, 
		Iter_Number, 
		Power1, 
        Speed1, 
        Speed2, 
        Electricity, 
        Effort, 
        Weight, 
        Torque
FROM 	add_columns 
WHERE 	Row_Type NOT IN ('first name: Person', '', 'Row Type');