SELECT * FROM parks_and_recreation.employee_demographics;
fgfddf
WHERE age > 40; 

SELECT *
FROM employee_demographics
WHERE age > 40;
-- a girl--
/* never */
SELECT *
FROM employee_demographics
WHERE first_name = 'Ann';

SELECT *
FROM employee_salary

WHERE occupation = 'Office Manager';
SELECT *
FROM employee_salary
WHERE (first_name ='Leslie' AND salary = 75000) ;   
SELECT *
FROM parks_departments
WHERE (department_id = 5 AND department_name = 'Library');
SELECT *
FROM employee_salary;
WHERE (first_name =  'Tom ' AND last_name = ' Haverford ') OR dept_id = 1;
SELECT *
FROM employee_demographics;
WHERE gender LIKE 'Fe%';
SELECT first_name,
employee_id,
age,
gender
FROM employee_demographics;

SELECT occupation, AVG(salary) AS Vgsal
FROM parks_and_recreation.employee_salary
WHERE occupation LIKE '% manager'
GROUP BY occupation
HAVING AVG(salary)>45555;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 6;

SELECT *
FROM parks_and_recreation.employee_salary;

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT *
FROM parks_and_recreation.employee_demographics AS demo
	INNER JOIN employee_salary AS saly
ON demo.employee_id = saly.employee_id;

SELECT saly.employee_id, age, occupation
FROM parks_and_recreation.employee_demographics AS demo
	INNER JOIN employee_salary AS saly
ON demo.employee_id = saly.employee_id;

SELECT saly.employee_id, age, occupation
FROM parks_and_recreation.employee_demographics AS demo
	LEFT JOIN employee_salary AS saly
ON demo.employee_id = saly.employee_id;

SELECT demo.employee_id, age, occupation
FROM parks_and_recreation.employee_demographics AS demo
	LEFT JOIN employee_salary AS saly
ON demo.employee_id = saly.employee_id;


SELECT saly.employee_id, age, occupation
FROM parks_and_recreation.employee_demographics AS demo
	RIGHT JOIN employee_salary AS saly
ON demo.employee_id = saly.employee_id;

-- self join --
-- joining two of same tables --

SELECT *
FROM parks_and_recreation.employee_demographics AS demo
	JOIN employee_demographics AS demy
ON demo.employee_id = demy.employee_id;

SELECT demy.employee_id, demo.employee_id, demy.age
FROM parks_and_recreation.employee_demographics AS demo
	JOIN employee_demographics AS demy
ON demo.employee_id = demy.employee_id
ORDER BY demy.age DESC;

-- multiple join --

SELECT *
FROM employee_demographics AS demo
INNER JOIN employee_salary AS sal
	ON demo.employee_id = sal.employee_id
INNER JOIN parks_departments AS PD
	ON sal.dept_id = PD.department_id; 

SELECT *
FROM parks_and_recreation.parks_departments;

SELECT *
FROM employee_demographics AS demo
INNER JOIN employee_salary AS sal
	ON demo.employee_id = sal.employee_id
INNER JOIN parks_departments AS PD
	ON sal.dept_id = PD.department_id
WHERE occupation LIKE '% Manager';

SELECT first_name, last_name, 'OLD MAN' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
 SELECT first_name, last_name, 'OLD WOMAN' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'HIGH PAID EMPLOYEE' AS Label
FROM employee_salary
WHERE salary > 60000 
ORDER BY first_name, last_name;

SELECT first_name, last_name, 'OLD MAN' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
 SELECT first_name, last_name, 'OLD WOMAN' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'HIGH PAID EMPLOYEE' AS Label
FROM employee_salary
WHERE salary > 60000 AND occupation LIKE '% Manager' 
ORDER BY first_name, last_name;

SELECT *
FROM parks_and_recreation.employee_salary;

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05) 
	WHEN salary > 50000 THEN salary + (salary * 0.07) 
END AS New_Salary,
CASE
	WHEN dept_id = 6 THEN salary * 0.10
END AS Bonus
FROM employee_salary;

SELECT *
FROM employee_demographics AS dem 
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;


SELECT gender, AVG(salary)
FROM employee_demographics AS dem 
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;


SELECT gender, 
	AVG(salary) OVER(PARTITION BY gender) AS gend
FROM employee_demographics AS dem 
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;

SELECT VERSION();

SELECT gender,dem.employee_id,
	AVG(salary) OVER(PARTITION BY employee_id) AS gend
FROM employee_demographics AS dem 
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id;
    
SELECT dem.first_name,dem.last_name,gender,
SUM(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
SELECT dem.first_name,dem.last_name,gender,dem.employee_id,
SUM(salary) OVER (PARTITION BY gender ORDER BY dem.employee_id) AS rolling_total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;


SELECT dem.first_name,dem.last_name,gender,dem.employee_id,
SUM(salary) OVER ( ORDER BY dem.employee_id) AS rolling_total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
-- rolling total without using partition by--

SELECT dem.first_name,dem.last_name,gender,dem.employee_id,sal.salary,
SUM(salary) OVER (PARTITION BY salary ORDER BY dem.employee_id) AS rolling_total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
-- partition by salary, so each salary will stand on its own , then similar salsries will be added together--
-- rolling total is basically done with sum and order by, partition by is not compulsory--
 
SELECT dem.first_name,dem.last_name,gender,dem.employee_id,sal.salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY dem.employee_id) AS row_number
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

