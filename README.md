```
███████╗ ██████╗ ██╗     
██╔════╝██╔═══██╗██║     
███████╗██║   ██║██║     
╚════██║██║▄▄ ██║██║     
███████║╚██████╔╝███████╗
╚══════╝ ╚══▀▀═╝ ╚══════╝
Structured Query Language
```

## Index
* **[What is SQL and its Importance](#what-is-sql-and-its-importance)**
* **[The Four Main SQL Sublanguages](#the-four-main-sql-sublanguages)**
* **[Essential Concepts](#essential-concepts)**
* **[PostgreSQL Installation via Docker](#postgresql-installation-via-docker)**
* **[MySQL Installation via Docker](#mysql-installation-via-docker)**
* **[Using PostgreSQL from the Command Line](#using-postgresql-from-the-command-line)**
* **[DDL and DML Commands](#ddl-and-dml-commands)**
  * **[1. Table Creation and Alteration](#1-table-creation-and-alteration)**
  * **[2. Data Insertion (DML)](#2-data-insertion-dml)**
  * **[3. Data Queries](#3-data-queries)**
  * **[4. Creating a Derived Table](#4-creating-a-derived-table)**
  * **[5. Data Update and Deletion](#5-data-update-and-deletion)**
  * **[6. Advanced Queries](#6-advanced-queries)**
  * **[7. Working with Customers and Orders](#7-working-with-customers-and-orders)**
  * **[8. Aggregation Queries and Subqueries](#8-aggregation-queries-and-subqueries)**

---

## What is SQL and its Importance
- **SQL** (Structured Query Language) is a language for manipulating and processing data in relational databases, created by IBM and standardized by ANSI in 1986.
- Even after 50 years, it remains the standard and most used language to interact with databases, making it essential for full stack and backend developers.
- **SQL** is compatible with the main database systems in the market, such as MySQL, Oracle Database, PostgreSQL, SQL Server, SQLite, etc.
- **SQL** is a declarative language, meaning the programmer specifies what they want to obtain—not how to obtain it—as the DBMS is responsible for optimization and execution.
- **DBMS** stands for "Database Management System." It is the software responsible for managing, storing, retrieving, and administering the data in a database, ensuring integrity, security, and performance in the operations performed.

[↑ Index ↑](#index)

---

## The Four Main SQL Sublanguages
*SQL is generally divided into four main sublanguages:*

1. **DDL (Data Definition Language):**  
   Responsible for defining or modifying the database structures such as creating, altering, or dropping tables and other objects (e.g.: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`).

2. **DML (Data Manipulation Language):**  
   Used to manipulate the actual data, allowing the insertion, updating, deletion, and querying of records (e.g.: `INSERT`, `UPDATE`, `DELETE`, `SELECT`).  
   **DQL (Data Query Language):**  
   A subset of DML that refers only to data querying through the `SELECT` command.

3. **DCL (Data Control Language):**  
   Used to control data access and permissions in the database (e.g.: `GRANT`, `REVOKE`, `DENY`).

4. **TCL (Transaction Control Language):**  
   Manages transactions in the database, ensuring data integrity via commands that control the beginning, committing, or rollback of transactions (e.g.: `COMMIT`, `ROLLBACK`, `BEGIN TRANSACTION`).

*These divisions help organize the operations we can perform on a database, making data management and manipulation more structured and secure.*

[↑ Index ↑](#index)

---

## Essential Concepts
- **Primary Key:** Column(s) that uniquely identify each row in a table.
- **Foreign Key:** Column(s) that establish a relationship between two tables, ensuring referential integrity.
- **Index:** A structure that speeds up record lookup in a table.

---

## PostgreSQL Installation via Docker
- Pull the **postgres** image:  
  `$ docker pull postgres:latest`
- Create a data volume:  
  `$ docker volume create learn-sql-data`
- Create/Run the container:
  
  ```bash
  $ docker run -d \
    --name learn-sql \
    -e POSTGRES_USER=postgres \
    -e POSTGRES_PASSWORD=sql \
    -p 5432:5432 \
    -v learn-sql-data:/var/lib/postgresql/data \
    postgres:latest
  ```

---

## Using PostgreSQL from the Command Line
- Access the container:  
  `$ docker exec -it learn-sql bash`
- Access PostgreSQL:  
  `$ psql -U postgres`
- List the databases:  
  `\l`
- Create a database:  
  `CREATE DATABASE learn_sql;`
- Connect to a database:  
  `\c learn_sql;`
- List the tables:  
  `\dt`
- Exit PostgreSQL:  
  `\q`
- **Docker commands:**
  - Stop the container:  
    `$ docker stop learn-sql`
  - Start the container:  
    `$ docker start learn-sql`
  - List containers:  
    `$ docker ps -a`
  - Remove the container:  
    `$ docker rm learn-sql`
  - Remove the image:  
    `$ docker rmi postgres:latest`
  - Remove the volume:  
    `$ docker volume rm learn-sql-data`

[↑ Index ↑](#index)

---

## MySQL Installation via Docker
- Pull the **mysql** image:  
  `$ docker pull mysql:latest`
- Create a data volume:  
  `$ docker volume create learn-sql-data`
- Create/Run the container:
  
  ```bash
  $ docker run -d \
    --name learn-sql \
    -e MYSQL_ROOT_PASSWORD=sql \
    -p 3306:3306 \
    -v learn-sql-data:/var/lib/mysql \
    mysql:latest
  ```
- **Explanation:**
  - `$ docker run -d` --> *detached mode (running in the background)*
  - `--name learn-sql` --> *container name*
  - `-e MYSQL_ROOT_PASSWORD=sql` --> *environment variable*
  - `-p 3306:3306` --> *container port mapping*
  - `-v learn-sql-data:/var/lib/mysql` --> *data volume*
  - `mysql:latest` --> *image*

---

## Using MySQL from the Command Line
- Access the container:  
  `$ docker exec -it learn-sql bash`
- Access MySQL:  
  `$ mysql -u root -p`
- **Commands:**
  - Create a database:  
    `CREATE DATABASE learn_sql;`
  - Select a database:  
    `USE learn_sql;`
  - List the databases:  
    `SHOW DATABASES;`

[↑ Index ↑](#index)

---

## DDL and DML Commands  
*Commands to create, manipulate, and query data in a PostgresSQL database.*  

>You can run the commands below on your instance of PostgresSQL, either via the command line or using a graphical interface.

### 1. Table Creation and Alteration

#### 1.1 Creating the `brands` Table
```sql
CREATE TABLE brands (
    id SERIAL PRIMARY KEY, -- Primary key
    name VARCHAR(100) NOT NULL UNIQUE, -- Data type with character limit and unique constraint
    size VARCHAR(100),
    phone VARCHAR(15)
); -- Semicolon to end the query
```

#### 1.2 Creating the `products` Table
```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY, -- Primary key
    name VARCHAR(100) NOT NULL, -- Data type with character limit
    price REAL, -- Data type with decimal values
    stock INTEGER DEFAULT 0 -- Data type with default value
); -- Semicolon to end the query
```

#### 1.3 Alterations to the `products` Table
- **Add a column:**
  ```sql
  ALTER TABLE products ADD COLUMN brand_id INT NOT NULL;
  ```
- **Modify the data type of the `name` column:**
  ```sql
  ALTER TABLE products ALTER COLUMN name TYPE VARCHAR(150);
  ```
- **Add a foreign key:**
  ```sql
  ALTER TABLE products ADD FOREIGN KEY (brand_id) REFERENCES brands(id);
  ```

#### 1.4 Other Operations
- **Creation of the `control` Table:**
  ```sql
  CREATE TABLE control (
      id INTEGER PRIMARY KEY,
      entry_date DATE
  );
  ```
- **Removing the `control` Table:**
  ```sql
  DROP TABLE control;
  -- Or safely:
  DROP TABLE IF EXISTS control;
  ```
- **Creating an index on the `products` Table:**
  ```sql
  CREATE INDEX idx_products_name ON products (name);
  ```
- **Rename the `size` column to `site` in the `brands` Table:**
  ```sql
  ALTER TABLE brands RENAME COLUMN size TO site;
  ```

---

### 2. Data Insertion (DML)

#### 2.1 Inserting Data into the `brands` Table
```sql
INSERT INTO brands (name, site, phone)
VALUES
    ('Bose', 'http://bose.com', '(11) 99999-1111'),
    ('JBL', 'http://jbl.com.br', '(11) 88888-2222');
```

#### 2.2 Inserting Data into the `products` Table
- **Insert without specifying the field list:**
  ```sql
  INSERT INTO products
  VALUES
      (1, 'Produto 1', 10.5, 100, 1);
  ```
- **Insert specifying the fields:**
  ```sql
  INSERT INTO products (name, price, stock, brand_id)
  VALUES
      ('Bose QuietComfort 45', 379.99, 40, 1),
      ('Bose SoundSport', 299.99, 30, 1),
      ('JBL Charge 5', 199.99, 50, 2),
      ('JBL Flip 6', 219.99, 45, 2);
  ```

---

### 3. Data Queries

#### 3.1 Selecting Data from the `brands` Table
- **Select all fields:**
  ```sql
  SELECT * FROM brands;
  ```
- **Select specific fields:**
  ```sql
  SELECT id, name FROM brands;
  ```
- **Select with a WHERE filter:**
  ```sql
  SELECT id, name FROM brands WHERE id = 1;
  SELECT id, name FROM brands WHERE id > 1;
  ```
- **Select with a combined (AND) filter:**
  ```sql
  SELECT id, name FROM brands WHERE id > 1 AND id < 4;
  ```

---

### 4. Creating a Derived Table

#### 4.1 Creating the `products_apple` Table
```sql
CREATE TABLE products_apple (
    name VARCHAR(150) NOT NULL,
    stock INTEGER DEFAULT 0
);
```
- **Insert data based on the `products` table:**
  ```sql
  INSERT INTO products_apple
  SELECT name, stock FROM products WHERE brand_id = 1;
  ```
- **View the data:**
  ```sql
  SELECT * FROM products_apple;
  ```
- **Clear and remove the table:**
  ```sql
  TRUNCATE TABLE products_apple;
  
  DROP TABLE products_apple;
  ```

---

### 5. Data Update and Deletion

#### 5.1 Updating Data in the `products` Table
- **Update the name of a product:**
  ```sql
  UPDATE products
  SET name = 'JBL Flip 6 Black'
  WHERE id = 12;
  ```
- **Update the stock for all products:**
  ```sql
  UPDATE products
  SET stock = stock + 10;
  ```
- **Update the stock for a specific product:**
  ```sql
  UPDATE products
  SET stock = stock + 1
  WHERE id = 3;
  ```

#### 5.2 Deleting Data
- **Delete a specific product by ID:**
  ```sql
  DELETE FROM products
  WHERE id = 1;
  ```

---

### 6. Advanced Queries

#### 6.1 Filters and Ordering
- **Products with stock less than 100 and price greater than 30:**
  ```sql
  SELECT *
  FROM products
  WHERE 
      stock < 100
      AND price > 30;
  ```
- **Products with a name containing "Flip":**
  ```sql
  SELECT *
  FROM products
  WHERE name LIKE '%Flip%';
  ```
- **Products ordered by stock in ascending order:**
  ```sql
  SELECT *
  FROM products
  ORDER BY stock ASC;
  ```
- **Products ordered by stock in descending order, limited to 2 records:**
  ```sql
  SELECT *
  FROM products
  ORDER BY stock DESC
  LIMIT 2;
  ```

---

### 7. Working with Customers and Orders

#### 7.1 Creating the `customers`, `orders`, and `order_items` Tables
```sql
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(200),
    birth_date DATE
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    order_date DATE DEFAULT CURRENT_DATE,
    customer_id INT,
    total_value REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price REAL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    PRIMARY KEY (order_id, product_id)
);
```

#### 7.2 Inserting Data
- **Customers:**
  ```sql
  INSERT INTO customers (name, email, city)
  VALUES
      ('Carlos Silva', 'carlos.silva@example.com', 'São Paulo'),
      ('Mariana Costa', 'mariana.costa@example.com', 'Rio de Janeiro'),
      ('João Almeida', 'joao.almeida@example.com', 'Belo Horizonte'),
      ('Fernanda Souza', 'fernanda.souza@example.com', 'Curitiba'),
      ('Rafael Martins', 'rafael.martins@example.com', 'Fortaleza'),
      ('Maria Oliveira', 'maria@examplecom', 'São Paulo'),
      ('José Santos', 'josé@example.com', 'Rio de Janeiro');
  ```
- **Orders:**
  ```sql
  INSERT INTO orders (customer_id, total_value) VALUES
  (1, 5500.00),
  (2, 3500.00);
  ```
- **Order Items:**
  ```sql
  INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
  (1, 9, 1, 3500.00),
  (1, 10, 1, 2000.00),
  (2, 11, 1, 3500.00);
  ```

#### 7.3 Queries with JOINs
- **INNER JOIN between customers and orders:**
  ```sql
  SELECT
      customers.name,
      orders.total_value
  FROM customers
  INNER JOIN orders ON customers.id = orders.customer_id;
  ```
- **LEFT JOIN:**
  ```sql
  SELECT
      customers.name,
      orders.total_value
  FROM customers
  LEFT JOIN orders ON customers.id = orders.customer_id;
  ```
- **RIGHT JOIN:**
  ```sql
  SELECT
      customers.name,
      orders.total_value
  FROM customers
  RIGHT JOIN orders ON customers.id = orders.customer_id;
  ```
- **FULL JOIN (simulated with UNION):**
  ```sql
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
  ```

---

### 8. Aggregation Queries and Subqueries

#### 8.1 Basic Aggregations
- **Count of customers by city:**
  ```sql
  SELECT
      city,
      COUNT(*) AS customer_count
  FROM customers
  GROUP BY city;
  ```
- **Average sales per month:**
  ```sql
  SELECT
      TO_CHAR(order_date, 'YYYY-MM') AS month,
      AVG(total_value) AS avg_sales
  FROM orders
  GROUP BY month;
  ```
- **Other aggregation functions:**
  ```sql
  SELECT SUM(total_value)/COUNT(total_value) FROM orders;
  SELECT MAX(total_value) AS highest_order FROM orders;
  SELECT MIN(total_value) AS lowest_order FROM orders;
  ```

#### 8.2 Subqueries and Aggregation Filtering
- **Subquery: List products with stock below the average stock**
  ```sql
  SELECT
      name,
      stock
  FROM products
  WHERE stock < (SELECT AVG(stock) FROM products);
  ```
- **Aggregation with HAVING: List the city and total sales for selected cities**
  ```sql
  SELECT
      c.city,
      SUM(p.total_value) AS total_sales
  FROM customers AS c
  INNER JOIN orders AS p ON c.id = p.customer_id
  WHERE c.city IN ('São Paulo', 'Rio de Janeiro')
  GROUP BY c.city
  HAVING total_sales < 5000;
  ```

---

## Study Resources
- [Codigo Fonte TV Mini-Course](https://youtu.be/dpanYy8IrcU?si=3a1uI7wQWzXujFqC)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [SQLZoo](https://sqlzoo.net/)

## Next Steps 
- ***Study Relational Databases***

[↑ Index ↑](#index)
  