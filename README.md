```markdown
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
* **[MySQL Installation via Docker](#mysql-installation-via-docker)**
* **[Using mysql from the Command Line](#using-mysql-from-the-command-line)**
* **[DDL and DML Commands](#ddl-and-dml-commands)**
  * **[1. Creating and Altering Tables](#1-creating-and-altering-tables)**
  * **[2. Data Insertion (DML)](#2-data-insertion-dml)**
  * **[3. Data Queries](#3-data-queries)**
  * **[4. Creating a Derived Table](#4-creating-a-derived-table)**
  * **[5. Updating and Deleting Data](#5-updating-and-deleting-data)**
  * **[6. Advanced Queries](#6-advanced-queries)**
  * **[7. Working with Clients and Orders](#7-working-with-clients-and-orders)**
  * **[8. Aggregation Queries and Subqueries](#8-aggregation-queries-and-subqueries)**


## What is SQL and its Importance
- **SQL** (Structured Query Language) is a language for manipulating and processing data in relational databases, created by IBM and standardized by ANSI in 1986.
- Despite being 50 years old, it remains the standard language most used to interact with databases, and it is essential for full stack and backend developers.
- **SQL** is compatible with the major database systems in the market, such as MySQL, Oracle Database, PostgreSQL, SQL Server, SQLite, etc.

[↑ Index ↑](#index)

## The Four Main SQL Sublanguages
*SQL is generally divided into four main sublanguages:*

1. **DDL (Data Definition Language):**  
   Responsible for defining and modifying the structure of databases, such as creating, altering, or dropping tables and other objects (e.g., `CREATE`, `ALTER`, `DROP`, `TRUNCATE`).

2. **DML (Data Manipulation Language):**  
   Used to manipulate the actual data, allowing the insertion, updating, deletion, and querying of records (e.g., `INSERT`, `UPDATE`, `DELETE`, `SELECT`).  
   **DQL (Data Query Language):**  
   A subset of DML that is solely concerned with data querying, using the `SELECT` command.

3. **DCL (Data Control Language):**  
   Used to control access to data and permissions in the database (e.g., `GRANT`, `REVOKE`, `DENY`).

4. **TCL (Transaction Control Language):**  
   Manages transactions in the database, ensuring data integrity through commands that control the beginning, commitment, or rollback of transactions (e.g., `COMMIT`, `ROLLBACK`, `BEGIN TRANSACTION`).

*These divisions help organize the operations we can perform on a database, making data management and manipulation more structured and secure.*

[↑ Index ↑](#index)

## Essential Concepts
- **Primary Key:** Column(s) that uniquely identify each row in a table.
- **Foreign Key:** Column(s) that establish a relationship between two tables, ensuring referential integrity.
- **Index:** A structure that speeds up record lookup in a table.

## MySQL Installation via Docker
- Pull the **mysql** image: `$ docker pull mysql:latest`
- Create a data volume: `$ docker volume create learn-sql-data`
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
- Access the container: `$ docker exec -it learn-sql bash`
- Stop the container: `$ docker stop learn-sql`
- List containers: `$ docker ps -a`
- Start the container: `$ docker start learn-sql`
- Remove the container: `$ docker rm learn-sql`
- Remove the image: `$ docker rmi mysql:latest`
- Remove the volume: `$ docker volume rm learn-sql-data`

## Using mysql from the Command Line
- Access the container: `$ docker exec -it learn-sql bash`
- Access MySQL: `$ mysql -u root -p`
- **Commands:**
  - Create a database: `CREATE DATABASE learn_sql;`
  - Select a database: `USE learn_sql;`
  - List databases: `SHOW DATABASES;`

[↑ Index ↑](#index)

## DDL and DML Commands
*Commands to create, manipulate, and query data in a MySQL database.* 

>You can run the commands below on your MySQL instance, whether via the command line or using a graphical interface.

### 1. Creating and Altering Tables

#### 1.1 Creating the Table `marcas`
```sql
CREATE TABLE marcas (
	id INTEGER PRIMARY KEY AUTO_INCREMENT, -- Primary key
	nome VARCHAR(100) NOT NULL UNIQUE,     -- Data type with a character limit and unique constraint
	size VARCHAR(100),
	telefone VARCHAR(15)
); -- Semicolon to finish the query
```

#### 1.2 Creating the Table `produtos`
```sql
CREATE TABLE produtos (
	id INTEGER PRIMARY KEY AUTO_INCREMENT, -- Primary key
	nome VARCHAR(100) NOT NULL,             -- Data type and character limit
	preco REAL,                           -- Data type with decimals
	estoque INTEGER DEFAULT 0             -- Data type with a default value
); -- Semicolon to finish the query
```

#### 1.3 Altering the Table `produtos`
- **Add a column:**
  ```sql
  ALTER TABLE produtos ADD COLUMN id_marca INT NOT NULL;
  ```
- **Modify the data type of the `nome` column:**
  ```sql
  ALTER TABLE produtos MODIFY COLUMN nome VARCHAR(150);
  ```
- **Add a foreign key:**
  ```sql
  ALTER TABLE produtos ADD FOREIGN KEY (id_marca) REFERENCES marcas(id);
  ```

#### 1.4 Other Operations
- **Creating the Table `controle`:**
  ```sql
  CREATE TABLE controle (
	  id INTEGER PRIMARY KEY,
	  data_entrada DATE
  );
  ```
- **Dropping the Table `controle`:**
  ```sql
  DROP TABLE controle;
  -- Or safely:
  DROP TABLE IF EXISTS controle;
  ```
- **Creating an index on the `nome` column of the `produtos` table:**
  ```sql
  CREATE INDEX idx_produtos_nome ON produtos (nome);
  ```
- **Renaming the column `size` to `site` in the `marcas` table:**
  ```sql
  ALTER TABLE marcas CHANGE COLUMN size site VARCHAR(100);
  ```

---

## 2. Data Insertion (DML)

#### 2.1 Inserting Data into the `marcas` Table
```sql
INSERT INTO marcas (nome, site, telefone)
VALUES
	('Bose', 'http://bose.com', '(11) 99999-1111'),
	('JBL', 'http://jbl.com.br', '(11) 88888-2222');
