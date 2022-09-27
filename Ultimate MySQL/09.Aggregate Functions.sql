/* COUNT */
SELECT COUNT(*) FROM BOOKS;

/* how many author_fnames? */
SELECT COUNT(AUTHOR_FNAME) FROM BOOKS;

/* how many DISTINCT author_fnames? */
SELECT COUNT(DISTINCT AUTHOR_FNAME) FROM BOOKS;

/* distinct authors */
SELECT COUNT(DISTINCT AUTHOR_FNAME, AUTHOR_LNAME)
FROM BOOKS;

/* how many titles contain 'the'? */
SELECT COUNT(TITLE) 
FROM BOOKS
WHERE TITLE LIKE '%THE%';

/* count how many books each author has written */
SELECT CONCAT(AUTHOR_FNAME, ' ', AUTHOR_LNAME) AS 'AUTHOR NAME', COUNT(*) AS 'NO. OF BOOKS WRITTEN'
FROM BOOKS
GROUP BY 1
ORDER BY 2 DESC;

/*  count no of books released each year */
SELECT RELEASED_YEAR, COUNT(*) AS 'NO OF BOOKS'
FROM BOOKS
GROUP BY 1
ORDER BY 2 DESC;

SELECT CONCAT('In ', RELEASED_YEAR, ', ', COUNT(*), ' book(s) released') AS statement
FROM BOOKS
GROUP BY RELEASED_YEAR;

/* MIN and MAX */
-- find the minimum released year 
SELECT MIN(RELEASED_YEAR) FROM BOOKS;

/* find the longest book */
SELECT MAX(PAGES) FROM BOOKS;

/* find the title of the longest book */
SELECT TITLE, PAGES
FROM BOOKS 
WHERE PAGES = (SELECT MAX(PAGES) FROM BOOKS);

-- OR ---

SELECT TITLE, PAGES 
FROM BOOKS
ORDER BY PAGES DESC LIMIT 1;

/* min/max with group by */
-- find the year each author published their first book
SELECT CONCAT(AUTHOR_FNAME, ' ', AUTHOR_LNAME) AS 'AUTHOR NAME', MIN(RELEASED_YEAR)
FROM BOOKS
GROUP BY 1; 

/* find the longest page count for each author */
SELECT CONCAT(AUTHOR_FNAME, ' ', AUTHOR_LNAME) AS 'AUTHOR NAME', MAX(PAGES)
FROM BOOKS
GROUP BY 1;

/* SUM */
-- sum all pages in the entire database 
SELECT SUM(PAGES) FROM BOOKS;

/* sum all pages each author has written */
SELECT CONCAT(AUTHOR_FNAME, ' ', AUTHOR_LNAME) AS 'AUTHOR NAME', SUM(PAGES)
FROM BOOKS
GROUP BY 1;

/* AVG */
-- calculate the average released_year across all books
SELECT AVG(RELEASED_YEAR) FROM BOOKS;

/*Calculate the average stock quantity for books released in the same year*/
SELECT released_year, AVG(stock_quantity)
FROM books
GROUP BY released_year;

/*------------------------------------------------*/

/* print the number of books in the database */
SELECT COUNT(*) AS 'NO OF BOOKS' FROM BOOKS;

/* print out how many books were released in each year */
SELECT COUNT(*) AS 'NO OF BOOKS', RELEASED_YEAR
FROM BOOKS
GROUP BY 2; 

/* print out the total number of books in stock */
SELECT SUM(STOCK_QUANTITY) FROM BOOKS;

/* find the average released_year for each author */
SELECT CONCAT(AUTHOR_FNAME, ' ', AUTHOR_LNAME) AS 'AUTHOR NAME', AVG(RELEASED_YEAR)
FROM BOOKS
GROUP BY 1;

/* find the full name of the author who wrote the longest book */
SELECT CONCAT(AUTHOR_FNAME, ' ', AUTHOR_LNAME) AS 'AUTHOR NAME', PAGES
FROM BOOKS
ORDER BY PAGES DESC
LIMIT 1;

/*
+------+---------+-----------+
| year | # books | avg pages |
+------+---------+-----------+
| 1945 |       1 |  181.0000 |
| 1981 |       1 |  176.0000 |
| 1985 |       1 |  320.0000 |
| 1989 |       1 |  526.0000 |
| 1996 |       1 |  198.0000 |
| 2000 |       1 |  634.0000 |
| 2001 |       3 |  443.3333 |
| 2003 |       2 |  249.5000 |
| 2004 |       1 |  329.0000 |
| 2005 |       1 |  343.0000 |
| 2010 |       1 |  304.0000 |
| 2012 |       1 |  352.0000 |
| 2013 |       1 |  504.0000 |
| 2014 |       1 |  256.0000 |
| 2016 |       1 |  304.0000 |
| 2017 |       1 |  367.0000 |
+------+---------+-----------+
*/

SELECT RELEASED_YEAR AS `YEAR`, COUNT(*) AS '# books', AVG(PAGES) AS 'avg pages'
FROM BOOKS
GROUP BY 1
ORDER BY 1;