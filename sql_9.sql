-- Create CUSTOMERS table
CREATE TABLE CUSTOMERS (
    CNo INT PRIMARY KEY,
    Cname VARCHAR(50),
    Ccity VARCHAR(50),
    CMobile VARCHAR(15)
);

-- Create ITEMS table
CREATE TABLE ITEMS (
    INo INT PRIMARY KEY,
    Iname VARCHAR(50),
    Itype VARCHAR(50),
    Iprice DECIMAL(10, 2),
    Icount INT
);

-- Create PURCHASE table
CREATE TABLE PURCHASE (
    PNo INT PRIMARY KEY,
    Pdate DATE,
    Pquantity INT,
    Cno INT,
    INo INT,
    FOREIGN KEY (Cno) REFERENCES CUSTOMERS(CNo),
    FOREIGN KEY (INo) REFERENCES ITEMS(INo)
);

-- Insert sample data into CUSTOMERS table
INSERT INTO CUSTOMERS (CNo, Cname, Ccity, CMobile)
VALUES
    (1, 'Gopal', 'CityA', '1234567890'),
    (2, 'Maya', 'CityB', '9876543210'),
    (3, 'John', 'CityA', '9999999999');

-- Insert sample data into ITEMS table
INSERT INTO ITEMS (INo, Iname, Itype, Iprice, Icount)
VALUES
    (1, 'Pen', 'Stationary', 50.00, 100),
    (2, 'Notebook', 'Stationary', 200.00, 50),
    (3, 'Printer', 'Electronics', 1500.00, 20),
    (4, 'Stapler', 'Stationary', 300.00, 30),
    (5, 'Eraser', 'Stationary', 5.00, 200);

-- Insert sample data into PURCHASE table
INSERT INTO PURCHASE (PNo, Pdate, Pquantity, Cno, INo)
VALUES
    (1, '2023-10-15', 2, 1, 1),
    (2, '2023-09-20', 1, 2, 2),
    (3, '2023-08-25', 1, 3, 4),
    (4, '2023-07-30', 3, 1, 5),
    (5, '2023-06-10', 2, 2, 1);

-- Queries

-- 1. List all stationary items with price between 400/- to 1000/-
SELECT * 
FROM ITEMS 
WHERE Itype = 'Stationary' AND Iprice BETWEEN 400 AND 1000;

-- 2. Change the mobile number of customer “Gopal”
UPDATE CUSTOMERS 
SET CMobile = '9999999999' 
WHERE Cname = 'Gopal';

-- 3. Display the item with the maximum price
SELECT * 
FROM ITEMS 
WHERE Iprice = (SELECT MAX(Iprice) FROM ITEMS);

-- 4. Display all purchases sorted from the most recent to the oldest
SELECT * 
FROM PURCHASE 
ORDER BY Pdate DESC;

-- 5. Count the number of customers in every city
SELECT Ccity, COUNT(*) as Num_Customers 
FROM CUSTOMERS 
GROUP BY Ccity;

-- 6. Display all purchased quantities of Customer Maya
SELECT P.Pquantity, I.Iname 
FROM PURCHASE P 
JOIN ITEMS I ON P.INo = I.INo 
JOIN CUSTOMERS C ON P.Cno = C.CNo 
WHERE C.Cname = 'Maya';

-- 7. Create view which shows Iname, Price, and Count of all stationary items in descending order of price
CREATE VIEW Stationary_Items_View AS 
SELECT Iname, Iprice, Icount 
FROM ITEMS 
WHERE Itype = 'Stationary' 
ORDER BY Iprice DESC;
