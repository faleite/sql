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
* **[O que é SQL e sua importância](#o-que-é-sql-e-sua-importância)**
* **[As quatro sub-linguagens principais do SQL](#as-quatro-sub-linguagens-principais-do-sql)** 
* **[Conceitos Essenciais](#conceitos-essenciais)**
* **[Instalação do PostgreSQL via Docker](#instalação-do-postgresql-via-docker)**
* **[Instalação do MySQL via Docker](#instalação-do-mysql-via-docker)**
* **[Uso do mysql na linha de comando](#uso-do-mysql-na-linha-de-comando)**
* **[Comandos DDL e DML](#comandos-ddl-e-dml)**
  * **[1. Criação e Alteração de Tabelas](#1-criação-e-alteração-de-tabelas)**
  * **[2. Inserção de Dados (DML)](#2-inserção-de-dados-dml)**
  * **[3. Consultas de Dados](#3-consultas-de-dados)**
  * **[4. Criação de Tabela Derivada](#4-criação-de-tabela-derivada)**
  * **[5. Atualização e Exclusão de Dados](#5-atualização-e-exclusão-de-dados)**
  * **[6. Consultas Avançadas](#6-consultas-avançadas)**
  * **[7. Trabalhando com clientes e Pedidos](#7-trabalhando-com-clientes-e-pedidos)**
  * **[8. Consultas com Agregação e Subqueries](#8-consultas-com-agregação-e-subqueries)**


## O que é SQL e sua importância
- **SQL** (Structured Query Language) é uma linguagem para manipulação e processamento de dados em bancos de dados relacionais, criada pela IBM e padronizada pela ANSI em 1986.
- Apesar dos seus 50 anos, ainda é a linguagem padrão e mais utilizada para interagir com bancos de dados, sendo fundamental para desenvolvedores full stack e backend.
- **SQL** é compatível com os principais bancos de dados do mercado, como MySQL, Oracle Database, PostgreSQL, SQL Server, SQLite, etc.
- **SQL** é uma linguagem declarativa, ou seja, o programador especifica o que deseja obter, e não como obter, deixando a otimização e execução a cargo do SGBD.
- **SGBD** significa "Sistema de Gerenciamento de Banco de Dados". É o software responsável por gerenciar, armazenar, recuperar e administrar os dados em um banco de dados, garantindo integridade, segurança e performance nas operações realizadas.

[↑ Index ↑](#index)

## As quatro sub-linguagens principais do SQL
*O SQL é geralmente dividido em quatro sub-linguagens principais:*

1. **DDL (Data Definition Language):**  
   Responsável por definir e modificar a estrutura dos bancos de dados, como criar, alterar ou remover tabelas e outros objetos (ex: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`).

2. **DML (Data Manipulation Language):**  
   Utilizada para manipular os dados propriamente ditos, permitindo inserir, atualizar, excluir e consultar os registros (ex: `INSERT`, `UPDATE`, `DELETE`, `SELECT`).
   **DQL (Data Query Language):**  
	Subconjunto da DML que se refere apenas à consulta de dados, através do comando `SELECT`.

3. **DCL (Data Control Language):**  
   Utilizada para controlar o acesso aos dados e permissões no banco de dados (ex: `GRANT`, `REVOKE`, `DENY`).

4. **TCL (Transaction Control Language):**  
   Gerencia as transações no banco de dados, garantindo a integridade dos dados através de comandos que controlam o início, confirmação ou cancelamento de transações (ex: `COMMIT`, `ROLLBACK`, `BEGIN TRANSACTION`).

*Essas divisões ajudam a organizar as operações que podemos realizar sobre um banco de dados, tornando o gerenciamento e manipulação de dados mais estruturados e seguros.*

[↑ Index ↑](#index)

## Conceitos Essenciais
- **Chave Primária (Primary Key):** Coluna(s) que identificam exclusivamente cada linha em uma tabela.
- **Chave Estrangeira (Foreign Key):** Coluna(s) que estabelecem uma relação entre duas tabelas, garantindo a integridade referencial.
- **Índice (Index):** Estrutura que acelera a busca de registros em uma tabela.

## Instalação do PostgreSQL via Docker
- Baixar imagem **postgres**: `$ docker pull postgres:latest`
- Criar volume de dados: `$ docker volume create learn-sql-data`
- Criar container / Executar container:
```bash
$ docker run -d \
  --name learn-sql \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=sql \
  -p 5432:5432 \
  -v learn-sql-data:/var/lib/postgresql/data \
  postgres:latest
```

## Uso do postgres na linha de comando
- Acessar o container: `$ docker exec -it learn-sql bash`
- Acessar o PostgreSQL: `$ psql -U postgres`
- Listar os bancos de dados: `\l`
- Criar um banco de dados: `CREATE DATABASE learn_sql;`
- Selecionar um banco de dados: `\c learn_sql;`
- Listar as tabelas: `\dt`
- Sair do PostgreSQL: `\q`
- **Comandos Docker:**
  - Parar o container: `$ docker stop learn-sql`
  - Iniciar o container: `$ docker start learn-sql`
  - Verificar os containers: `$ docker ps -a`
  - Remover o container: `$ docker rm learn-sql`
  - Remover a imagem: `$ docker rmi postgres:latest`
  - Remover o volume: `$ docker volume rm learn-sql-data`

## Instalação do MySQL via Docker
- Baixar imagem **mysql**: `$ docker pull mysql:latest`
- Criar volume de dados: `$ docker volume create learn-sql-data`
- Criar container / Executar container:
```bash
$ docker run -d \
  --name learn-sql \
  -e MYSQL_ROOT_PASSWORD=sql \
  -p 3306:3306 \
  -v learn-sql-data:/var/lib/mysql \
  mysql:latest
```
- **Explicação:**
  - `$ docker run -d` --> *modo detached (em segundo plano)*
  - `--name learn-sql` --> *nome do container*
  - `-e MYSQL_ROOT_PASSWORD=sql` --> *variável de ambiente*
  - `-p 3306:3306` --> *porta do container*
  - `-v learn-sql-data:/var/lib/mysql` --> *volume de dados*
  - `mysql:latest` --> *imagem*

## Uso do mysql na linha de comando
- Acessar o container: `$ docker exec -it learn-sql bash`
- Acessar o MySQL: `$ mysql -u root -p`
- **Comandos:**
  - Criar um banco de dados: `CREATE DATABASE learn_sql;`
  - Selecionar um banco de dados: `USE learn_sql;`
  - Listar os bancos de dados: `SHOW DATABASES;`

[↑ Index ↑](#index)

## Comandos DDL e DML
*Comandos para criar, manipular e consultar dados em um banco de dados PostgresSQL.* 

>Você pode executar os comandos abaixo na sua instância do PostgresSQL, \
>seja via linha de comando ou utilizando uma interface gráfica.

### 1. Criação e Alteração de Tabelas

#### 1.1 Criação da Tabela `brands`
```sql
CREATE TABLE brands (
	id SERIAL PRIMARY KEY, -- Chave primária
	name VARCHAR(100) NOT NULL UNIQUE,     -- Tipo de dado com limite de caracteres e único
	size VARCHAR(100),
	phone VARCHAR(15)
); -- Ponto e vírgula para finalizar a query
```

#### 1.2 Criação da Tabela `products`
```sql
CREATE TABLE products (
	id SERIAL PRIMARY KEY, -- Chave primária
	name VARCHAR(100) NOT NULL,             -- Tipo de dado e limite de caracteres
	price REAL,                           -- Tipo de dado com casas decimais
	stock INTEGER DEFAULT 0             -- Tipo de dado com valor padrão
); -- Ponto e vírgula para finalizar a query
```

#### 1.3 Alterações na Tabela `products`
- **Adicionar uma coluna:**
  ```sql
  ALTER TABLE products ADD COLUMN brand_id INT NOT NULL;
  ```
- **Modificar o tipo de dado da coluna `name`:**
  ```sql
  ALTER TABLE products ALTER COLUMN name TYPE VARCHAR(150);
  ```
- **Adicionar uma chave estrangeira:**
  ```sql
  ALTER TABLE products ADD FOREIGN KEY (brand_id) REFERENCES brands(id);
  ```

#### 1.4 Outras Operações
- **Criação da Tabela `control`:**
  ```sql
  CREATE TABLE control (
	  id INTEGER PRIMARY KEY,
	  entry_date DATE
  );
  ```
- **Remover a Tabela `control`:**
  ```sql
  DROP TABLE control;
  -- Ou de forma segura:
  DROP TABLE IF EXISTS control;
  ```
- **Criação de um índice na tabela `products`:**
  ```sql
  CREATE INDEX idx_products_name ON products (name);
  ```
- **Modificar o name da coluna `size` para `site` na tabela `brands`:**
  ```sql
  ALTER TABLE brands RENAME COLUMN size TO site;
  ```

---

## 2. Inserção de Dados (DML)

#### 2.1 Inserindo Dados na Tabela `brands`
```sql
INSERT INTO brands (name, site, phone)
VALUES
	('Bose', 'http://bose.com', '(11) 99999-1111'),
	('JBL', 'http://jbl.com.br', '(11) 88888-2222');
```

#### 2.2 Inserindo Dados na Tabela `products`
- **Inserir omitindo a lista de campos:**
  ```sql
  INSERT INTO products
  VALUES
	  (1, 'Produto 1', 10.5, 100, 1);
  ```
- **Inserir especificando os campos:**
  ```sql
  INSERT INTO products (name, price, stock, brand_id)
  VALUES
	  ('Bose QuietComfort 45', 379.99, 40, 1),
	  ('Bose SoundSport', 299.99, 30, 1),
	  ('JBL Charge 5', 199.99, 50, 2),
	  ('JBL Flip 6', 219.99, 45, 2);
  ```

---

### 3. Consultas de Dados

#### 3.1 Seleção de Dados na Tabela `brands`
- **Consulta de todos os campos:**
  ```sql
  SELECT * FROM brands;
  ```
- **Consulta de campos específicos:**
  ```sql
  SELECT id, name FROM brands;
  ```
- **Consulta com filtro WHERE:**
  ```sql
  SELECT id, name FROM brands WHERE id = 1;
  SELECT id, name FROM brands WHERE id > 1;
  ```
- **Consulta com filtro combinado (AND):**
  ```sql
  SELECT id, name FROM brands WHERE id > 1 AND id < 4;
  ```

---

### 4. Criação de Tabela Derivada

#### 4.1 Criação da Tabela `products_apple`
```sql
CREATE TABLE products_apple (
	name VARCHAR(150) NOT NULL,	
	stock INTEGER DEFAULT 0
);
```
- **Inserir dados baseados na tabela `products`:**
  ```sql
  INSERT INTO products_apple
  SELECT name, stock FROM products WHERE brand_id = 1;
  ```
- **Visualizar os dados:**
  ```sql
  SELECT * FROM products_apple;
  ```
- **Limpar e remover a tabela:**
  ```sql
  TRUNCATE TABLE products_apple;
  
  DROP TABLE products_apple;
  ```

---

### 5. Atualização e Exclusão de Dados

#### 5.1 Atualização de Dados na Tabela `products`
- **Atualização do name de um produto:**
  ```sql
  UPDATE products
  SET name = 'JBL Flip 6 Black'
  WHERE id = 12;
  ```
- **Atualização do stock de todos os products:**
  ```sql
  UPDATE products
  SET stock = stock + 10;
  ```
- **Atualização do stock de um produto específico:**
  ```sql
  UPDATE products
  SET stock = stock + 1
  WHERE id = 3;
  ```

#### 5.2 Exclusão de Dados
- **Exclusão de um produto específico pelo ID:**
  ```sql
  DELETE FROM products
  WHERE id = 1;
  ```

---

### 6. Consultas Avançadas

#### 6.1 Filtros e Ordenação
- **products com stock menor que 100 e preço maior que 30:**
  ```sql
  SELECT *
  FROM products
  WHERE 
	  stock < 100
	  AND price > 30;
  ```
- **products com name contendo "Flip":**
  ```sql
  SELECT *
  FROM products
  WHERE name LIKE '%Flip%';
  ```
- **products ordenados por stock (crescente):**
  ```sql
  SELECT *
  FROM products
  ORDER BY stock ASC;
  ```
- **products ordenados por stock (decrescente) limitando a 2 registros:**
  ```sql
  SELECT *
  FROM products
  ORDER BY stock DESC
  LIMIT 2;
  ```

---

### 7. Trabalhando com Clientes e Pedidos

#### 7.1 Criação das Tabelas `customers`, `orders` e `order_items`
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

#### 7.2 Inserção de Dados
- **customers:**
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
- **orders:**
  ```sql
  INSERT INTO orders (customer_id, total_value) VALUES
  (1, 5500.00),
  (2, 3500.00);
  ```
- **Itens do Pedido:**
  ```sql
  INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
  (1, 9, 1, 3500.00),
  (1, 10, 1, 2000.00),
  (2, 11, 1, 3500.00);
  ```

#### 7.3 Consultas com JOINs
- **INNER JOIN entre customers e orders:**
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
- **FULL JOIN (simulado com UNION):**
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

### 8. Consultas com Agregação e Subqueries

#### 8.1 Agregações Básicas
- **Contagem de customers por city:**
  ```sql
  SELECT
	  city,
	  COUNT(*) AS customer_count
  FROM customers
  GROUP BY city;
  ```
- **Média de vendas por mês:**
  ```sql
  SELECT
	  TO_CHAR(order_date, 'YYYY-MM') AS month,
	  AVG(total_value) AS avg_sales
  FROM orders
  GROUP BY month;
  ```
- **Outras funções de agregação:**
  ```sql
  SELECT SUM(total_value)/COUNT(total_value) FROM orders;
  SELECT MAX(total_value) AS highest_order FROM orders;
  SELECT MIN(total_value) AS lowest_order FROM orders;
  ```

#### 8.2 Subquery e Filtragem na Agregação
- **Consulta com subquery para products com stock menor que a média:**
  ```sql
  SELECT
	  name,
	  stock
  FROM products
  WHERE stock < (SELECT AVG(stock) FROM products);
  ```
- **Consulta com HAVING para filtrar agregações:**
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

## Study resources
- [Minicurso Codigo Fonte TV](https://youtu.be/dpanYy8IrcU?si=3a1uI7wQWzXujFqC)

## Next steps
- ***Estudar Banco de Dados relacionais***

[↑ Index ↑](#index)