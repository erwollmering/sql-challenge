DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
	dept_no	varchar(10) PRIMARY KEY,
	dept_name varchar (50) NOT NULL
);

SELECT * 
FROM departments;

CREATE TABLE employees (
	emp_no int PRIMARY KEY,
	emp_title_id varchar (10),
	birth_date date, 
	first_name varchar (25) NOT NULL,
	last_name varchar (25) NOT NULL,
	sex char (1), 
	hire_date date NOT NULL
);

SELECT * 
FROM employees;

CREATE TABLE titles (
	title_id varchar (10) PRIMARY KEY,
	title varchar (30) NOT NULL 
);

SELECT * 
FROM titles;


CREATE TABLE salaries (
    emp_no INT,             
    salary INT NOT NULL,   
    PRIMARY KEY (emp_no, salary),  -- Composite primary key
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)  -- FK 
);

SELECT * 
FROM salaries;

CREATE TABLE dept_emp (
    emp_no int, 
	dept_no varchar (10),  
    PRIMARY KEY (emp_no, dept_no),  -- Composite primary key
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),  -- FK 
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)  -- FK 
);

SELECT * 
FROM dept_emp;

CREATE TABLE dept_manager (
	dept_no varchar (10),  
	emp_no int, 
    PRIMARY KEY (emp_no, dept_no),  -- Composite primary key
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),  -- FK 
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)  -- FK 
);

SELECT * 
FROM dept_emp;

ALTER TABLE employees
ADD CONSTRAINT fk_emp_title FOREIGN KEY (emp_title_id) REFERENCES titles(title_id);

SELECT * 
FROM employees;

--List the employee number, last name, first name, sex, and salary of each employee (2 points)
SELECT employees.emp_no, last_name, first_name, sex, salary
FROM employees
INNER JOIN salaries--inner join emmployees and salaries tables 
ON employees.emp_no = salaries.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT last_name, first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT employees.emp_no, dept_emp.emp_no, dept_manager.emp_no
FROM employees 
INNER JOIN emp_no
ON employees.emp_no = dept_emp.emp_no = dept_manager.emp_no;
