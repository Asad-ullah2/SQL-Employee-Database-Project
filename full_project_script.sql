
create database college;

USE college;

CREATE TABLE student(
id INT PRIMARY KEY auto_increment,  #(AUTO INCREMENT USE KIYA H ISLIYE ID INSERT NHI KRNI PARD RHI)
NAME VARCHAR(50),
AGE INT NOT NULL
);

INSERT into student VALUES("ASAD",23);
INSERT into student VALUES("NOBODY",24);
INSERT into student VALUES("AFFU",25);
INSERT into student VALUES(4,"AFFAN",26);  # YE DO ROWS BAAD ME ADD KI HAI
INSERT into student VALUES(5,"SIBGAT",27);
SELECT * FROM student;  # ASTRISK MEANS SELECT EVERTHING FROM STUDENT TABLE
DESCRIBE student;

UPDATE student
SET NAME = 'ASAD'
WHERE id = 2;  #yaha pr name na likh id likha kyunki safe mode on hai isliye primary key likh kr hi direct krenge

UPDATE student
SET NAME = 'ASAD'
WHERE id = 2 OR id  = 3; 

UPDATE student
SET NAME = 'UNDECIDED';
SELECT @@sql_safe_updates;   # SAFE MODE CHECK KRNE KA TAREEKA IF RESULT IS 1 IT MEANS SAFE MODE IS ON
SET SQL_SAFE_UPDATES = 0;    # WAY TO DISABLE SAFE MODE

DELETE FROM student  #KHALI YE LIKHENGE AGAR TO PURI TABLE DELETE HO JAEGI 
WHERE ID = 3;         # AISE B KR SKTE HO AUR JAISE NICHE LIKHA HAI AISE BHI
WHERE NAME = 'UNDECIDED' AND AGE = 24;

SELECT NAME
FROM student;

SELECT NAME, AGE       # student.NAME , student.age bhi likh skte hai
FROM student
ORDER BY NAME;    # ORDER BY SE ORDER ME PRINT KRA SKTE HO ASCE DESC ORDER BHI BS AAGE LIKH DO ASC YA DESC

SELECT NAME, AGE       
FROM student
WHERE NAME = 'AFFAN' AND AGE=24; 

SELECT NAME, AGE       
FROM student
WHERE NAME <> 'AFFAN' AND AGE=24;   # WE CAN USE CAMPARISONAL OR RELATIONAL OPERATOR ALSO LIKE <, > ,<=, AND, OR,<>(NOT EQUAL TO) ETC..

SELECT *      
FROM student
WHERE NAME IN ('ASAD','AFFAN');  #THIS MEANS IN NAME WALO KO SELECT KRO

SELECT *      
FROM student
WHERE NAME IN ('ASAD','AFFAN') AND ID<3;


# COMPANY DATABASE   

CREATE TABLE employee(
emp_id INT PRIMARY KEY,
first_name VARCHAR(40),
last_name VARCHAR(40),
birth_day DATE,
sex VARCHAR(1),
salary INT,
super_id INT,
branch_id INT
);

