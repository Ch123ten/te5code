-- Create tables with constraints

-- Cust_Master table
CREATE TABLE Cust_Master (
    Cust_no INT PRIMARY KEY,
    Cust_name VARCHAR(255) NOT NULL,
    Cust_addr VARCHAR(255)
);

-- Orders table
CREATE TABLE Orders (
    Order_no INT PRIMARY KEY,
    Cust_no INT,
    Order_date DATE,
    Qty_Ordered INT,
    FOREIGN KEY (Cust_no) REFERENCES Cust_Master(Cust_no)
);

-- Product table
CREATE TABLE Product (
    Product_no INT PRIMARY KEY,
    Product_name VARCHAR(255) NOT NULL,
    Order_no INT,
    FOREIGN KEY (Order_no) REFERENCES Orders(Order_no)
);

-- Insert records with modified addresses
INSERT INTO Cust_Master (Cust_no, Cust_name, Cust_addr) VALUES
(1001, 'John', 'Mangalore'),
(1002, 'Alice', 'Bangalore'),
(1003, 'Bob', 'Address3'),
(1004, 'Charlie', 'Bangalore'),
(1005, 'Eva', 'Mangalore'),
(1006, 'David', 'Address6'),
(1007, 'Frank', 'Mangalore'),
(1008, 'Grace', 'Bangalore');

INSERT INTO Orders (Order_no, Cust_no, Order_date, Qty_Ordered) VALUES
(1, 1001, '2023-01-01', 5),
(2, 1002, '2023-01-02', 8),
(3, 1005, '2023-01-03', 10),
(4, 1007, '2023-01-04', 3),
(5, 1008, '2023-01-05', 6);

INSERT INTO Product (Product_no, Product_name, Order_no) VALUES
(101, 'ProductA', 1),
(102, 'ProductB', 2),
(103, 'ProductC', 3),
(104, 'ProductD', 4),
(105, 'ProductE', 5);

-- Queries

-- 1. List names of customers having 'A' as the second letter in their name.
SELECT Cust_name FROM Cust_Master WHERE SUBSTRING(Cust_name, 2, 1) = 'A';

-- 2. Display orders from Customer no C1002, C1005, C1007, and C1008.
SELECT * FROM Orders WHERE Cust_no IN (1002, 1005, 1007, 1008);

-- 3. List clients who stay in either 'Bangalore' or 'Mangalore'.
SELECT * FROM Cust_Master WHERE Cust_addr IN ('Bangalore', 'Mangalore');

-- 4. Display the name of customers & the product_name they have purchased.
SELECT CM.Cust_name, P.Product_name
FROM Cust_Master CM
JOIN Orders O ON CM.Cust_no = O.Cust_no
JOIN Product P ON O.Order_no = P.Order_no;

-- 5. Create view View1 consisting of Cust_name, Product_name.
CREATE VIEW View1 AS
SELECT CM.Cust_name, P.Product_name
FROM Cust_Master CM
JOIN Orders O ON CM.Cust_no = O.Cust_no
JOIN Product P ON O.Order_no = P.Order_no;

-- 6. Display product_name and quantity purchased by each customer.
SELECT CM.Cust_name, P.Product_name, O.Qty_Ordered
FROM Cust_Master CM
JOIN Orders O ON CM.Cust_no = O.Cust_no
JOIN Product P ON O.Order_no = P.Order_no;

-- 7. Perform different join operations.
-- Example: INNER JOIN
SELECT CM.Cust_name, O.Order_date
FROM Cust_Master CM
INNER JOIN Orders O ON CM.Cust_no = O.Cust_no;