```

#### 2.2 Inserting Data into the `produtos` Table
- **Insert without specifying the field list:**
  ```sql
  INSERT INTO produtos
  VALUES
	  (1, 'Produto 1', 10.5, 100, 1);
  ```
- **Insert while specifying the fields:**
  ```sql
  INSERT INTO produtos (nome, preco, estoque, id_marca)
  VALUES
	  ('Bose QuietComfort 45', 379.99, 40, 1),
	  ('Bose SoundSport', 299.99, 30, 1),
	  ('JBL Charge 5', 199.99, 50, 2),
	  ('JBL Flip 6', 219.99, 45, 2);
  ```

---

### 3. Data Queries

#### 3.1 Selecting Data from the `marcas` Table
- **Query all fields:**
  ```sql
  SELECT * FROM marcas;
  ```
- **Query specific fields:**
  ```sql
  SELECT id, nome FROM marcas;
  ```
- **Query with WHERE filter:**
  ```sql
  SELECT id, nome FROM marcas WHERE id = 1;
  SELECT id, nome FROM marcas WHERE id > 1;
  ```
- **Query with combined (AND) filter:**
  ```sql
  SELECT id, nome FROM marcas WHERE id > 1 AND id < 4;
  ```

---

### 4. Creating a Derived Table

#### 4.1 Creating the Table `produtos_apple`
```sql
CREATE TABLE produtos_apple (
	nome VARCHAR(150) NOT NULL,	
	estoque INTEGER DEFAULT 0
);
```
- **Insert data based on the `produtos` table:**
  ```sql
  INSERT INTO produtos_apple
  SELECT nome, estoque FROM produtos WHERE id_marca = 1;
  ```
- **View the data:**
  ```sql
  SELECT * FROM produtos_apple;
  ```
- **Clear and drop the table:**
  ```sql
  TRUNCATE TABLE produtos_apple;
  
  DROP TABLE produtos_apple;
  ```

---

### 5. Updating and Deleting Data

#### 5.1 Updating Data in the `produtos` Table
- **Update the name of a product:**
  ```sql
  UPDATE produtos
  SET nome = 'JBL Flip 6 Black'
  WHERE id = 12;
  ```
- **Update the stock of all products:**
  ```sql
  UPDATE produtos
  SET estoque = estoque + 10;
  ```
- **Update the stock of a specific product:**
  ```sql
  UPDATE produtos
  SET estoque = estoque + 1
  WHERE id = 3;
  ```

#### 5.2 Deleting Data
- **Delete a specific product by ID:**
  ```sql
  DELETE FROM produtos
  WHERE id = 1;
  ```

---

### 6. Advanced Queries

#### 6.1 Filtering and Ordering
- **Products with stock less than 100 and price greater than 30:**
  ```sql
  SELECT *
  FROM produtos
  WHERE 
	  estoque < 100
	  AND preco > 30;
  ```
- **Products with names containing "Flip":**
  ```sql
  SELECT *
  FROM produtos
  WHERE nome LIKE '%Flip%';
  ```
- **Products ordered by stock (ascending):**
  ```sql
  SELECT *
  FROM produtos
  ORDER BY estoque ASC;
  ```
- **Products ordered by stock (descending) limited to 2 records:**
  ```sql
  SELECT *
  FROM produtos
  ORDER BY estoque DESC
  LIMIT 2;
  ```

---

### 7. Working with Clients and Orders

#### 7.1 Creating the Tables `clientes`, `pedidos`, and `itens_pedido`
```sql
CREATE TABLE clientes (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	cidade VARCHAR(200),
	data_nascimento DATE
);

