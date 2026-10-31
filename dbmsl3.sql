CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

CREATE TABLE IF NOT EXISTS departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50),
    budget DECIMAL(12,2)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    is_active BOOLEAN,
    CONSTRAINT fk_employees_department
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20)
) ENGINE=InnoDB;



INSERT IGNORE INTO departments (dept_id, dept_name, location, budget) VALUES
(10, 'Engineering', 'Building A', 500000.00),
(20, 'Marketing', 'Building B', 200000.00),
(30, 'Human Resources', 'Building A', 150000.00),
(40, 'Finance', 'Building C', 350000.00),
(50, 'Research', 'Building D', 600000.00);

INSERT IGNORE INTO employees
(emp_id, first_name, last_name, dept_id, salary, hire_date, is_active) VALUES
(101, 'Alice', 'Smith', 10, 75000.00, '2021-03-15', TRUE),
(102, 'Bob', 'Johnson', 20, 52000.00, '2022-06-01', TRUE),
(103, 'Charlie', 'Brown', 10, 82000.00, '2019-11-20', TRUE),
(104, 'Diana', 'Prince', 30, 48000.00, '2023-01-10', FALSE),
(105, 'Evan', 'Wright', 20, 61000.00, '2020-08-05', TRUE);

INSERT IGNORE INTO orders
(order_id, customer_name, order_date, total_amount, status) VALUES
(5001, 'TechCorp LLC', '2024-01-15', 1250.50, 'Completed'),
(5002, 'Global Media', '2024-01-18', 450.00, 'Pending'),
(5003, 'Alpha Retail', '2024-01-20', 3100.00, 'Completed'),
(5004, 'Beta Systems', '2024-01-22', 150.25, 'Cancelled'),
(5005, 'Gamma Inc', '2024-01-25', 890.00, 'Shipped');



CREATE USER IF NOT EXISTS 'john'@'localhost'
    IDENTIFIED BY 'JohnPass2026!';
CREATE USER IF NOT EXISTS 'alice'@'localhost'
    IDENTIFIED BY 'AlicePass2026!';
CREATE USER IF NOT EXISTS 'intern_user'@'localhost'
    IDENTIFIED BY 'InternPass2026!';
CREATE USER IF NOT EXISTS 'temp_user'@'localhost'
    IDENTIFIED BY 'TempPass2026!';
CREATE USER IF NOT EXISTS 'sec_user'@'localhost'
    IDENTIFIED BY 'SecPass2026!';
CREATE USER IF NOT EXISTS 'admin_user'@'%'
    IDENTIFIED BY 'AdminPass2026!';


CREATE USER IF NOT EXISTS 'auditor'@'localhost'
    IDENTIFIED BY 'AuditPass2026!';
GRANT SELECT ON company_db.* TO 'auditor'@'localhost';

CREATE USER IF NOT EXISTS 'analyst'@'localhost'
    IDENTIFIED BY 'AnalystPass2026!';
GRANT SELECT ON company_db.* TO 'analyst'@'localhost';


CREATE USER IF NOT EXISTS 'manager'@'localhost'
    IDENTIFIED BY 'MgrPass2026!';
GRANT SELECT, INSERT, UPDATE ON company_db.orders
    TO 'manager'@'localhost';

CREATE USER IF NOT EXISTS 'dev_user'@'localhost'
    IDENTIFIED BY 'DevPass2026!';
GRANT SELECT, INSERT, UPDATE ON company_db.*
    TO 'dev_user'@'localhost';

CREATE USER IF NOT EXISTS 'hr_assistant'@'localhost'
    IDENTIFIED BY 'HrPass2026!';
GRANT SELECT, UPDATE ON company_db.employees
    TO 'hr_assistant'@'localhost';

CREATE USER IF NOT EXISTS 'finance_user'@'localhost'
    IDENTIFIED BY 'FinPass2026!';
GRANT SELECT, UPDATE ON company_db.departments
    TO 'finance_user'@'localhost';


CREATE USER IF NOT EXISTS 'team_lead'@'localhost'
    IDENTIFIED BY 'LeadPass2026!';
GRANT SELECT, INSERT ON company_db.*
    TO 'team_lead'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;




GRANT SELECT ON company_db.* TO 'john'@'localhost';



GRANT SELECT, INSERT ON company_db.employees TO 'alice'@'localhost';



REVOKE INSERT ON company_db.employees FROM 'alice'@'localhost';



USE company_db;
START TRANSACTION;



START TRANSACTION;
INSERT INTO departments (dept_id, dept_name, location, budget)
VALUES (60, 'Training', 'Building E', 100000.00);
COMMIT;


ROLLBACK;



START TRANSACTION;
INSERT INTO departments (dept_id, dept_name, location, budget)
VALUES (61, 'Support', 'Building F', 75000.00);
SAVEPOINT sp_before_update;





GRANT ALL PRIVILEGES ON *.* TO 'admin_user'@'%' WITH GRANT OPTION;


.
FLUSH PRIVILEGES;



REVOKE ALL PRIVILEGES, GRANT OPTION
ON company_db.* FROM 'intern_user'@'localhost';





SHOW GRANTS FOR 'dev_user'@'localhost';
GRANT DELETE ON company_db.orders TO 'dev_user'@'localhost';



