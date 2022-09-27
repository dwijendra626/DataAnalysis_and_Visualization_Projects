-- CONCAT
/* fullname */
SELECT CONCAT(AUTHOR_FNAME, ' ', AUTHOR_LNAME)
FROM BOOKS;

SELECT AUTHOR_FNAME AS FIRST, AUTHOR_LNAME AS LAST,
CONCAT(AUTHOR_FNAME, ' ', AUTHOR_LNAME) AS FULL
FROM BOOKS;

-- CONCAT_WS (concat with separator)
SELECT CONCAT_WS(' - ', TITLE, AUTHOR_FNAME, AUTHOR_LNAME) AS BOOKTITLE_AUTHORNAME
FROM BOOKS;

-- SUBSTRING
SELECT SUBSTRING('HELLO WORLD', 1,4);
 
SELECT SUBSTRING('HELLO WORLD', 7);
 
SELECT SUBSTRING('HELLO WORLD', -3);
 
/* short title from characters 1 to 10 */
SELECT SUBSTRING(TITLE,1,10) AS SHORT_TITLE FROM BOOKS;
 
/* concat with substring */
SELECT CONCAT(SUBSTRING(TITLE, 1, 10), '...') AS 'SHORT TITLE'
FROM BOOKS;

-- replace 
SELECT REPLACE('HELLO WORLD', 'HELL', '%$#@');

SELECT REPLACE('HELLO WORLD', 'L', '7');

-- replace ' ' with ' and '  
SELECT REPLACE('CHEESE BREAD COFFEE MILK', ' ', ' AND ');

-- replace all 'e' with '3'
SELECT REPLACE(TITLE, 'e' , '3') 
FROM BOOKS;

SELECT SUBSTRING(REPLACE(TITLE, 'e', '3'),1,10) AS 'WEIRD STRING'
FROM BOOKS;


-- reverse 
SELECT REVERSE('HELLO WORLD');

SELECT REVERSE(AUTHOR_FNAME) FROM BOOKS;

SELECT CONCAT(AUTHOR_FNAME, REVERSE(AUTHOR_FNAME)) 
FROM BOOKS;

-- CHAR_LENGTH 
SELECT AUTHOR_LNAME, CHAR_LENGTH(AUTHOR_LNAME) AS LENGTH 
FROM BOOKS;

SELECT 
	CONCAT(AUTHOR_LNAME,' is ', CHAR_LENGTH(AUTHOR_LNAME), ' characters long') AS STATEMENT
FROM BOOKS;


-- UPPER AND LOWER 
SELECT UPPER('HELLO WORLD');

SELECT LOWER('HELLO WORLD');

SELECT UPPER(TITLE) FROM BOOKS;


/* --------------------------------- */

/* reverse and uppercase the following sentence:
"why does my cat look at me with such hatred?" */
SELECT REVERSE(UPPER("why does my cat look at me with such hatred?"));

/* what does this print out :
SELECT
  REPLACE
  (
  CONCAT('I', ' ', 'like', ' ', 'cats'),
  ' ',
  '-'
  );
*/
/* result --> I-like-cats */ 
  
  
/* replace spaces in titles with '->' */
SELECT REPLACE(TITLE, ' ', '->') AS TITLE
FROM BOOKS;
  
/* print author lastname and author lastname in reverse */
SELECT AUTHOR_LNAME AS FORWARDS, REVERSE(AUTHOR_LNAME) AS BACKWARDS
FROM BOOKS;

/* print author full name in all caps */
SELECT UPPER(CONCAT(AUTHOR_FNAME, ' ', AUTHOR_LNAME))
FROM BOOKS; 

/* title and released_year concatenation */
SELECT CONCAT(TITLE, ' was released in ', released_year) AS BLURB
FROM BOOKS;

/* print book titles and the length of each title */
SELECT TITLE, CHAR_LENGTH(TITLE) AS 'CHARACTER COUNT'
FROM BOOKS;

/* print this 
+---------------+---------------+---------------+
|short title	|	author		|	quantity	|
+---------------+---------------+---------------+
| American G... | Gaiman,Neil 	| 12 in stock 	|
| A Heartbre... | Eggers,Dave 	| 104 in stock  |
+---------------+---------------+---------------+

*/

SELECT 
	CONCAT(SUBSTRING(TITLE, 1, 10),'...') AS 'short title',
	CONCAT(AUTHOR_LNAME, ',',AUTHOR_FNAME) AS author,
	CONCAT(STOCK_QUANTITY, ' in stock ') AS quantity
FROM BOOKS;