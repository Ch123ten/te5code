CREATE TABLE Account (
    Acc_no INT PRIMARY KEY,
    branch_name VARCHAR(255),
    balance DECIMAL(10, 2),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

-- Branch table
CREATE TABLE Branch (
    branch_name VARCHAR(255) PRIMARY KEY,
    branch_city VARCHAR(255),
    assets DECIMAL(12, 2)
);

-- Customer table
CREATE TABLE Customer (
    cust_name VARCHAR(255) PRIMARY KEY,
    cust_street VARCHAR(255),
    cust_city VARCHAR(255)
);

-- Depositor table
CREATE TABLE Depositor (
    cust_name VARCHAR(255),
    acc_no INT,
    PRIMARY KEY (cust_name, acc_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (acc_no) REFERENCES Account(Acc_no)
);

-- Loan table
CREATE TABLE Loan (
    loan_no INT PRIMARY KEY,
    branch_name VARCHAR(255),
    amount DECIMAL(10, 2),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

-- Borrower table
CREATE TABLE Borrower (
    cust_name VARCHAR(255),
    loan_no INT,
    PRIMARY KEY (cust_name, loan_no),
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (loan_no) REFERENCES Loan(loan_no)
);




-- Insert data into the Account table
INSERT INTO Account (Acc_no, branch_name, balance) VALUES
(1, 'Wadia College', 5000),
(2, 'XYZ Branch', 8000),
(3, 'ABC Branch', 12000),
(4, 'Wadia College', 10000),
(5, 'PQR Branch', 6000);

-- Insert data into the Branch table
INSERT INTO Branch (branch_name, branch_city, assets) VALUES
('Wadia College', 'CityA', 50000),
('XYZ Branch', 'CityB', 75000),
('ABC Branch', 'CityC', 60000),
('PQR Branch', 'CityD', 45000),
('LMN Branch', 'CityE', 30000);

-- Insert data into the Customer table
INSERT INTO Customer (cust_name, cust_street, cust_city) VALUES
('Customer1', 'Street1', 'CityA'),
('Customer2', 'Street2', 'CityB'),
('Customer3', 'Street3', 'CityC'),
('Customer4', 'Street4', 'CityD'),
('Customer5', 'Street5', 'CityE');

-- Insert data into the Depositor table
INSERT INTO Depositor (cust_name, acc_no) VALUES
('Customer1', 1),
('Customer2', 2),
('Customer3', 3),
('Customer4', 4),
('Customer5', 5);

-- Insert data into the Loan table
INSERT INTO Loan (loan_no, branch_name, amount) VALUES
(101, 'Wadia College', 12000),
(102, 'XYZ Branch', 18000),
(103, 'ABC Branch', 15000),
(104, 'Wadia College', 22000),
(105, 'PQR Branch', 20000);

-- Insert data into the Borrower table
INSERT INTO Borrower (cust_name, loan_no) VALUES
('Customer1', 101),
('Customer2', 102),
('Customer3', 103),
('Customer4', 104),
('Customer5', 105);


-- Queries

-- 1. Find all customers who have both account and loan at the bank.
SELECT DISTINCT C.cust_name
FROM Customer C
JOIN Depositor D ON C.cust_name = D.cust_name
JOIN Borrower B ON C.cust_name = B.cust_name;

-- 2. Find all customers who have an account or loan or both at the bank.
SELECT DISTINCT C.cust_name
FROM Customer C
LEFT JOIN Depositor D ON C.cust_name = D.cust_name
LEFT JOIN Borrower B ON C.cust_name = B.cust_name
WHERE D.cust_name IS NOT NULL OR B.cust_name IS NOT NULL;

-- 3. Find all customers who have an account but no loan at the bank.
SELECT DISTINCT C.cust_name
FROM Customer C
JOIN Depositor D ON C.cust_name = D.cust_name
LEFT JOIN Borrower B ON C.cust_name = B.cust_name
WHERE B.cust_name IS NULL;

-- 4. Find average account balance at 'Wadia College' branch.
SELECT AVG(A.balance) AS avg_balance
FROM Account A
WHERE A.branch_name = 'Wadia College';

-- 5
SELECT A.branch_name, COUNT(DISTINCT D.cust_name) AS num_depositors
FROM Depositor D
JOIN Account A ON D.acc_no = A.Acc_no
GROUP BY A.branch_name;
