/* date
values with  a date but no time
format: 'YYYY-MM-DD' */

/* time
value with a time but no date
format: 'HH-MM-SS' */

/* datetime
values with a date and time
format: 'YYYY-MM-DD HH-MM-SS */

/* table creation and valules insertion */
CREATE TABLE people (name VARCHAR(100), birthdate DATE, birthtime TIME, birthdt DATETIME);

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Padma', '1983-11-11', '10:07:35', '1983-11-11 10:07:35');

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Larry', '1943-12-25', '04:10:42', '1943-12-25 04:10:42');

SELECT * FROM people;

/* 
curdate() - gives current date
curtime() - gives current time
now() - gives current datetime
*/

/* FORMATTING DATES (AND TIMES)
day()
dayname()
dayofweek()
dayofyear()
*/

SELECT NAME, BIRTHDATE FROM PEOPLE;

/* show the only daY of the birthdate */
SELECT NAME, DAY(BIRTHDATE) FROM PEOPLE;

/* show the dayname of the birthdate */
SELECT NAME, BIRTHDATE, DAYNAME(BIRTHDATE) FROM PEOPLE;

SELECT NAME, BIRTHDATE, DAYOFWEEK(BIRTHDATE) FROM PEOPLE;

SELECT NAME, BIRTHDATE, DAYOFYEAR(BIRTHDATE) FROM PEOPLE;

/* DATE_FORMAT() */
-- dayname from date 
SELECT DATE_FORMAT(BIRTHDT, '%W')
FROM PEOPLE;

/* 'yyyy-mm-dd' to 'mm-dd-yyyy' */
SELECT DATE_FORMAT(BIRTHDT, '%m/%d/%Y') FROM PEOPLE;

/* DATEDIFF() */
SELECT DATEDIFF(NOW(), BIRTHDATE)FROM PEOPLE;

SELECT name, birthdate, DATEDIFF(NOW(), birthdate) FROM people;

/* DATE_ADD */
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 1 MONTH) FROM people;

SELECT birthdt, DATE_ADD(birthdt, INTERVAL 2 QUARTER) FROM people;

/* +/- */
SELECT birthdt, birthdt + INTERVAL 1 MONTH FROM people;

SELECT birthdt, birthdt - INTERVAL 5 MONTH FROM people;

SELECT birthdt, birthdt + INTERVAL 15 MONTH + INTERVAL 10 HOUR FROM people;

/* TIMESTAMP */
CREATE TABLE comments (
	content VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO comments (content) values('lol what a funny article');

INSERT INTO comments (content) values('I found this offensive');

SELECT * FROM COMMENTS;


/* -------------------------------------------*/
-- what's a good use case for CHAR?
-- It can be used for text which we know in advance that it will have fixed length.
-- ex: gender (m/f)

/*
Fill In The Blanks
CREATE TABLE inventory (
    item_name ____________,
    price ________________,
    quantity _____________
);
(price is always < 1,000,000)
*/

CREATE TABLE inventory (
    item_name VARCHAR(100),
    price DECIMAL(8,2),
    quantity INT
);

/* print out the current time */
SELECT CURTIME();

/* print out the current date(but not time) */
SELECT CURDATE();

/* print out the current day of the week (THE NUMBER) */
SELECT DAYOFWEEK('2015-05-12');
SELECT DAYOFWEEK(NOW());

/* print out the current day of the week (the day name) */
SELECT DAYNAME(NOW());
SELECT DATE_FORMAT(NOW(), '%W');

/* print out the current day and time using this format: mm/dd/yyyy */
SELECT DATE_FORMAT(NOW(), '%m/%d/%Y');


/*Print out the current day and time using this format:
January 2nd at 3:15 
April 1st at 10:18
*/
SELECT DATE_FORMAT(NOW(),'%M %D at %H:%m');
SELECT DATE_FORMAT(NOW(), '%M %D at %h:%i');

/*Create a tweets table that stores:
The Tweet content
A Username
Time it was created*/
CREATE TABLE tweets(
	tweet VARCHAR(90),
	username VARCHAR(50),
	created_at TIMESTAMP DEFAULT NOW()
);