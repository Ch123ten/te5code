-- Create tables with constraints

-- Employee table with index on employee_name
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    street VARCHAR(255),
    city VARCHAR(255) NOT NULL,
    INDEX (employee_name)  -- Add an index on employee_name
);

-- Works table
CREATE TABLE Works (
    employee_name VARCHAR(255),
    company_name VARCHAR(255),
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_name, company_name),
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name),
    FOREIGN KEY (company_name) REFERENCES Company(company_name)
);

-- Company table
CREATE TABLE Company (
    company_name VARCHAR(255) PRIMARY KEY,
    city VARCHAR(255),
    asset DECIMAL(15, 2) -- Added column 'Asset'
);

-- Manages table
CREATE TABLE Manages (
    employee_name VARCHAR(255),
    manager_name VARCHAR(255),
    PRIMARY KEY (employee_name),
    FOREIGN KEY (employee_name) REFERENCES Employee(employee_name),
    FOREIGN KEY (manager_name) REFERENCES Employee(employee_name)
);

-- Insert entries to satisfy the queries

-- 6 entries for Employee table
INSERT INTO Employee (emp_id, employee_name, street, city) VALUES
(1, 'Emp1', 'Street1', 'CityA'),
(2, 'Emp2', 'Street2', 'CityB'),
(3, 'Emp3', 'Street3', 'CityA'),
(4, 'Emp4', 'Street4', 'CityC'),
(5, 'Emp5', 'Street5', 'CityB'),  -- For query 3
(6, 'Emp6', 'Street6', 'CityC');  -- For query 4

-- 3 entries for Company table
INSERT INTO Company (company_name, city, asset) VALUES
('TCS', 'CityA', 1000000),
('InfoSys', 'CityB', 1200000),
('TechM', 'CityC', 800000);

-- 4 entries for Works table
INSERT INTO Works (employee_name, company_name, salary) VALUES
('Emp1', 'TCS', 12000),
('Emp2', 'InfoSys', 15000),
('Emp3', 'TCS', 11000),
('Emp4', 'TechM', 13000);

-- 3 entries for Manages table
INSERT INTO Manages (employee_name, manager_name) VALUES
('Emp1', 'Emp3'),
('Emp2', 'Emp3'),
('Emp3', 'Emp4');

-- Queries

-- 1. Find the names of all employees who work for 'TCS'.
SELECT employee_name FROM Works WHERE company_name = 'TCS';

-- 2. Find the names and company names of all employees sorted in ascending order of company name and descending order of employee names of that company.
SELECT employee_name, company_name
FROM Works
ORDER BY company_name ASC, employee_name DESC;

-- 3. Change the city of the employee working with InfoSys to 'Bangalore'.
UPDATE Employee
SET city = 'Bangalore'
WHERE employee_name IN (SELECT employee_name FROM Works WHERE company_name = 'InfoSys');

-- 4. Find the names, street address, and cities of residence for all employees who work for 'TechM' and earn more than $10,000.
SELECT E.employee_name, E.street, E.city
FROM Employee E
JOIN Works W ON E.employee_name = W.employee_name
WHERE W.company_name = 'TechM' AND W.salary > 10000;
