
CREATE DATABASE IF NOT EXISTS emptests;

USE emptests;

---------------------------------------------------------
-- Departments table
---------------------------------------------------------
CREATE TABLE departments (deptid STRING, dname STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

-- Load from local directory
LOAD DATA LOCAL INPATH '/home/cloudera/bigdata/data/dept.csv'
OVERWRITE INTO TABLE departments;

-- Load from HDFS
-- make sure the file is on HDFS: hadoop fs -copyFromLocal dept_new.csv data/
LOAD DATA INPATH '/user/cloudera/data/dept_new.csv'
INTO TABLE departments;


---------------------------------------------------------
-- Employee Table
---------------------------------------------------------

CREATE TABLE employees (empid STRING, birthdate DATE, name STRING, gender CHAR(1), joindate DATE, dept STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

LOAD DATA LOCAL INPATH '/home/cloudera/bigdata/data/emp.csv'
OVERWRITE INTO TABLE employees;

-- truncate table employees;

---------------------------------------------------------
-- Transactions Table
---------------------------------------------------------

CREATE TABLE transactions (tid STRING, empid STRING, type STRING, amount DOUBLE)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

LOAD DATA LOCAL INPATH '/home/cloudera/bigdata/data/trans.csv'
OVERWRITE INTO TABLE transactions;

---------------------------------------------------------

-- department sizes
SELECT dept, COUNT(*) dept_size
FROM employees
GROUP BY dept;

-- department sizes (show all departments), order by dname
SELECT deptid, dname, COALESCE(dept_size, 0)
FROM departments a 
LEFT OUTER JOIN (SELECT dept, COUNT(*) dept_size
                 FROM employees
                 GROUP BY dept) b
ON a.deptid = b.dept
ORDER BY dname;


-- employee-wise transactions total
SELECT a.name, b.sum_amount
FROM employees a
INNER JOIN  (SELECT empid, SUM(amount) AS sum_amount
             FROM transactions
             GROUP BY empid ) b
ON a.empid = b.empid;


-- employee-wise transactions total
SELECT a.name, c.dname, b.sum_amount
FROM employees a
INNER JOIN  (SELECT empid, SUM(amount) AS sum_amount
             FROM transactions
             GROUP BY empid ) b
      ON a.empid = b.empid
INNER JOIN departments c
ON a.dept = c.deptid;



