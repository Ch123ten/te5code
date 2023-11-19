-- Create tables with constraints

-- Employee table with primary key and unique index on employee_name
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    street VARCHAR(255),
    city VARCHAR(255) NOT NULL,
    UNIQUE INDEX idx_employee_name (employee_name)
);

-- Works table with composite primary key and foreign keys
CREATE TABLE Works (
    employee_name VARCHAR(255),
    company_name VARCHAR(255),
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_name, company_name),
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name),
    FOREIGN KEY (company_name) REFERENCES Company(company_name)
);

-- Company table with primary key
CREATE TABLE Company (
    company_name VARCHAR(255) PRIMARY KEY,
    city VARCHAR(255)
);

-- Management table with primary key and foreign keys
CREATE TABLE Management (
    employee_name VARCHAR(255),
    manager_name VARCHAR(255),
    PRIMARY KEY (employee_name),
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name),
    FOREIGN KEY (manager_name) REFERENCES Employee(employee_name)
);

-- Insert entries
INSERT INTO Employee (emp_id, employee_name, street, city) VALUES
(1, 'Emp1', 'Street1', 'CityA'),
(2, 'Emp2', 'Street2', 'CityB'),
(3, 'Emp3', 'Street3', 'CityA'),
(4, 'Emp4', 'Street4', 'CityC');

INSERT INTO Company (company_name, city) VALUES
('InfoSys', 'CityB'),
('TechM', 'CityC');

INSERT INTO Works (employee_name, company_name, salary) VALUES
('Emp1', 'InfoSys', 12000),
('Emp2', 'TechM', 15000),
('Emp3', 'InfoSys', 11000),
('Emp4', 'TechM', 13000);

INSERT INTO Management (employee_name, manager_name) VALUES
('Emp1', 'Emp3'),
('Emp2', 'Emp3'),
('Emp3', 'Emp4');

-- Queries

-- 1. Change the city of employee working with InfoSys to 'Bangalore'.
UPDATE Employee
SET city = 'Bangalore'
WHERE employee_name IN (SELECT employee_name FROM Works WHERE company_name = 'InfoSys');

-- 2. Find the names of all employees who earn more than the average salary of all employees of their company.
SELECT E.employee_name
FROM Employee E
JOIN Works W ON E.employee_name = W.employee_name
WHERE W.salary > (SELECT AVG(salary) FROM Works WHERE company_name = W.company_name);

-- 3. Find the names, street address, and cities of residence for all employees who work for 'TechM' and earn more than $10,000.
SELECT E.employee_name, E.street, E.city
FROM Employee E
JOIN Works W ON E.employee_name = W.employee_name
WHERE W.company_name = 'TechM' AND W.salary > 10000;

-- 4. Change the name of the table Manages to Management.
ALTER TABLE Manages
RENAME TO Management;

-- 5. Create a Simple and Unique index on the employee table.
CREATE UNIQUE INDEX idx_employee_id ON Employee(emp_id);

-- 6. Display index information.
SHOW INDEX FROM Employee;