CREATE TABLE pedidos (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	data_pedido DATE DEFAULT (NOW()),
	id_cliente INT,
	valor_total REAL,
	FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

CREATE TABLE itens_pedido (
	id_pedido INT,
	id_produto INT,
	quantidade INT,
	preco_unitario REAL,
	FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
	FOREIGN KEY (id_produto) REFERENCES produtos(id),
	PRIMARY KEY (id_pedido, id_produto)
);
```

#### 7.2 Inserting Data
- **Clients:**
  ```sql
  INSERT INTO clientes (nome, email, cidade)
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
  INSERT INTO pedidos (id_cliente, valor_total) VALUES
  (1, 5500.00),
  (2, 3500.00);
  ```
- **Order Items:**
  ```sql
  INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
  (1, 9, 1, 3500.00),
  (1, 10, 1, 2000.00),
  (2, 11, 1, 3500.00);
  ```

#### 7.3 Queries with JOINs
- **INNER JOIN between clients and orders:**
  ```sql
  SELECT
	  clientes.nome,
	  pedidos.valor_total
  FROM clientes
  INNER JOIN pedidos ON clientes.id = pedidos.id_cliente;
  ```
- **LEFT JOIN:**
  ```sql
  SELECT
	  clientes.nome,
	  pedidos.valor_total
  FROM clientes
  LEFT JOIN pedidos ON clientes.id = pedidos.id_cliente;
  ```
- **RIGHT JOIN:**
  ```sql
  SELECT
	  clientes.nome,
	  pedidos.valor_total
  FROM clientes
  RIGHT JOIN pedidos ON clientes.id = pedidos.id_cliente;
  ```
- **FULL JOIN (simulated with UNION):**
  ```sql
  SELECT
	  clientes.nome,
	  pedidos.valor_total
  FROM clientes
  LEFT JOIN pedidos ON clientes.id = pedidos.id_cliente
  
  UNION
  
  SELECT
	  clientes.nome,
	  pedidos.valor_total
  FROM clientes
  RIGHT JOIN pedidos ON clientes.id = pedidos.id_cliente;
  ```

---

### 8. Aggregation Queries and Subqueries

#### 8.1 Basic Aggregations
- **Count of clients per city:**
  ```sql
  SELECT
	  cidade,
	  COUNT(*) AS numero_clientes
  FROM clientes
  GROUP BY cidade;
  ```
- **Average sales per month:**
  ```sql
  SELECT
	  DATE_FORMAT(data_pedido, '%Y-%m') AS mes,
	  AVG(valor_total) AS media_vendas
  FROM pedidos
  GROUP BY mes;
  ```
- **Other aggregation functions:**
  ```sql
  SELECT SUM(valor_total)/COUNT(valor_total) FROM pedidos;
  SELECT MAX(valor_total) AS maior_pedido FROM pedidos;
  SELECT MIN(valor_total) AS menor_pedido FROM pedidos;
  ```

#### 8.2 Subqueries and Aggregation Filtering
- **Query with a subquery for products with stock lower than average:**
  ```sql
  SELECT
	  nome,
	  estoque
  FROM produtos
  WHERE estoque < (SELECT AVG(estoque) FROM produtos);
  ```
- **Query with HAVING to filter aggregations:**
  ```sql
  SELECT
	  c.cidade,
	  SUM(p.valor_total) AS total_vendas
  FROM clientes AS c
  INNER JOIN pedidos AS p ON c.id = p.id_cliente
  WHERE c.cidade IN ('São Paulo', 'Rio de Janeiro')
  GROUP BY c.cidade
  HAVING total_vendas < 5000;
  ```

---

## Study Resources
- [Codigo Fonte TV Mini-Course](https://youtu.be/dpanYy8IrcU?si=3a1uI7wQWzXujFqC)
- > ***Study Relational Databases***

[↑ Index ↑](#index)