CREATE DATABASE TRIGGER_DEMO;
USE TRIGGER_DEMO;

CREATE TABLE USERS (
	USERNAME VARCHAR(100),
    AGE INT
);

SHOW TABLES;

/* inserting some records into the users table */
INSERT INTO USERS VALUES
('BOBBY', 23);

INSERT INTO USERS VALUES
('SALLY', 16);

SELECT * FROM USERS;

-- Before trigger creation, any 'age' value can be inserted


/*trigger creation */ 
-- whenever a new record is inserted and if the age is greater than 18, it will throw error.
DELIMITER $$
CREATE TRIGGER must_be_adult
	BEFORE INSERT ON users FOR EACH ROW
	BEGIN
		IF NEW.age < 18
		THEN
			SIGNAL SQLSTATE '45000'
				SET message_text = 'must be an adult!';
		END IF;
	END;
$$
DELIMITER ;

-- another record inserted
INSERT INTO USERS VALUES 
('SUE', 14); 
-- result: Error. must be an adult! 


/* follower id cannot equal to followee id */
DELIMITER $$
CREATE TRIGGER example_cannot_follow_self
     BEFORE INSERT ON follows FOR EACH ROW
     BEGIN
          IF NEW.follower_id = NEW.followee_id
          THEN
				SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Cannot follow yourself, silly';
          END IF;
     END;
$$
DELIMITER ;


/* log the history of unfollow cases */
DELIMITER $$
CREATE TRIGGER capture_unfollow
	AFTER DELETE ON follows FOR EACH ROW
	BEGIN
		INSERT INTO unfollows
		SET follower_id = OLD.follower_id,
			followee_id = OLD.followee_id;
	END;
$$
DELIMITER ;
