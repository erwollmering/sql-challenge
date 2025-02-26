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
FROM dept_manager;

ALTER TABLE employees
ADD CONSTRAINT fk_emp_title FOREIGN KEY (emp_title_id) REFERENCES titles(title_id);

SELECT * 
FROM employees;

--1. List the employee number, last name, first name, sex, and salary of each employee (2 points)
SELECT employees.emp_no, last_name, first_name, sex, salary
FROM employees
INNER JOIN salaries--inner join emmployees and salaries tables 
ON employees.emp_no = salaries.emp_no;

--2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT last_name, first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dept_manager.dept_no, dept_name, dept_manager.emp_no, last_name, first_name
FROM dept_manager 
INNER JOIN departments
ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees
ON  dept_manager.emp_no = employees.emp_no;

--4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT dept_emp.dept_no, dept_emp.emp_no, last_name, first_name, dept_name
FROM dept_emp
LEFT JOIN departments
ON dept_emp.dept_no = departments.dept_no
LEFT JOIN employees
ON dept_emp.emp_no = employees.emp_no
ORDER BY last_name;

--5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE '%B';

--6. List each employee in the Sales department, including their employee number, last name, and first name (2 points)
SELECT dept_no, employees.emp_no, first_name, last_name
FROM dept_emp
INNER JOIN employees
ON dept_emp.emp_no =employees.emp_no
WHERE dept_no = 'd007';

--7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name (4 points)
SELECT departments.dept_no, employees.emp_no, first_name, last_name
FROM dept_emp
INNER JOIN employees
ON dept_emp.emp_no =employees.emp_no
FULL JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_no = 'd007'
OR departments.dept_no = 'd005';

--8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) (4 points)

SELECT last_name, COUNT (last_name) AS freq_count_lastname
FROM employees
GROUP BY last_name
ORDER BY freq_count_lastname DESC;









