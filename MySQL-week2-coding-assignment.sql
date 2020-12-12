--
--  MySQL week 2 Coding Assignment
--  Backend Coding Bootcamp
--  Promineo Tech
--


SELECT * FROM employees LIMIT 10;
SELECT count(*) FROM employees;


-- Requirement #1
--  I want to know how many employees with each title were born after 1965-01-01.

DESC employees;

SELECT COUNT(*) AS "Number of Employees Born After January 1, 1965", t.title AS " Title " 
FROM employees e
INNER JOIN titles t ON t.emp_no = e.emp_no AND e.birth_date > '1965-01-01'
GROUP BY title;


-- DIFFERENT WAY TO SOLVE Requirement #1 --  1
-- -------------------------------------------
-- Same Query, Done with a WHERE clause
-- 
SELECT COUNT(e.emp_no) AS "Number of Employees Born After January 1, 1965", t.title AS "Title" 
FROM titles t
INNER JOIN employees e ON e.emp_no = t.emp_no
WHERE e.birth_date > '1965-01-01'
GROUP BY t.title;


-- DIFFERENT WAY TO SOLVE Requirement #1 --  2
-- -------------------------------------------
-- Same Query -- NO INNER JOIN clause
-- 
SELECT COUNT(e.emp_no) AS "Number of Employees Born After January 1, 1965", t.title AS "Title" 
FROM titles t, employees e
WHERE e.emp_no = t.emp_no AND e.birth_date > '1965-01-01'
GROUP BY t.title;



-- Requirement #2
--  I want to know the average salary per title.

DESC titles;
DESC salaries;

SELECT FORMAT(AVG(s.salary),2) AS "Average Salary", t.title AS "Title"
FROM salaries s 
INNER JOIN titles t ON t.emp_no = s.emp_no 
GROUP BY t.title ORDER BY t.title;


-- DIFFERENT WAY TO SOLVE Requirement #2 --  1
-- -------------------------------------------
-- Same Query -- NO INNER JOIN clause
-- 

SELECT FORMAT(AVG(s.salary),2) AS "Average Salary", t.title AS "Title"
FROM salaries s, titles t
WHERE t.emp_no = s.emp_no 
GROUP BY t.title ORDER BY t.title;


-- Requirement #3
--  How much money was spent on salary for the 'Marketing' department 
--            between the years 1990 and 1992?
DESC departments;
DESC dept_emp;
DESC salaries;


SELECT FORMAT(SUM(s.salary),2) AS "Money Spent On Salaries 1990-1992", d.dept_name AS "Department Name"
FROM departments d
INNER JOIN dept_emp de ON de.dept_no = d.dept_no 
INNER JOIN salaries s ON de.emp_no = s.emp_no AND (s.from_date BETWEEN '1990-01-01' AND '1992-12-31') AND (s.from_date BETWEEN de.from_date AND de.to_date)
GROUP BY d.dept_name HAVING d.dept_name = "Marketing";

--
-- Query to check results -- and use other functions -- ONLY "Marketing"
-- 
SELECT d.dept_name AS "Department",
	   FORMAT(SUM(s.salary),2) AS "Money Spent On Salaries 1990-1992",
       FORMAT(MIN(s.salary),0) AS "Min. Salary",
       FORMAT(MAX(s.salary),0) AS "Max. Salary",
       FORMAT(AVG(s.salary),2) AS "Avg. Salary",
       COUNT(s.salary) AS "# Salaries Recorded"
FROM departments d
INNER JOIN dept_emp de ON de.dept_no = d.dept_no AND de.from_date < '1993-01-01'
INNER JOIN salaries s ON de.emp_no = s.emp_no AND (s.from_date BETWEEN '1990-01-01' AND '1992-12-31') AND (s.from_date BETWEEN de.from_date AND de.to_date)
GROUP BY d.dept_name  HAVING d.dept_name = "Marketing" ORDER BY d.dept_name;


--
-- Query to check results -- and use other functions -- ALL DEPARTMENTS
-- 
SELECT d.dept_name AS "Department",
	   FORMAT(SUM(s.salary),2) AS "Money Spent On Salaries 1990-1992",
       FORMAT(MIN(s.salary),0) AS "Min. Salary",
       FORMAT(MAX(s.salary),0) AS "Max. Salary",
       FORMAT(AVG(s.salary),2) AS "Avg. Salary",
       COUNT(s.salary) AS "# Salaries Recorded"
FROM departments d
INNER JOIN dept_emp de ON de.dept_no = d.dept_no AND de.from_date < '1993-01-01'
INNER JOIN salaries s ON de.emp_no = s.emp_no AND (s.from_date BETWEEN '1990-01-01' AND '1992-12-31') AND (s.from_date BETWEEN de.from_date AND de.to_date)
GROUP BY d.dept_name ORDER BY d.dept_name;


-- DIFFERENT WAY TO SOLVE Requirement #3 --  1
-- -------------------------------------------

SELECT d.dept_name AS "Department", FORMAT(SUM(s.salary),2) AS "Money Spent On Salaries-Marketing Dept 1990-1992 (MD90-92)"
FROM departments d
INNER JOIN dept_emp de ON de.dept_no = d.dept_no AND d.dept_name = 'Marketing' AND de.from_date < '1993-01-01'
INNER JOIN salaries s ON de.emp_no = s.emp_no AND (s.from_date BETWEEN '1990-01-01' AND '1992-12-31') AND (s.from_date BETWEEN de.from_date AND de.to_date);

--
-- Query to check results -- and use other functions -- ONLY  MARKETING!
-- 
SELECT d.dept_name AS "Department", FORMAT(SUM(s.salary),2) AS "Money Spent On Salaries-Marketing Dept 1990-1992 (MD90-92)",
       FORMAT(MIN(s.salary),0) AS "Min Salary (MD90-92)",
       FORMAT(MAX(s.salary),0) AS "Max Salary (MD90-92)",
       FORMAT(AVG(s.salary),2) AS "Avg Salary (MD90-92)",
       COUNT(s.salary) AS "# Salaries Recorded (MD90-92)"
FROM departments d
INNER JOIN dept_emp de ON de.dept_no = d.dept_no AND d.dept_name = 'Marketing' AND de.from_date < '1993-01-01'
INNER JOIN salaries s ON de.emp_no = s.emp_no AND (s.from_date BETWEEN '1990-01-01' AND '1992-12-31') AND (s.from_date BETWEEN de.from_date AND de.to_date);
