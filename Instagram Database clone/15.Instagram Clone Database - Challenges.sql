/* Q. we want to reward our users who have been around the longest */
-- (find the 5 oldest users)
SELECT *
FROM USERS
ORDER BY CREATED_AT
LIMIT 5;

/*Q. what day of the week do most users register on.
We need to figure out when to schedule an ad campgain. */
-- (most popular registration date)
SELECT 
	DAYNAME(CREATED_AT) AS DAYS, 
	COUNT(*) AS TOTAL
FROM USERS
GROUP BY DAYS
ORDER BY TOTAL DESC;

-- or
SELECT 
	DATE_FORMAT(CREATED_AT,'%W') AS 'DAY_OF_THE_WEEK',
    COUNT(*) AS 'TOTAL_REGISTRATIONS'
FROM USERS
GROUP BY 1
ORDER BY 2 DESC;


/* Q. we want to target our inactive users with an email campaign.
Find users who have never posted a photo */
-- Identify inactive users (users with no photo)
SELECT USERNAME
FROM USERS
LEFT JOIN PHOTOS
ON USERS.ID = PHOTOS.USER_ID
WHERE PHOTOS.ID IS NULL;

/* Q. we're running a new contest to see who can get the most 
likes on a single photo. who won ??!! */
-- Identify most popular photo (and user who created it)
SELECT USERNAME, IMAGE_URL, COUNT(*) AS 'NO_OF_LIKES'
FROM USERS
JOIN PHOTOS
ON USERS.ID = PHOTOS.USER_ID
JOIN LIKES
ON LIKES.PHOTO_ID = PHOTOS.ID
GROUP BY PHOTOS.ID
ORDER BY NO_OF_LIKES DESC
LIMIT 1;

/* Q. Our Investors want to know...
How many times does the average user post? */
-- (total number of photos/total number of users)
SELECT ROUND((SELECT COUNT(*)FROM photos)/(SELECT COUNT(*) FROM users),2) AS AVG;

/* Q. A brand wants to know which hashtags to use in a post
What are the top 5 most commonly used hashtags?*/
-- (five most popular hastags)
SELECT TAG_NAME, COUNT(*) AS 'TOTAL'
FROM TAGS
JOIN PHOTO_TAGS
ON TAGS.ID = PHOTO_TAGS.TAG_ID
GROUP BY TAGS.ID
ORDER BY TOTAL DESC
LIMIT 5;

/* Q. We have a small problem with bots on our site...
Find users who have liked every single photo on the site*/
SELECT USERNAME, COUNT(*) AS NUM_LIKES
FROM USERS
INNER JOIN LIKES
ON USERS.ID = LIKES.USER_ID
GROUP BY USERS.ID
HAVING NUM_LIKES = (SELECT COUNT(*) FROM PHOTOS);
