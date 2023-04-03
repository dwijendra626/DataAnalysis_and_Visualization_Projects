-- create database
CREATE DATABASE FIFA_ANALYSIS_GOAL_DATA;
USE FIFA_ANALYSIS_GOAL_DATA;

-- create table
CREATE OR REPLACE TABLE MATCH_DETAILS (
    ID VARCHAR(50) NOT NULL,
    Home VARCHAR(255) NOT NULL,
    Away VARCHAR(255) NOT NULL,
    Stage VARCHAR(255) NOT NULL,
    Scorer VARCHAR(255) NOT NULL,
    ScoringTeam	VARCHAR(255) NOT NULL,
    Type VARCHAR(255) NOT NULL
);

-- display the records in the table
SELECT  *
FROM    MATCH_DETAILS;

-- delete the records from the table
TRUNCATE TABLE MATCH_DETAILS;

/* Remove Duplicated rows */
-- check which rows are duplicated
SELECT      ID, 
            COUNT(ID) AS NO_OF_IDS
FROM        MATCH_DETAILS
GROUP BY    1
HAVING      NO_OF_IDS > 1;

-- create a new table with non duplicated rows
CREATE OR REPLACE TABLE NON_DUP_DATA AS
SELECT  DISTINCT *
FROM    MATCH_DETAILS;

-- check the records in a table
SELECT  *
FROM    NON_DUP_DATA;

-- check the most no of goals each scorer did and store it in a new table 'scoring'
CREATE OR REPLACE TABLE SCORING AS 
SELECT      SCORER,
            COUNT(ID) AS GOALS
FROM        NON_DUP_DATA
GROUP BY    1
ORDER BY    2 DESC;

-- check the scoring table
SELECT  *
FROM    SCORING;