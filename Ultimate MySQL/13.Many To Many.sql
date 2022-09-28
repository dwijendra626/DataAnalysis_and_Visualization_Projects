/* data preparation */
CREATE DATABASE TV_REVIEW_APP;
USE TV_REVIEW_APP;

CREATE TABLE REVIEWERS (
	ID INT AUTO_INCREMENT,
    FIRST_NAME VARCHAR(150),
    LAST_NAME VARCHAR(150),
    PRIMARY KEY(ID)
);

CREATE TABLE SERIES (
	ID INT AUTO_INCREMENT,
    TITLE VARCHAR(200),
    RELEASED_YEAR YEAR,
    GENRE VARCHAR(100),
    PRIMARY KEY(ID)
);

CREATE TABLE REVIEWS (
	ID INT AUTO_INCREMENT,
    RATING DECIMAL(2,1),
    REVIEWER_ID INT,
    SERIES_ID INT,
    PRIMARY KEY(ID),
    FOREIGN KEY(REVIEWER_ID) REFERENCES REVIEWERS(ID),
    FOREIGN KEY(SERIES_ID) REFERENCES SERIES(ID)
);

INSERT INTO REVIEWERS (FIRST_NAME, LAST_NAME) 
VALUES ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
    
INSERT INTO SERIES (TITLE, RELEASED_YEAR, GENRE) 
VALUES ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
    
INSERT INTO REVIEWS(SERIES_ID, REVIEWER_ID, RATING) 
VALUES (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),(8,4,8.5),(8,2,7.8),(8,6,8.8),
    (8,5,9.3),(9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),
    (9,5,4.5),(10,5,9.9),(13,3,8.0),(13,4,7.2),(14,2,8.5),
    (14,3,8.9),(14,4,8.9);
    
    
/* -----------------------------------*/

/*+----------------------+--------+
| title                | rating |
+----------------------+--------+
| Archer               |    8.0 |
| Archer               |    7.5 |
| Archer               |    8.5 |
| Archer               |    7.7 |
| Archer               |    8.9 |
| Arrested Development |    8.1 |
| Arrested Development |    6.0 |
| Arrested Development |    8.0 |
| Arrested Development |    8.4 |
| Arrested Development |    9.9 |
| Bob's Burgers        |    7.0 |
...
+----------------------+--------+
*/
SELECT TITLE, RATING
FROM SERIES
INNER JOIN REVIEWS
ON SERIES.ID = REVIEWS.SERIES_ID;
    
/*
+----------------------+------------+
| title                | avg_rating |
+----------------------+------------+
| General Hospital     |    5.38000 |
| Bob's Burgers        |    7.52000 |
| Seinfeld             |    7.60000 |
| Bojack Horseman      |    7.94000 |
| Arrested Development |    8.08000 |
| Curb Your Enthusiasm |    8.12000 |
| Archer               |    8.12000 |
| Freaks and Geeks     |    8.60000 |
| Stranger Things      |    8.76667 |
| Breaking Bad         |    9.36000 |
| Fargo                |    9.40000 |
| Halt and Catch Fire  |    9.90000 |
+----------------------+------------+
*/
SELECT TITLE, AVG(RATING) AS AVG_RATING
FROM SERIES
INNER JOIN REVIEWS
ON SERIES.ID = REVIEWS.SERIES_ID
GROUP BY TITLE
ORDER BY AVG_RATING;


/*
+------------+-----------+--------+
| first_name | last_name | rating |
+------------+-----------+--------+
| Thomas     | Stoneman  |    8.0 |
| Thomas     | Stoneman  |    8.1 |
| Thomas     | Stoneman  |    7.0 |
| Thomas     | Stoneman  |    7.5 |
| Thomas     | Stoneman  |    9.5 |
| Wyatt      | Skaggs    |    7.5 |
| Wyatt      | Skaggs    |    7.6 |
| Wyatt      | Skaggs    |    9.3 |
| Wyatt      | Skaggs    |    6.5 |
| Wyatt      | Skaggs    |    8.4 |
| Wyatt      | Skaggs    |    9.1 |
| Wyatt      | Skaggs    |    7.8 |
| Wyatt      | Skaggs    |    5.5 |
| Wyatt      | Skaggs    |    8.5 |
| Kimbra     | Masters   |    8.5 |
| Kimbra     | Masters   |    8.0 |
| Kimbra     | Masters   |    7.1 |
| Kimbra     | Masters   |    7.8 |
| Kimbra     | Masters   |    9.0 |
| Kimbra     | Masters   |    7.8 |
+------------+-----------+--------+
*/
SELECT FIRST_NAME, LAST_NAME, RATING
FROM REVIEWERS
INNER JOIN REVIEWS 
ON REVIEWERS.ID = REVIEWS.REVIEWER_ID;

