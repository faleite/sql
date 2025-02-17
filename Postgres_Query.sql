-- DDL (Data Definition Language) - Defining database structures

-- Creating the "brands" table
CREATE TABLE brands (
    id SERIAL PRIMARY KEY,             -- Primary key; SERIAL auto-increments
    name VARCHAR(100) NOT NULL UNIQUE,  -- Name with unique constraint
    site VARCHAR(100),                  -- URL or website
    phone VARCHAR(15)
); -- Semicolon to end the query

-- Creating the "products" table.
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price REAL,                         -- Price with decimals
    stock INTEGER DEFAULT 0,            -- Default stock
    brand_id INT NOT NULL,
    CONSTRAINT fk_brand FOREIGN KEY (brand_id) REFERENCES brands(id)
);

-- For demonstration, creating a temporary table "control" and then dropping it.
CREATE TABLE control (
    id SERIAL PRIMARY KEY,
    entry_date DATE
);

-- Dropping the "control" table.
DROP TABLE IF EXISTS control;

-- Creating an index on the "name" column of the "products" table.
CREATE INDEX idx_products_name ON products (name);

-- (The following ALTER is not needed because we already created "brands" with "site".)
-- ALTER TABLE brands RENAME COLUMN size TO site;

-- DML (Data Manipulation Language) - Inserting and modifying data

-- Inserting data into the "brands" table.
INSERT INTO brands (name, site, phone)
VALUES
    ('Bose', 'http://bose.com', '(11) 99999-1111'),
    ('JBL', 'http://jbl.com.br', '(11) 88888-2222');

-- Inserting a product without specifying the field list.
-- (Note: In PostgreSQL, it is generally recommended not to supply values for serial columns.)
INSERT INTO products
VALUES (1, 'JBL Flip 6', 219.99, 45, 2);

-- Inserting additional products while specifying the fields.
INSERT INTO products (name, price, stock, brand_id)
VALUES
    ('Bose QuietComfort 45', 379.99, 40, 1),
    ('Bose SoundSport', 299.99, 30, 1),
    ('JBL Charge 5', 199.99, 50, 2),
    ('JBL Flip 6', 219.99, 45, 2);

-- Data Queries

-- List all fields from the "brands" table.
SELECT * FROM brands;

-- List specific fields from "brands".
SELECT id, name FROM brands;

-- Queries using a WHERE filter.
SELECT id, name FROM brands WHERE id = 1;
SELECT id, name FROM brands WHERE id > 1;

-- Query with a combined (AND) filter.
SELECT id, name FROM brands WHERE id > 1 AND id < 4;

-- Creating a derived table "apple_products"
CREATE TABLE apple_products (
    name VARCHAR(150) NOT NULL,
    stock INTEGER DEFAULT 0
);

INSERT INTO apple_products
SELECT name, stock FROM products WHERE brand_id = 1;

SELECT * FROM apple_products;

-- Delete all records from the derived table.
TRUNCATE TABLE apple_products;

-- Drop the derived table.
DROP TABLE apple_products;

-- Data updates

-- Update the name of a product.
UPDATE products
SET name = 'JBL Flip 6 Black'
WHERE id = 12;

-- Increase the stock of all products.
UPDATE products
SET stock = stock + 10;

-- Increase the stock of a specific product.
UPDATE products
SET stock = stock + 1
WHERE id = 3;

-- Delete a product by its ID.
DELETE FROM products
WHERE id = 1;

-- Advanced Data Queries

-- Show products with stock less than 100 and price greater than 30.
SELECT *
FROM products
WHERE stock < 100
  AND price > 30;

-- Show products whose name contains "Flip".
SELECT *
FROM products
WHERE name LIKE '%Flip%';

-- Show products ordered by stock in ascending order.
SELECT *
FROM products
ORDER BY stock ASC;

-- Show products ordered by stock in descending order, limiting to 2 records.
SELECT *
FROM products
ORDER BY stock DESC
LIMIT 2;

-- ------------------------------------------------
-- Creating tables related to customers and orders

-- Creating the "customers" table.
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(200),
    birth_date DATE
);

-- Creating the "orders" table.
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    order_date DATE DEFAULT CURRENT_DATE,
    customer_id INT,
    total_value REAL,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Creating the "order_items" table.
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price REAL,
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(id),
    PRIMARY KEY (order_id, product_id)
);

-- Inserting data into "customers".
INSERT INTO customers (name, email, city)
VALUES
    ('Carlos Silva', 'carlos.silva@example.com', 'São Paulo'),
    ('Mariana Costa', 'mariana.costa@example.com', 'Rio de Janeiro'),
    ('João Almeida', 'joao.almeida@example.com', 'Belo Horizonte'),
    ('Fernanda Souza', 'fernanda.souza@example.com', 'Curitiba'),
    ('Rafael Martins', 'rafael.martins@example.com', 'Fortaleza'),
    ('Maria Oliveira', 'maria@example.com', 'São Paulo'),
    ('José Santos', 'jose@example.com', 'Rio de Janeiro');

-- Inserting data into "orders".
INSERT INTO orders (customer_id, total_value) VALUES
    (1, 5500.00),
    (2, 3500.00);

-- Inserting data into "order_items".
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
    (1, 9, 1, 3500.00),
    (1, 10, 1, 2000.00),
    (2, 11, 1, 3500.00);

-- Queries with JOINs

-- INNER JOIN between customers and orders.
SELECT
    customers.name,
    orders.total_value
FROM customers
INNER JOIN orders ON customers.id = orders.customer_id;

-- Subquery: List product name and price for products of brand 'JBL' or 'Bose'.
SELECT
    name, price
FROM products
WHERE brand_id IN (
    SELECT id
    FROM brands
    WHERE name = 'JBL' OR name = 'Bose'
);

-- LEFT JOIN between customers and orders.
SELECT
    customers.name,
    orders.total_value
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id;

-- RIGHT JOIN between customers and orders.
SELECT
    customers.name,
    orders.total_value
FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;

-- FULL JOIN simulated with UNION (PostgreSQL supports FULL JOIN directly, but here's a union example).
SELECT
    customers.name,
    orders.total_value
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
UNION
SELECT
    customers.name,
    orders.total_value
FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;

-- Aggregation queries

-- Count of customers per city.
SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city;

-- Average sales per month.
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    AVG(total_value) AS avg_sales
FROM orders
GROUP BY month;

-- Other aggregation functions.
SELECT SUM(total_value)/COUNT(total_value) FROM orders;
SELECT MAX(total_value) AS highest_order FROM orders;
SELECT MIN(total_value) AS lowest_order FROM orders;

-- Query: List products with stock less than the average stock.
SELECT
    name,
    stock
FROM products
WHERE stock < (SELECT AVG(stock) FROM products);

-- Aggregation with JOIN: List the city and total sales for selected cities.
SELECT
    c.city,
    SUM(o.total_value) AS total_sales
FROM customers AS c
INNER JOIN orders AS o ON c.id = o.customer_id
WHERE c.city IN ('São Paulo', 'Rio de Janeiro')
GROUP BY c.city
HAVING SUM(o.total_value) < 5000;