SELECT dem.first_name,dem.last_name,gender,dem.employee_id,sal.salary,
RANK() OVER(PARTITION BY gender ORDER BY dem.employee_id) AS row_number
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
SELECT dem.first_name,dem.last_name,gender,dem.employee_id,sal.salary,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY dem.employee_id) AS row_number
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    
-- STRING FUNCTION--

SELECT first_name, LENGTH(first_name)
FROM employee_demographics;

SELECT first_name, UPPER (first_name) as all_caps
FROM employee_demographics;

SELECT RTRIM(first_name)
FROM employee_demographics;
-- left&right, substring, replace, locate, concatenate in book --

SELECT gender, AVG(age) , SUM(salary), SUM(age)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
GROUP BY gender;

-- CTE FOR DOING COMPLEX CALCULATIONSS --
WITH CTE_EXAMPLE AS 
(
SELECT gender, AVG(age) AS avg_age, SUM(salary), SUM(age)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_age)
FROM CTE_example;

SELECT gender, AVG(age) AS avg_age, SUM(salary), SUM(age)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;

SELECT AVG(avg_age)
FROM
(SELECT gender, AVG(age) AS avg_age, SUM(salary), SUM(age)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender) AS Table_1;
-- average of average using subqueries--

WITH CTE_EXAMPLE AS 
(
SELECT gender, employee_id, birth_date
FROM employee_demographics 
WHERE birth_date> '1985-01-01'),
CTE_EXAMPLE2 AS
(SELECT employee_id,salary
FROM employee_salary
WHERE salary >5000)
SELECT *
FROM CTE_EXAMPLE
JOIN CTE_EXAMPLE2
	ON CTE_EXAMPLE.employee_id= CTE_EXAMPLE2.employee_id;

SELECT AVG(avg_age)
FROM CTE_example;

-- DOING THE ALIASING BESIDE THE CTE, RATHER THAN THE ONE BESIDE SELECT--
WITH CTE_BUBAE(GENDER, AVG_AGE, SUM_SALARY, SUM_AGE) AS 
(
SELECT gender, AVG(age) AS avg_age, SUM(salary), SUM(age)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_BUBAE;

-- TEMPORARY TABLES --

CREATE TEMPORARY TABLE  tempo_table
(
first_name varchar(50),
last_name varchar(50),
favourite_movie varchar(100)
);
SELECT *
FROM tempo_table;

INSERT INTO tempo_table
VALUES ('EBUBE','UGWU','GOT');

SELECT *
FROM tempo_table;

SELECT *
FROM employee_salary;

create TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary>=50000;

SELECT *
FROM salary_over_50k;

create TEMPORARY TABLE salary_temptable
SELECT *
FROM employee_salary
WHERE salary>=50000
AND occupation='Office Manager';

SELECT *
FROM salary_temptable;

create TEMPORARY TABLE salaryy_demographics AS
SELECT *
FROM employee_salary
WHERE employee_id IN
(SELECT employee_id
FROM employee_demographics
WHERE age>=15);

SELECT *
FROM salaryy_demographics;

SELECT*
FROM employee_demographics;

-- stored procedures --

SELECT *
FROM employee_salary
WHERE salary>=50000;

CREATE PROCEDURE large_salaries ()
SELECT *
FROM employee_salary
WHERE salary>=50000;

CALL large_salaries ();

DELIMITER $$
CREATE PROCEDURE large_salaries2 ()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary>=50000;
	SELECT *
	FROM employee_salary
	WHERE salary>=10000;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE large_salaries7 (huggymuffin INT)
BEGIN
	SELECT salary
	FROM employee_salary
	WHERE employee_id=huggymuffin;
	END $$
DELIMITER ;

CALL large_salaries7 (1);

DELIMITER $$
CREATE PROCEDURE large_salaries10 (huggymuffin INT)
BEGIN
	SELECT salary, dept_id
	FROM employee_salary
	WHERE dept_id=huggymuffin;
	END $$
DELIMITER ;

CALL large_salaries10 (1);


DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
	FOR EACH ROW
BEGIN
	INSERT INTO employee_demographics(employee_id,first_name,last_name)
	VALUES(NEW.employee_id,NEW.first_name,NEW.last_name);
END $$
DELIMITER ;

INSERT INTO employee_salary(employee_id,first_name,last_name,occupation,salary,dept_id)
VALUES(104, 'Jean' , 'Davis' , 'banker' , 9000 , NULL);


SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
DELETE
FROM employee_demographics
WHERE age>=60;
END $$
DELIMITER ;

SELECT *
FROM employee_demographics;