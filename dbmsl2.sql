use companydb;
-- 1. Departments Table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    budget DECIMAL(12,2)
);
-- 3. Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20)
);
drop table employees;
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    is_active BOOLEAN,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
-- Departments
INSERT INTO departments VALUES
(10, 'Engineering', 'Building A', 500000.00),
(20, 'Marketing', 'Building B', 200000.00),
(30, 'Human Resources', 'Building A', 150000.00),
(40, 'Finance', 'Building C', 350000.00),
(50, 'Research', 'Building D', 600000.00);

-- Employees
INSERT INTO employees VALUES
(101, 'Alice', 'Smith', 10, 75000.00, '2021-03-15', TRUE),
(102, 'Bob', 'Johnson', 20, 52000.00, '2022-06-01', TRUE),
(103, 'Charlie', 'Brown', 10, 82000.00, '2019-11-20', TRUE),
(104, 'Diana', 'Prince', 30, 48000.00, '2023-01-10', FALSE),
(105, 'Evan', 'Wright', 20, 61000.00, '2020-08-05', TRUE);

-- Orders
INSERT INTO orders VALUES
(5001, 'TechCorp LLC', '2024-01-15', 1250.50, 'Completed'),
(5002, 'Global Media', '2024-01-18', 450.00, 'Pending'),
(5003, 'Alpha Retail', '2024-01-20', 3100.00, 'Completed'),
(5004, 'Beta Systems', '2024-01-22', 150.25, 'Cancelled'),
(5005, 'Gamma Inc', '2024-01-25', 890.00, 'Shipped');
INSERT INTO employees
(emp_id, first_name, last_name, dept_id, salary, hire_date, is_active)
VALUES
(106, 'Fiona', 'Gallagher', 10, 65000.00, '2024-02-01', TRUE);
INSERT INTO departments
(dept_id, dept_name, location, budget)
VALUES
(60, 'Quality Assurance', 'Building B', 250000.00);
INSERT INTO orders
(order_id, customer_name, order_date, total_amount, status)
VALUES
(5006, 'Delta Retail', '2024-01-28', 2100.00, 'Pending');
SELECT * FROM employees;
SELECT first_name, last_name, salary
FROM employees;
SELECT *
FROM employees
WHERE dept_id = 10;
SELECT *
FROM orders
WHERE status = 'Completed';
UPDATE employees
SET salary = 55000.00
WHERE emp_id = 102;
UPDATE orders
SET status = 'Shipped'
WHERE order_id = 5002;
UPDATE departments
SET budget = budget + 20000.00
WHERE dept_id = 20;
DELETE FROM orders
WHERE order_id = 5004;
DELETE FROM employees
WHERE emp_id = 104;
SELECT *
FROM employees
WHERE salary > 60000.00;
SELECT *
FROM orders
WHERE order_date BETWEEN '2024-01-15'
AND '2024-01-20';
SELECT *
FROM departments
WHERE location IN ('Building A', 'Building B');
SELECT *
FROM employees
WHERE last_name LIKE 'S%';
SELECT *
FROM employees
ORDER BY salary DESC;
SELECT *
FROM departments
ORDER BY dept_name ASC;
SELECT COUNT(*) AS total_employees
FROM employees;
SELECT AVG(total_amount) AS average_amount
FROM orders;
INSERT INTO employees
(emp_id, first_name, last_name, dept_id, salary, hire_date, is_active)
VALUES
(107, 'George', 'Clark', 30, 50000.00, '2024-02-05', TRUE),
(108, 'Hannah', 'Abbott', 10, 71000.00, '2024-02-10', TRUE);
UPDATE employees
SET salary = salary * 1.10
WHERE dept_id = 10;
UPDATE employees
SET is_active = FALSE
WHERE hire_date < '2021-01-01';
SELECT *
FROM employees
WHERE is_active = TRUE
AND salary > 60000.00;
SELECT *
FROM orders
WHERE status = 'Cancelled'
OR total_amount > 2000.00;
SELECT *
FROM employees
WHERE dept_id NOT IN (10, 30);
SELECT *
FROM employees
WHERE LOWER(first_name) LIKE '%a%';
SELECT dept_id, SUM(salary) AS total_salary
FROM employees
GROUP BY dept_id;
SELECT dept_id, COUNT(*) AS total_employees
FROM employees
GROUP BY dept_id;
SELECT dept_id, SUM(salary) AS total_salary
FROM employees
GROUP BY dept_id
HAVING SUM(salary) > 100000.00;
SELECT
    status,
    MAX(total_amount) AS maximum_amount,
    MIN(total_amount) AS minimum_amount
FROM orders
GROUP BY status;
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
SELECT *
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM departments
    WHERE location = 'Building A'
);
DELETE o1
FROM orders o1
JOIN orders o2
ON o1.customer_name = o2.customer_name
WHERE o2.status = 'Cancelled';
SELECT *
FROM employees
WHERE last_name IS NULL;
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 3;
SELECT *
FROM employees
ORDER BY dept_id ASC, salary DESC;
DELETE FROM departments
WHERE budget < 200000.00;
UPDATE orders
SET status = 'Cancelled'
WHERE total_amount < 200.00;
UPDATE employees
SET salary = salary * 1.15
WHERE dept_id = (
    SELECT dept_id
    FROM departments
    ORDER BY budget DESC
    LIMIT 1
);
SELECT dept_id, AVG(salary) AS average_salary
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM employees
);
SELECT *
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM departments
    WHERE budget > 300000.00
);
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 2;
UPDATE employees
SET salary = CASE
    WHEN salary < 60000
        THEN salary * 1.10
    ELSE salary * 1.05
END;
DELETE e
FROM employees e
JOIN (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
) d
ON e.dept_id = d.dept_id
WHERE e.is_active = FALSE
AND e.salary < d.avg_salary;
SELECT
    d.dept_name,
    (
        SELECT COUNT(*)
        FROM employees e
        WHERE e.dept_id = d.dept_id
    ) AS total_employees
FROM departments d;
SELECT
    customer_name,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_name
HAVING COUNT(*) > 1
OR SUM(total_amount) > 1000.00;
INSERT INTO employees
(emp_id, first_name, last_name, dept_id, salary, hire_date, is_active)
SELECT
    emp_id + 500,
    first_name,
    last_name,
    50,
    salary,
    hire_date,
    is_active
FROM employees
WHERE dept_id = 10;
UPDATE orders
SET status = CASE
    WHEN total_amount > 1000
        THEN 'Completed'
    WHEN total_amount BETWEEN 500 AND 1000
        THEN 'Shipped'
    ELSE 'Pending'
END;