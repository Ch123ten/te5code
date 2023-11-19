-- Create tables with constraints

-- Companies table with primary key
CREATE TABLE Companies (
    comp_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    cost DECIMAL(10, 2),
    year INT
);

-- Orders table with primary key and foreign key
CREATE TABLE Orders (
    comp_id INT,
    domain VARCHAR(255),
    quantity INT,
    PRIMARY KEY (comp_id, domain),
    FOREIGN KEY (comp_id) REFERENCES Companies(comp_id)
);

-- Insert entries

-- Companies table
INSERT INTO Companies (comp_id, name, cost, year) VALUES
(1, 'Company1', 50000, 2000),
(2, 'Company2', 70000, 2010),
(3, 'Company3', 60000, 2015);

-- Orders table
INSERT INTO Orders (comp_id, domain, quantity) VALUES
(1, 'DomainA', 100),
(2, 'DomainB', 150),
(3, 'DomainC', 120);

-- Queries

-- 1. Find names, costs, domains, and quantities for companies using inner join.
SELECT C.name, C.cost, O.domain, O.quantity
FROM Companies C
INNER JOIN Orders O ON C.comp_id = O.comp_id;

-- 2. Find names, costs, domains, and quantities for companies using left outer join.
SELECT C.name, C.cost, O.domain, O.quantity
FROM Companies C
LEFT JOIN Orders O ON C.comp_id = O.comp_id;

-- 3. Find names, costs, domains, and quantities for companies using right outer join.
SELECT C.name, C.cost, O.domain, O.quantity
FROM Companies C
RIGHT JOIN Orders O ON C.comp_id = O.comp_id;

-- 4. Find names, costs, domains, and quantities for companies using Union operator.
SELECT name, cost, NULL AS domain, NULL AS quantity FROM Companies
UNION
SELECT C.name, C.cost, O.domain, O.quantity
FROM Companies C
INNER JOIN Orders O ON C.comp_id = O.comp_id;

-- 5. Create View View1 by selecting both tables to show company name and quantities.
CREATE VIEW View1 AS
SELECT C.name, O.quantity
FROM Companies C
LEFT JOIN Orders O ON C.comp_id = O.comp_id;

-- 6. Create View View2 by selecting any two columns and perform insert, update, delete operations.
CREATE VIEW View2 AS
SELECT comp_id, name
FROM Companies;

-- Insert into View2
INSERT INTO View2 (comp_id, name) VALUES (4, 'Company4');

-- Update View2
UPDATE View2 SET name = 'UpdatedCompany' WHERE comp_id = 4;

-- Delete from View2
DELETE FROM View2 WHERE comp_id = 4;

-- 7. Display content of View1, View2.
SELECT * FROM View1;
SELECT * FROM View2;