USE company_db;
START TRANSACTION;
UPDATE employees SET salary = 80000.00 WHERE emp_id = 101;
SAVEPOINT sp_first;
UPDATE employees SET salary = 95000.00 WHERE emp_id = 102;
ROLLBACK TO SAVEPOINT sp_first;
COMMIT;



REVOKE UPDATE ON company_db.employees FROM 'hr_assistant'@'localhost';



SET TRANSACTION READ ONLY;
START TRANSACTION;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM orders;
COMMIT;



START TRANSACTION;
UPDATE employees SET salary = 85000.00 WHERE emp_id = 101;
ALTER TABLE employees ADD COLUMN q15_demo_column INT NULL;
ROLLBACK;




START TRANSACTION;
UPDATE departments
SET budget = budget - 10000.00
WHERE dept_id = 10 AND budget >= 10000.00;
UPDATE departments
SET budget = budget + 10000.00
WHERE dept_id = 20;
COMMIT;



SHOW GRANTS FOR 'team_lead'@'localhost';



REVOKE GRANT OPTION ON company_db.*
FROM 'team_lead'@'localhost';



START TRANSACTION;
UPDATE orders SET status = 'Shipped' WHERE order_id = 5002;
SELECT order_id, total_amount, status FROM orders WHERE order_id = 5002;

ROLLBACK;



.
CREATE ROLE IF NOT EXISTS 'reporter_role';
GRANT SELECT ON company_db.* TO 'reporter_role';
GRANT 'reporter_role' TO 'analyst'@'localhost';
SET DEFAULT ROLE 'reporter_role' TO 'analyst'@'localhost';



START TRANSACTION;
UPDATE employees
SET salary = salary * 1.15
WHERE dept_id = 10;
SAVEPOINT sp_salary_done;
UPDATE departments
SET budget = budget + 50000.00
WHERE dept_id = 10;
SELECT dept_id, budget FROM departments WHERE dept_id = 10;

ROLLBACK TO SAVEPOINT sp_salary_done;
COMMIT;

START TRANSACTION;
SELECT * FROM employees WHERE emp_id = 101 FOR UPDATE;
UPDATE employees SET salary = 88000.00 WHERE emp_id = 101;
COMMIT;


START TRANSACTION;
SELECT * FROM departments WHERE dept_id = 10 FOR SHARE;
SELECT e.emp_id, e.first_name, e.last_name, e.salary, d.dept_name
FROM employees AS e
JOIN departments AS d ON e.dept_id = d.dept_id
WHERE d.dept_id = 10;
COMMIT;
ALTER USER 'auditor'@'localhost'
    WITH MAX_QUERIES_PER_HOUR 100
         MAX_USER_CONNECTIONS 2;
SHOW GRANTS FOR 'auditor'@'localhost';
START TRANSACTION;
UPDATE orders
SET status = 'Cancelled'
WHERE order_id = 5002 AND status = 'Pending';
UPDATE departments
SET budget = budget + 450.00
WHERE dept_id = 20;
COMMIT;
CREATE ROLE IF NOT EXISTS 'read_role';
CREATE ROLE IF NOT EXISTS 'write_role';
CREATE ROLE IF NOT EXISTS 'admin_role';

GRANT SELECT ON company_db.* TO 'read_role';
GRANT INSERT, UPDATE, DELETE ON company_db.* TO 'write_role';
GRANT 'read_role', 'write_role' TO 'admin_role';

CREATE USER IF NOT EXISTS 'super_dev'@'localhost'
    IDENTIFIED BY 'SuperDevPass2026!';
GRANT 'admin_role' TO 'super_dev'@'localhost';
SET DEFAULT ROLE 'admin_role' TO 'super_dev'@'localhost';
CREATE USER IF NOT EXISTS 'cloud_user'@'%'
    IDENTIFIED BY 'CloudPass2026!'
    REQUIRE SSL;
GRANT SELECT, INSERT ON company_db.* TO 'cloud_user'@'%';
START TRANSACTION;
INSERT INTO orders
(order_id, customer_name, order_date, total_amount, status)
VALUES (5008, 'Delta Services', CURRENT_DATE, 725.00, 'Pending');
SAVEPOINT sp_5008;
INSERT INTO orders
(order_id, customer_name, order_date, total_amount, status)
VALUES (5009, 'Invalid Test Order', CURRENT_DATE, -50.00, 'Pending');
SAVEPOINT sp_5009;
ROLLBACK TO SAVEPOINT sp_5008;
COMMIT;
CREATE USER IF NOT EXISTS 'test_maint'@'localhost'
    IDENTIFIED BY 'TestMaintPass2026!';
GRANT SELECT, INSERT, UPDATE ON company_db.*
    TO 'test_maint'@'localhost';
USE company_db;
START TRANSACTION;
UPDATE employees SET is_active = TRUE WHERE emp_id = 104;
ROLLBACK;
SHOW GRANTS FOR 'test_maint'@'localhost';
REVOKE SELECT, INSERT, UPDATE ON company_db.*
FROM 'test_maint'@'localhost';
ALTER USER 'test_maint'@'localhost' ACCOUNT LOCK;
