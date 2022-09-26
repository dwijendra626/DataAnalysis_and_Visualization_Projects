/* DATA PREPARATION */

CREATE TABLE CATS (
	CAT_ID INT NOT NULL AUTO_INCREMENT,
    `NAME` VARCHAR(100),
    BREED VARCHAR(100),
    AGE INT,
    PRIMARY KEY(CAT_ID)
);

DESC CATS;
INSERT INTO CATS (NAME, BREED, AGE)
VALUES	('RINGO', 'TABBY', 4),
		('CINDY', 'MAINE COON', 10),
        ('DUMBLEDORE', 'MAINE COON', 11),
        ('EGG', 'PERSIAN', 4),
        ('MISTY', 'TABBY', 13),
        ('GEORGE MICHAEL', 'RAGDOLL', 9),
        ('JACKSON', 'SPHYNX', 7);
        
-- cat_id column
SELECT CAT_ID FROM CATS;

-- name, age column
SELECT NAME, BREED
FROM CATS;

-- name, age column for Tabby breed
SELECT NAME, AGE
FROM CATS
WHERE BREED = 'TABBY';

-- cat_id, age column with cat_id same as age
SELECT CAT_ID, AGE 
FROM CATS
WHERE CAT_ID = AGE;

-- change Jackson nane to Jack
UPDATE CATS
SET NAME = 'JACK'
WHERE NAME = 'JACKSON';

-- change ringo's breed to 'British Shorthair'
UPDATE CATS
SET BREED = 'BRITISH SHORTHAIR'
WHERE NAME = 'RINGO';

-- updates both Maine Coons' ages to be 12
UPDATE CATS
SET AGE = 12
WHERE BREED = 'MAINE COON';

-- delete all 4 year old cats
DELETE FROM CATS 
WHERE AGE = 4;

-- delete cats whose age is the same as their cat_id
DELETE FROM CATS 
WHERE CAT_ID = AGE;

-- delete all cats
DELETE FROM CATS;