/*
+-----------------------+
| unreviewed_series     |
+-----------------------+
| Malcolm In The Middle |
| Pushing Daisies       |
+-----------------------+
*/
SELECT TITLE AS UNREVIEWED_SERIES FROM SERIES 
LEFT JOIN REVIEWS 
ON SERIES.ID = REVIEWS.SERIES_ID
WHERE RATING IS NULL;


/*
+-----------+------------+
| genre     | avg_rating |
+-----------+------------+
| Animation |    7.86000 |
| Comedy    |    8.16250 |
| Drama     |    8.04375 |
+-----------+------------+
*/
SELECT GENRE, AVG(RATING) AS AVG_RATING
FROM SERIES
INNER JOIN REVIEWS
ON SERIES.ID = REVIEWS.SERIES_ID
GROUP BY GENRE;

/*
+------------+-----------+-------+-----+-----+---------+-------------+
| first_name | last_name | COUNT | MIN | MAX | AVG     | STATUS   	 |
+------------+-----------+-------+-----+-----+---------+-------------+
| Thomas     | Stoneman  |     5 | 7.0 | 9.5 | 8.02000 | ACTIVE   	 |
| Wyatt      | Skaggs    |     9 | 5.5 | 9.3 | 7.80000 | ACTIVE   	 |
| Kimbra     | Masters   |     9 | 6.8 | 9.0 | 7.98889 | ACTIVE   	 |
| Domingo    | Cortes    |    10 | 5.8 | 9.1 | 7.83000 | POWER USER  |
| Colt       | Steele    |    10 | 4.5 | 9.9 | 8.77000 | POWER USER  	 |
| Pinkie     | Petit     |     4 | 4.3 | 8.8 | 7.25000 | ACTIVE      |
| Marlon     | Crafford  |     0 | 0.0 | 0.0 | 0.00000 | INACTIVE    |
+------------+-----------+-------+-----+-----+---------+----------+
*/
SELECT 
	FIRST_NAME,
    LAST_NAME,
    COUNT(RATING) AS 'COUNT',
    IFNULL(MIN(RATING),0) AS 'MIN',
    IFNULL(MAX(RATING),0) AS 'MAX',
    IFNULL(AVG(RATING),0) AS 'AVG',
    CASE
		WHEN COUNT(RATING) >= 10 THEN 'POWER USER'
		WHEN COUNT(RATING) > 0 THEN 'ACTIVE'
        ELSE 'INACTIVE'
	END AS STATUS
FROM REVIEWERS
LEFT JOIN REVIEWS
ON REVIEWERS.ID = REVIEWS.REVIEWER_ID
GROUP BY REVIEWERS.ID; 

/* IN THE ABOVE QUERY, IF STATUS IS HAVING ONLY 
TWO CONDITIONS I.E., ACTIVE, INACTIVE ,
WE CAN USE IF INSTEAD OF CASE STATEMENT LIKE

IF(Count(rating) > 0, 'ACTIVE', 'INACTIVE') AS STATUS 
*/


/*
+----------------------+--------+-----------------+
| title                | rating | reviewer        |
+----------------------+--------+-----------------+
| Archer               |    8.0 | Thomas Stoneman |
| Archer               |    7.7 | Domingo Cortes  |
| Archer               |    8.5 | Kimbra Masters  |
| Archer               |    7.5 | Wyatt Skaggs    |
| Archer               |    8.9 | Colt Steele     |
| Arrested Development |    8.4 | Pinkie Petit    |
| Arrested Development |    9.9 | Colt Steele     |
| Arrested Development |    8.1 | Thomas Stoneman |
| Arrested Development |    6.0 | Domingo Cortes  |
| Arrested Development |    8.0 | Kimbra Masters  |
| Bob's Burgers        |    7.0 | Thomas Stoneman |
| Bob's Burgers        |    8.0 | Domingo Cortes  |
| Bob's Burgers        |    7.1 | Kimbra Masters  |
| Bob's Burgers        |    7.5 | Pinkie Petit    |
| Bob's Burgers        |    8.0 | Colt Steele     |
+----------------------+--------+-----------------+
*/
SELECT TITLE, RATING, CONCAT(FIRST_NAME, ' ', LAST_NAME) AS REVIEWER
FROM SERIES 
INNER JOIN REVIEWS
ON SERIES.ID = REVIEWS.SERIES_ID
INNER JOIN REVIEWERS
ON REVIEWERS.ID = REVIEWS.REVIEWER_ID
ORDER BY TITLE;
