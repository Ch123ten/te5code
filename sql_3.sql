-- Create tables with constraints

-- Account table
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



-- Insert data into the Branch table
INSERT INTO Branch (branch_name, branch_city, assets) VALUES
('Wadia College', 'CityA', 50000),
('XYZ Branch', 'CityB', 75000),
('ABC Branch', 'CityC', 60000),
('PQR Branch', 'CityD', 45000),
('LMN Branch', 'CityE', 30000),
('OPQ Branch', 'CityF', 40000);

-- Insert data into the Customer table
INSERT INTO Customer (cust_name, cust_street, cust_city) VALUES
('Customer1', 'Street1', 'CityA'),
('Customer2', 'Street2', 'CityB'),
('Customer3', 'Street3', 'CityC'),
('Customer4', 'Street4', 'CityD'),
('Customer5', 'Street5', 'CityE'),
('Prakash', 'StreetX', 'CityY'),
('Panchali', 'StreetY', 'CityZ');

-- Insert data into the Account table
INSERT INTO Account (Acc_no, branch_name, balance) VALUES
(1, 'Wadia College', 20000),
(2, 'XYZ Branch', 25000),
(3, 'ABC Branch', 18000),
(4, 'PQR Branch', 22000),
(5, 'LMN Branch', 30000),
(6, 'OPQ Branch', 15000);

-- Insert data into the Depositor table
INSERT INTO Depositor (cust_name, acc_no) VALUES
('Customer1', 1),
('Customer2', 2),
('Customer3', 3),
('Customer4', 4),
('Customer5', 5),
('Prakash', 6);

-- Insert data into the Loan table
INSERT INTO Loan (loan_no, branch_name, amount) VALUES
(101, 'Wadia College', 12000),
(102, 'XYZ Branch', 18000),
(103, 'ABC Branch', 15000),
(104, 'PQR Branch', 1400),  -- Between 1300 and 1500
(105, 'LMN Branch', 20000),
(106, 'OPQ Branch', 1450);  -- Between 1300 and 1500

-- Insert data into the Borrower table
INSERT INTO Borrower (cust_name, loan_no) VALUES
('Customer1', 101),
('Customer2', 102),
('Customer3', 103),
('Customer4', 104),
('Customer5', 105),
('Panchali', 106);

-- Queries

-- 1. Find the branches where average account balance > 15000.
SELECT branch_name
FROM Account
GROUP BY branch_name
HAVING AVG(balance) > 15000;

-- 2. Find the number of tuples in the customer relation.
SELECT COUNT(*) AS num_tuples FROM Customer;

-- 3. Calculate total loan amount given by the bank.
SELECT SUM(amount) AS total_loan_amount FROM Loan;

-- 4. Delete all loans with loan amount between 1300 and 1500.
-- Update Borrower entries to set loan_no to NULL
UPDATE Borrower SET loan_no = NULL WHERE loan_no IN (
    SELECT loan_no FROM Loan WHERE amount BETWEEN 1300 AND 1500
);

-- Now you can safely delete the loans
DELETE FROM Loan WHERE amount BETWEEN 1300 AND 1500;


-- 5. Find the average account balance at each branch.
SELECT branch_name, AVG(balance) AS avg_balance
FROM Account
GROUP BY branch_name;

-- 6. Find the name of Customer and city where the customer name starts with the letter P.
SELECT cust_name, cust_city
FROM Customer
WHERE cust_name LIKE 'P%';