CREATE TABLE branch(
branch_id INT PRIMARY KEY,
branch_name VARCHAR(40),
mgr_id INT,
mgr_start_date DATE,
FOREIGN KEY(mgr_id) references employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client(
client_id INT PRIMARY KEY,
client_name VARCHAR(40),
branch_id INT,
FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- Find all employees
SELECT *
FROM employee;

-- Find all clients
SELECT *
FROM works_with;

-- Find all employees ordered by salary
SELECT *
from employee
ORDER BY salary ASC;

-- Find all employees ordered by sex then name
SELECT *
from employee
ORDER BY sex, name;

-- Find the first 5 employees in the table
SELECT *
from employee
LIMIT 5;

-- Find the first and last names of all employees
SELECT first_name, employee.last_name
FROM employee;

-- Find the forename and surnames names of all employees
SELECT first_name AS forename, employee.last_name AS surname
FROM employee;

-- Find out all the different genders
SELECT DISCINCT sex
FROM employee;

-- Find all male employees
SELECT *
FROM employee
WHERE sex = 'M';

-- Find all employees at branch 2
SELECT *
FROM employee
WHERE branch_id = 2;

-- Find all employee's id's and names who were born after 1969
SELECT emp_id, first_name, last_name
FROM employee
WHERE birth_day >= 1970-01-01;

-- Find all female employees at branch 2
SELECT *
FROM employee
WHERE branch_id = 2 AND sex = 'F';

-- Find all employees who are female & born after 1969 or who make over 80000
SELECT *
FROM employee
WHERE (birth_day >= '1970-01-01' AND sex = 'F') OR salary > 80000;

-- Find all employees born between 1970 and 1975
SELECT *
FROM employee
WHERE birth_day BETWEEN '1970-01-01' AND '1975-01-01';

-- Find all employees named Jim, Michael, Johnny or David
SELECT *
FROM employee
WHERE first_name IN ('Jim', 'Michael', 'Johnny', 'David');

SELECT emp_id 
FROM works_with 
WHERE emp_id NOT IN (SELECT emp_id FROM employee);

SELECT emp_id FROM employee;
SELECT client_id FROM client;

-- Find the number of employees
SELECT COUNT(super_id)
FROM employee;

-- Find the average of all employee's salaries
SELECT AVG(salary)
FROM employee;

-- Find the sum of all employee's salaries
SELECT SUM(salary)
FROM employee;

-- Find out how many males and females there are
SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

-- Find the total sales of each salesman
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY client_id;

SELECT @@sql_mode;
-- Find the total amount of money spent by each client
SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;

-- % = any # characters, _ = one character

-- Find any client's who are an LLC
SELECT * 
FROM client
WHERE client_name LIKE '%LLC';

-- Find any branch suppliers who are in the label business
SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '% Label%';

-- Find any employee born on the 10th day of the month
SELECT *
FROM employee
WHERE birth_day LIKE '____-10%';

-- Find any clients who are schools
SELECT *
FROM client
WHERE client_name LIKE '%Highschool%';

-- Find a list of employee and branch names
SELECT first_name 
FROM employee
UNION
SELECT branch_name 
FROM branch;

SELECT first_name  AS company_names
FROM employee
UNION
SELECT branch_name 
FROM branch
UNION
SELECT client_name
FROM client;

-- Find a list of all clients & branch suppliers' names
SELECT client_name, branch_id
FROM client
UNION
SELECT supplier_name, branch_id
FROM branch_supplier;
-- better to do like below
SELECT client_name, client.branch_id
FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

SELECT salary
FROM employee
UNION
SELECT total_sales
FROM works_with;

-- JOINS

-- Add the extra branch
INSERT INTO branch VALUES(4, "Buffalo", NULL, NULL);

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch        -- LEFT JOIN, RIGHT JOIN
ON employee.emp_id = branch.mgr_id;

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
LEFT JOIN branch        -- LEFT JOIN, RIGHT JOIN
ON employee.emp_id = branch.mgr_id;

-- nested queries
-- Find names of all employees who have sold over 50,000
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (SELECT works_with.emp_id
                          FROM works_with
                          WHERE works_with.total_sales > 30000);
                          
SELECT client. client_name
FROM client
WHERE client.branch_id = (
SELECT branch.branch_id
FROM branch 
WHERE branch.mgr_id = 102
LIMIT 1
);

-- ON DELETE
-- bs dikhane ke liye bna rha table varna already exist kr rhi hai
CREATE TABLE branch (
branch_id INT PRIMARY KEY,
branch_name VARCHAR(40),
mgr_id INT,
mgr_start_date DATE,
FOREIGN KEY(mgr_id) references  employee(emp_id) ON DELETE SET NULL
);

DELETE FROM employee   -- ON DELETE SET NULL SE AGAR DELETE KROGE TO FOREIGN KEY ME NULL CHALA JAEGA 
WHERE emp_id = 102;    -- LIKE YAHA PR 102 EMP_ID DELETE KRNE PR 102 KI MGR_ID ME NULL JAEGA

-- IF I USE ON
SELECT * FROM branch ; 

-- CREATE
--     TRIGGER `event_name` BEFORE/AFTER INSERT/UPDATE/DELETE
--     ON `database`.`table`
--     FOR EACH ROW BEGIN
-- 		-- trigger body
-- 		-- this code is applied to every
-- 		-- inserted/updated/deleted row
--     END;                      

CREATE TABLE trigger_test (
    message VARCHAR(100)
);

DELIMITER $$
CREATE
	TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES('ADDED NEW EMPLOYEE');
	END$$
DELIMITER ;

INSERT INTO employee
VALUES(109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

SELECT * FROM trigger_test;

DELIMITER $$
CREATE 
    TRIGGER my_trigger1 BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
    INSERT INTO trigger_test VALUES(NEW.first_name);
    END$$
DELIMITER ;

INSERT INTO employee
VALUES(110, 'Kevin', 'Martinez', '1978-02-19', 'M', 69000, 106, 3);

DELIMITER $$
CREATE 
     TRIGGER my_trigger2 BEFORE INSERT 
     ON employee
FOR EACH ROW BEGIN
    IF NEW.sex = 'M' THEN 
    INSERT INTO trigger_test VALUES('ADDED MALE EMPLOYEE');
    ELSEIF NEW.sex = 'F' THEN 
    INSERT INTO trigger_test VALUES('ADDED FEMALE EMPLOYEE');
    ELSE 
        INSERT INTO trigger_test VALUES('ADDED OTHER EMPLOYEE');
     END IF;
 END$$
 DELIMITER ;
 
 INSERT INTO employee
VALUES(111, 'Pam', 'Beesly', '1988-02-19', 'F', 69000, 106, 3);

 SELECT * FROM trigger_test ;
 
 DROP TRIGGER my_trigger;
 
 