/* adding new books to the table */
INSERT INTO 
	books(title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
	   ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
	   ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
       
SELECT title FROM books;

/* Distinct */
SELECT DISTINCT AUTHOR_LNAME 
FROM BOOKS;

SELECT DISTINCT RELEASED_YEAR
FROM BOOKS;

-- distinct full names
SELECT DISTINCT(CONCAT(AUTHOR_FNAME,' ', AUTHOR_LNAME)) AS 'UNIQUE NAMES'
FROM BOOKS;


/* order by */
-- print author lastname in ascending order
SELECT AUTHOR_LNAME 
FROM BOOKS
ORDER BY AUTHOR_LNAME;

-- print title in descending order
SELECT TITLE 
FROM BOOKS
ORDER BY TITLE DESC;

SELECT TITLE, AUTHOR_FNAME, AUTHOR_LNAME
FROM BOOKS
ORDER BY 2;

/* LIMIT */
SELECT TITLE FROM BOOKS LIMIT 3;

/* print 5 most recently released books */
SELECT TITLE, RELEASED_YEAR FROM BOOKS
ORDER BY RELEASED_YEAR DESC LIMIT 5;

SELECT TITLE, RELEASED_YEAR FROM BOOKS
ORDER BY RELEASED_YEAR DESC LIMIT 5;

/* LIKE */
-- author_fname have characters 'da'
SELECT TITLE, AUTHOR_FNAME
FROM BOOKS
WHERE AUTHOR_FNAME LIKE '%da%';

-- author_fname starts with 'da'
SELECT TITLE, AUTHOR_FNAME
FROM BOOKS
WHERE AUTHOR_FNAME LIKE 'da%';

SELECT TITLE
FROM BOOKS
WHERE TITLE LIKE '%THE%';

/* four digit stock quanity */
SELECT *
FROM books
WHERE stock_quantity LIKE '____';

/* -----------------------------------------------*/

/* select all story collections
Titles that contain 'stories' */
SELECT TITLE FROM BOOKS
WHERE TITLE LIKE '%STORIES%';

/* find the longest book
print out the title and page count */
SELECT TITLE, PAGES
FROM BOOKS
ORDER BY PAGES DESC LIMIT 1;

/* print a summary containing the title 
and year, for the 3 most recent books */
SELECT CONCAT_WS(' - ', TITLE, RELEASED_YEAR) AS SUMMARY
FROM BOOKS
ORDER BY RELEASED_YEAR DESC LIMIT 3;

/* find all books with an author_lname
that contains a space(" ") */
SELECT TITLE, AUTHOR_LNAME
FROM BOOKS
WHERE AUTHOR_LNAME LIKE '% %';

/* find the 3 books with the lowest stock 
select title, year, stock */
SELECT TITLE, RELEASED_YEAR, STOCK_QUANTITY
FROM BOOKS
ORDER BY STOCK_QUANTITY LIMIT 3;

/* print title and author_lname, sorted first
by author_lname and then by title */
SELECT TITLE, AUTHOR_LNAME 
FROM BOOKS
ORDER BY 2,1;

/* sorted alphabetically by last name 
+---------------------------------------------+
| yell                                        |
+---------------------------------------------+
| MY FAVORITE AUTHOR IS RAYMOND CARVER!       |
| MY FAVORITE AUTHOR IS RAYMOND CARVER!       |
| MY FAVORITE AUTHOR IS MICHAEL CHABON!       |
| MY FAVORITE AUTHOR IS DON DELILLO!          |
| MY FAVORITE AUTHOR IS DAVE EGGERS!          |
| MY FAVORITE AUTHOR IS DAVE EGGERS!          |
| MY FAVORITE AUTHOR IS DAVE EGGERS!          |
| MY FAVORITE AUTHOR IS DAVID FOSTER WALLACE! |
| MY FAVORITE AUTHOR IS DAVID FOSTER WALLACE! |
| MY FAVORITE AUTHOR IS NEIL GAIMAN!          |
| MY FAVORITE AUTHOR IS NEIL GAIMAN!          |
| MY FAVORITE AUTHOR IS NEIL GAIMAN!          |
| MY FAVORITE AUTHOR IS FREIDA HARRIS!        |
| MY FAVORITE AUTHOR IS DAN HARRIS!           |
| MY FAVORITE AUTHOR IS JHUMPA LAHIRI!        |
| MY FAVORITE AUTHOR IS JHUMPA LAHIRI!        |
| MY FAVORITE AUTHOR IS GEORGE SAUNDERS!      |
| MY FAVORITE AUTHOR IS PATTI SMITH!          |
| MY FAVORITE AUTHOR IS JOHN STEINBECK!       |
+---------------------------------------------+
*/

SELECT CONCAT('MY FAVORITE AUTHOR IS ', UPPER(AUTHOR_FNAME), ' ', UPPER(AUTHOR_LNAME), '!') AS YELL
FROM BOOKS
ORDER BY AUTHOR_LNAME;