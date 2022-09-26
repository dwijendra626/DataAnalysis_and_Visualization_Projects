/* create a new_dababase shirts_db */
CREATE DATABASE SHIRTS_DB;

/* create a table 'shirts'
shirt_id	article		color	shirt_size	last_worn
1			t-shirt		white		S			10
2			t-shirt		green		S			200
3			polo shirt	black		M			10
4			tank top	blue		S			50
5			t-shirt		pink		S			0
6			polo shirt	red			M			5
7			tank top	white		S			200
8			tank top	blue		M			15

shirt_id - cannot be null, primary key
article - text
color - text
shirt_size - text
last_worn - int

*/

CREATE TABLE SHIRTS(
	SHIRT_ID INT NOT NULL AUTO_INCREMENT,
    ARTICLE VARCHAR(50),
    COLOR VARCHAR(50),
    SHIRT_SIZE VARCHAR(50),
    LAST_WORN INT,
    PRIMARY KEY(SHIRT_ID)
);

/* inserting data */
INSERT INTO SHIRTS (ARTICLE, COLOR, SHIRT_SIZE, LAST_WORN)
VALUES ('t-shirt', 'white', 'S', 10),
		('t-shirt', 'green', 'S', 200),
        ('polo shirt', 'black', 'M', 10),
        ('tank top', 'blue', 'S', 50),
        ('t-shirt', 'pink', 'S', 0),
        ('polo shirt', 'red', 'M', 5),
        ('tank top', 'white', 'S', 200),
        ('tank top', 'blue', 'M', 15);

-- get all the data in a single line
SELECT * FROM SHIRTS;

/* add a new shirt
Purple polo shirt, size M, last worn 50 days ago */
INSERT INTO SHIRTS (ARTICLE, COLOR, SHIRT_SIZE, LAST_WORN)
VALUES('polo shirt', 'purple', 'M', 50);

/* select all shirts
but only print out Article and color */
SELECT ARTICLE, COLOR 
FROM SHIRTS;

/* select all medium shirts 
print out everything but shirt_id */
select ARTICLE, COLOR, SHIRT_SIZE, LAST_WORN
FROM SHIRTS
WHERE SHIRT_SIZE = 'M';

/* update all polo shirts
change their size to L */
UPDATE SHIRTS
SET SHIRT_SIZE = 'L'
WHERE ARTICLE = 'polo shirt';

/* update the shirt last worn 15 days ago
change last_worn to 0 */
UPDATE SHIRTS
SET LAST_WORN = 0
WHERE LAST_WORN = 15;

/* update all white shirts 
Change size to 'XS' and color to 'off white' */
UPDATE SHIRTS
SET SHIRT_SIZE = 'XS', COLOR = 'off white'
WHERE COLOR = 'white';

/* delete all old shirts
last worn 200 days ago */
DELETE FROM SHIRTS
WHERE LAST_WORN = 200;

/* delete all tank tops */
DELETE FROM SHIRTS
WHERE ARTICLE = 'tank top';

/* delete all shirts */
DELETE FROM SHIRTS;