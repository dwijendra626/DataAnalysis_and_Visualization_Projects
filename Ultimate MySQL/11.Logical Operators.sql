/* select books that were not released in 2017 */
SELECT TITLE, RELEASED_YEAR FROM BOOKS
WHERE RELEASED_YEAR != 2017;

/* select books with titles that don't start with 'W'*/
SELECT * FROM BOOKS
WHERE TITLE NOT LIKE 'W%';

/* select books released after the year 2000 */
SELECT * FROM BOOKS
WHERE RELEASED_YEAR > 2000
ORDER BY RELEASED_YEAR;

/* select books to put on sale and give discount on 
those books having more than 100 stock */
SELECT TITLE, STOCK_QUANTITY FROM BOOKS
WHERE STOCK_QUANTITY >= 100;

/* what do you expect ?
select 99 > 1; */
-- result: 1 (as 99 is greater than 1, it returns boolean value 1 for true else 0

/* select books released before the year 2000 */
SELECT * FROM BOOKS
WHERE RELEASED_YEAR < 2000;

/* select books written by dave eggers, published after the year 2010 */
SELECT TITLE FROM BOOKS
WHERE AUTHOR_FNAME = 'DAVE'
AND AUTHOR_LNAME = 'EGGERS'
AND RELEASED_YEAR > 2010;
 
SELECT TITLE FROM BOOKS
WHERE AUTHOR_FNAME = 'DAVE'
&& AUTHOR_LNAME = 'EGGERS'
&& RELEASED_YEAR > 2010;

/* LOGICAL OR || */
SELECT TITLE FROM BOOKS
WHERE AUTHOR_FNAME = 'DAVE'
|| AUTHOR_LNAME = 'EGGERS'
|| RELEASED_YEAR > 2010;


/* BETWEEN */
-- select all books published between 2004 and 2015.(using OR operator)
SELECT TITLE, RELEASED_YEAR
FROM BOOKS
WHERE RELEASED_YEAR >= 2004
&& RELEASED_YEAR <= 2015;

-- select all books published between 2004 and 2015(using between)
SELECT TITLE, RELEASED_YEAR
FROM BOOKS
WHERE RELEASED_YEAR BETWEEN 2004 AND 2015;

/* select all books written by (carver or lahiri or smith) */
SELECT TITLE FROM BOOKS
WHERE AUTHOR_LNAME IN ('CARVER', 'LAHIRI', 'SMITH');

/* /*Select all books not published in
2000,2002,2004,2006,2008,2010,2012,2014,2016 */
SELECT * FROM BOOKS
WHERE RELEASED_YEAR NOT IN (2000,2002,2004,2006,2008,2010,2012,2014,2016);

/* books released after 2000 */
SELECT TITLE ,RELEASED_YEAR FROM BOOKS
WHERE RELEASED_YEAR >= 2000
AND RELEASED_YEAR NOT IN
(2000,2002,2004,2006,2008,2010,2012,2014,2016);

SELECT * FROM BOOKS
WHERE RELEASED_YEAR >= 2000
AND RELEASED_YEAR % 2 != 0;

/* CASE STATEMENTS */
/*
/*
+-----------------------------------------------------+---------------+------------------+
| title                                               | released_year | GENRE            |
+-----------------------------------------------------+---------------+------------------+
| The Namesake                                        |          2003 | Modern Lit       |
| Norse Mythology                                     |          2016 | Modern Lit       |
| American Gods                                       |          2001 | Modern Lit       |
| Interpreter of Maladies                             |          1996 | 20th Century Lit |
| A Hologram for the King: A Novel                    |          2012 | Modern Lit       |
+-----------------------------------------------------+--------------------------+-------+
*/

SELECT TITLE, RELEASED_YEAR,
	CASE
		WHEN RELEASED_YEAR >= 2000 THEN 'MODERN LIT'
        ELSE '20TH CENTURY LIT'
	END AS GENRE
FROM BOOKS;

/* 
	0-50 -> *
	51-100 -> **
	>100 -> ***
*/
SELECT TITLE,
	CASE
		WHEN STOCK_QUANTITY BETWEEN 0 AND 50 THEN '*'
		WHEN STOCK_QUANTITY BETWEEN 51 AND 100 THEN '**'
		ELSE '***'
	END AS STOCK
FROM BOOKS;


/* --------------------------------------------- */
SELECT 10 != 10;
-- RESULT: 0

SELECT 15 >14 && 99 - 5 <= 94;
-- RESULT: 1

SELECT 1 IN (5,3) || 9 BETWEEN 8 AND 10;
-- RESULT : 1

/* select all books written before 1980 (non inclusive) */
SELECT * FROM BOOKS
WHERE RELEASED_YEAR < 1980;

/* select all books written by Eggers or Chabon */
SELECT * FROM BOOKS
WHERE AUTHOR_LNAME IN ('EGGERS', 'CHABON');

/* select all books written by Lahiri, published after 2000 */
SELECT * FROM BOOKS 
WHERE AUTHOR_LNAME = 'LAHIRI'
AND RELEASED_YEAR > 2000; 

/* select all books with page counts between 100 and 200 */
SELECT * FROM BOOKS 
WHERE PAGES BETWEEN 100 AND 200;

/* SELECT ALL BOOKS WHERE AUTHOR_LNAME STARTS WITH A 'C' OR AN 'S'' */
SELECT * FROM BOOKS
WHERE AUTHOR_LNAME LIKE 'C%' OR AUTHOR_LNAME LIKE 'S%';

-- OR

/* SELECT ALL BOOKS WHERE AUTHOR_LNAME STARTS WITH A 'C' OR AN 'S'' */
SELECT * FROM BOOKS
WHERE SUBSTR(AUTHOR_LNAME,1,1) IN ('C','S');


/*
If title contains 'stories'   -> Short Stories
Just Kids and A Heartbreaking Work  -> Memoir
Everything Else -> Novel
+-----------------------------------------------------+----------------+---------------+
| title                                               | author_lname   | TYPE          |
+-----------------------------------------------------+----------------+---------------+
| The Namesake                                        | Lahiri         | Novel         |
| Norse Mythology                                     | Gaiman         | Novel         |
| American Gods                                       | Gaiman         | Novel         |
| Interpreter of Maladies                             | Lahiri         | Novel         |
| A Hologram for the King: A Novel                    | Eggers         | Novel         |
| The Circle                                          | Eggers         | Novel         |
| The Amazing Adventures of Kavalier & Clay           | Chabon         | Novel         |
| Just Kids                                           | Smith          | Memoir        |
| A Heartbreaking Work of Staggering Genius           | Eggers         | Memoir        |
| Coraline                                            | Gaiman         | Novel         |
| What We Talk About When We Talk About Love: Stories | Carver         | Short Stories |
| Where I'm Calling From: Selected Stories            | Carver         | Short Stories |
.....
+-----------------------------------------------------+----------------+---------------+
*/

SELECT TITLE, AUTHOR_LNAME,
	CASE 
		WHEN TITLE LIKE '%stories%' THEN 'short stories'
        WHEN TITLE = 'Just Kids' OR TITLE = 'A Heartbreaking Work of Staggering Genius' THEN 'Memoir'
		ELSE 'Novel'
	END AS Type
FROM books;


/*
+-----------------------------------------------------+----------------+---------+
| title                                               | author_lname   | COUNT   |
+-----------------------------------------------------+----------------+---------+
| What We Talk About When We Talk About Love: Stories | Carver         | 2 books |
| The Amazing Adventures of Kavalier & Clay           | Chabon         | 1 book  |
| White Noise                                         | DeLillo        | 1 book  |
| A Hologram for the King: A Novel                    | Eggers         | 3 books |
| Oblivion: Stories                                   | Foster Wallace | 2 books |
| Norse Mythology                                     | Gaiman         | 3 books |
| 10% Happier                                         | Harris         | 1 book  |
| fake_book                                           | Harris         | 1 book  |
| The Namesake                                        | Lahiri         | 2 books |
| Lincoln In The Bardo                                | Saunders       | 1 book  |
| Just Kids                                           | Smith          | 1 book  |
| Cannery Row                                         | Steinbeck      | 1 book  |
+-----------------------------------------------------+----------------+---------+
*/

SELECT TITLE, AUTHOR_LNAME,
    CASE 
        WHEN COUNT(*) = 1 THEN '1 book'
        ELSE CONCAT(COUNT(*), ' books')
    END AS COUNT
FROM BOOKS
GROUP BY AUTHOR_LNAME, AUTHOR_FNAME;