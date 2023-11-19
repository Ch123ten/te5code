-- Create tables with constraints

-- Account table with primary key
CREATE TABLE Account (
    Acc_no INT PRIMARY KEY,
    branch_name VARCHAR(255),
    balance DECIMAL(10, 2),
    UNIQUE INDEX idx_acc_branch (Acc_no, branch_name)
);

-- Branch table with primary key
CREATE TABLE Branch (
    branch_name VARCHAR(255) PRIMARY KEY,
    branch_city VARCHAR(255),
    assets DECIMAL(15, 2)
);

-- Customer table with primary key
CREATE TABLE Customer (
    cust_name VARCHAR(255) PRIMARY KEY,
    cust_street VARCHAR(255),
    cust_city VARCHAR(255)
);

-- Depositor table with primary key and foreign keys
CREATE TABLE Depositor (
    cust_name VARCHAR(255),
    acc_no INT,
    PRIMARY KEY (cust_name, acc_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (acc_no) REFERENCES Account(Acc_no)
);

-- Loan table with primary key and foreign key
CREATE TABLE Loan (
    loan_no INT PRIMARY KEY,
    branch_name VARCHAR(255),
    amount DECIMAL(10, 2),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

-- Borrower table with primary key and foreign keys
CREATE TABLE Borrower (
    cust_name VARCHAR(255),
    loan_no INT,
    PRIMARY KEY (cust_name, loan_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (loan_no) REFERENCES Loan(loan_no)
);

-- Insert entries

-- Account table
INSERT INTO Account (Acc_no, branch_name, balance) VALUES
(1, 'Pune_Station', 5000),
(2, 'Wadia_College', 8000),
(3, 'Pune_Station', 12000),
(4, 'ABC_Bank', 10000);

-- Branch table
INSERT INTO Branch (branch_name, branch_city, assets) VALUES
('Pune_Station', 'Pune', 500000),
('Wadia_College', 'Pune', 700000),
('ABC_Bank', 'Mumbai', 900000);

-- Customer table
INSERT INTO Customer (cust_name, cust_street, cust_city) VALUES
('Customer1', 'Street1', 'City1'),
('Customer2', 'Street2', 'City2'),
('Customer3', 'Street3', 'City1'),
('Customer4', 'Street4', 'City3');

-- Depositor table
INSERT INTO Depositor (cust_name, acc_no) VALUES
('Customer1', 1),
('Customer2', 2),
('Customer3', 3),
('Customer4', 4);

-- Loan table
INSERT INTO Loan (loan_no, branch_name, amount) VALUES
(101, 'Pune_Station', 12000),
(102, 'Wadia_College', 18000),
(103, 'ABC_Bank', 15000);

-- Borrower table
INSERT INTO Borrower (cust_name, loan_no) VALUES
('Customer1', 101),
('Customer2', 102),
('Customer3', 103);

-- Queries

-- 1. Create View1 to display List all customers in alphabetical order who have a loan from Pune_Station branch.
CREATE VIEW View1 AS
SELECT C.cust_name
FROM Customer C
JOIN Borrower B ON C.cust_name = B.cust_name
JOIN Loan L ON B.loan_no = L.loan_no
WHERE L.branch_name = 'Pune_Station'
ORDER BY C.cust_name;

-- 2. Create View2 on the branch table by selecting any two columns.
CREATE VIEW View2 AS
SELECT branch_name, branch_city
FROM Branch;

-- 3. Create View3 on borrower and depositor table by selecting any one column from each table.
CREATE VIEW View3 AS
SELECT B.cust_name
FROM Borrower B
UNION
SELECT D.cust_name
FROM Depositor D;

-- 4. Create Union of left and right join for all customers who have an account or loan or both at the bank.
CREATE VIEW View4 AS
SELECT C.cust_name
FROM Customer C
LEFT JOIN Depositor D ON C.cust_name = D.cust_name
UNION
SELECT B.cust_name
FROM Borrower B
RIGHT JOIN Loan L ON B.loan_no = L.loan_no;

-- 5. Create a Simple and Unique index on the Customer table.
CREATE UNIQUE INDEX idx_cust_name ON Customer(cust_name);

-- 6. Display index information.
SHOW INDEX FROM Customer;
