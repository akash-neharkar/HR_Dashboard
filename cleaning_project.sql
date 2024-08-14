CREATE DATABASE projects;

SHOW DATABASES;

USE projects;

#import Data from CSV in a new table hr 

SHOW TABLES;

DESCRIBE hr;

SELECT * FROM hr;

SET sql_safe_updates = 0;

ALTER TABLE hr
CHANGE COLUMN id emp_id VARCHAR(20) NULL;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

SELECT birthdate from hr;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT hire_date FROM hr;

UPDATE hr
SET termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL 
AND termdate != ''
AND STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC') IS NOT NULL;

UPDATE hr
SET termdate = NULL
WHERE termdate = ''
OR STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC') IS NULL;

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

SELECT termdate FROM hr;

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

SELECT count(*) FROM hr WHERE age < 18;

SELECT COUNT(*) FROM hr WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM hr
WHERE termdate < '1000-01-01';

SELECT location FROM hr;