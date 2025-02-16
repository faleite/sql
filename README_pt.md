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
* **[Instalação do MySQL via Docker](#instalação-do-mysql-via-docker)**
* **[Uso do mysql na linha de comando](#uso-do-mysql-na-linha-de-comando)**
* **[Comandos DDL e DML](#comandos-ddl-e-dml)**
  * **[1. Criação e Alteração de Tabelas](#1-criação-e-alteração-de-tabelas)**
  * **[2. Inserção de Dados (DML)](#2-inserção-de-dados-dml)**
  * **[3. Consultas de Dados](#3-consultas-de-dados)**
  * **[4. Criação de Tabela Derivada](#4-criação-de-tabela-derivada)**
  * **[5. Atualização e Exclusão de Dados](#5-atualização-e-exclusão-de-dados)**
  * **[6. Consultas Avançadas](#6-consultas-avançadas)**
  * **[7. Trabalhando com Clientes e Pedidos](#7-trabalhando-com-clientes-e-pedidos)**
  * **[8. Consultas com Agregação e Subqueries](#8-consultas-com-agregação-e-subqueries)**


## O que é SQL e sua importância
- **SQL** (Structured Query Language) é uma linguagem para manipulação e processamento de dados em bancos de dados relacionais, criada pela IBM e padronizada pela ANSI em 1986.
- Apesar dos seus 50 anos, ainda é a linguagem padrão e mais utilizada para interagir com bancos de dados, sendo fundamental para desenvolvedores full stack e backend.
- **SQL** é compatível com os principais bancos de dados do mercado, como MySQL, Oracle Database, PostgreSQL, SQL Server, SQLite, etc.

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
- Acessar o container: `$ docker exec -it learn-sql bash`
- Parar o container: `$ docker stop learn-sql`
- Verificar os containers: `$ docker ps -a`
- Iniciar o container: `$ docker start learn-sql`
- Remover o container: `$ docker rm learn-sql`
- Remover a imagem: `$ docker rmi mysql:latest`
- Remover o volume: `$ docker volume rm learn-sql-data`

## Uso do mysql na linha de comando
- Acessar o container: `$ docker exec -it learn-sql bash`
- Acessar o MySQL: `$ mysql -u root -p`
- **Comandos:**
  - Criar um banco de dados: `CREATE DATABASE learn_sql;`
  - Selecionar um banco de dados: `USE learn_sql;`
  - Listar os bancos de dados: `SHOW DATABASES;`

[↑ Index ↑](#index)

## Comandos DDL e DML
*Comandos para criar, manipular e consultar dados em um banco de dados MySQL.* 

>Você pode executar os comandos abaixo na sua instância do MySQL, \
>seja via linha de comando ou utilizando uma interface gráfica.

### 1. Criação e Alteração de Tabelas

#### 1.1 Criação da Tabela `marcas`
```sql
CREATE TABLE marcas (
	id INTEGER PRIMARY KEY AUTO_INCREMENT, -- Chave primária
	nome VARCHAR(100) NOT NULL UNIQUE,     -- Tipo de dado com limite de caracteres e único
	size VARCHAR(100),
	telefone VARCHAR(15)
); -- Ponto e vírgula para finalizar a query
```

#### 1.2 Criação da Tabela `produtos`
```sql
CREATE TABLE produtos (
	id INTEGER PRIMARY KEY AUTO_INCREMENT, -- Chave primária
	nome VARCHAR(100) NOT NULL,             -- Tipo de dado e limite de caracteres
	preco REAL,                           -- Tipo de dado com casas decimais
	estoque INTEGER DEFAULT 0             -- Tipo de dado com valor padrão
); -- Ponto e vírgula para finalizar a query
```

#### 1.3 Alterações na Tabela `produtos`
- **Adicionar uma coluna:**
  ```sql
  ALTER TABLE produtos ADD COLUMN id_marca INT NOT NULL;
  ```
- **Modificar o tipo de dado da coluna `nome`:**
  ```sql
  ALTER TABLE produtos MODIFY COLUMN nome VARCHAR(150);
  ```
- **Adicionar uma chave estrangeira:**
  ```sql
  ALTER TABLE produtos ADD FOREIGN KEY (id_marca) REFERENCES marcas(id);
  ```

#### 1.4 Outras Operações
- **Criação da Tabela `controle`:**
  ```sql
  CREATE TABLE controle (
	  id INTEGER PRIMARY KEY,
	  data_entrada DATE
  );
  ```
- **Remover a Tabela `controle`:**
  ```sql
  DROP TABLE controle;
  -- Ou de forma segura:
  DROP TABLE IF EXISTS controle;
  ```
- **Criação de um índice na tabela `produtos`:**
  ```sql
  CREATE INDEX idx_produtos_nome ON produtos (nome);
  ```
- **Modificar o nome da coluna `size` para `site` na tabela `marcas`:**
  ```sql
  ALTER TABLE marcas CHANGE COLUMN size site VARCHAR(100);
  ```

---

## 2. Inserção de Dados (DML)

#### 2.1 Inserindo Dados na Tabela `marcas`
```sql
INSERT INTO marcas (nome, site, telefone)
VALUES
	('Bose', 'http://bose.com', '(11) 99999-1111'),
	('JBL', 'http://jbl.com.br', '(11) 88888-2222');
```

#### 2.2 Inserindo Dados na Tabela `produtos`
- **Inserir omitindo a lista de campos:**
  ```sql
  INSERT INTO produtos
  VALUES
	  (1, 'Produto 1', 10.5, 100, 1);
  ```
- **Inserir especificando os campos:**
  ```sql
  INSERT INTO produtos (nome, preco, estoque, id_marca)
  VALUES
	  ('Bose QuietComfort 45', 379.99, 40, 1),
	  ('Bose SoundSport', 299.99, 30, 1),
	  ('JBL Charge 5', 199.99, 50, 2),
	  ('JBL Flip 6', 219.99, 45, 2);
  ```

---

### 3. Consultas de Dados

#### 3.1 Seleção de Dados na Tabela `marcas`
- **Consulta de todos os campos:**
  ```sql
  SELECT * FROM marcas;
  ```
- **Consulta de campos específicos:**
  ```sql
  SELECT id, nome FROM marcas;
  ```
- **Consulta com filtro WHERE:**
  ```sql
  SELECT id, nome FROM marcas WHERE id = 1;
  SELECT id, nome FROM marcas WHERE id > 1;
  ```
- **Consulta com filtro combinado (AND):**
  ```sql
  SELECT id, nome FROM marcas WHERE id > 1 AND id < 4;
  ```

---

### 4. Criação de Tabela Derivada

#### 4.1 Criação da Tabela `produtos_apple`
```sql
CREATE TABLE produtos_apple (
	nome VARCHAR(150) NOT NULL,	
	estoque INTEGER DEFAULT 0
);
```
- **Inserir dados baseados na tabela `produtos`:**
  ```sql
  INSERT INTO produtos_apple
  SELECT nome, estoque FROM produtos WHERE id_marca = 1;
  ```
- **Visualizar os dados:**
  ```sql
  SELECT * FROM produtos_apple;
  ```
- **Limpar e remover a tabela:**
  ```sql
  TRUNCATE TABLE produtos_apple;
  
  DROP TABLE produtos_apple;
  ```

---

### 5. Atualização e Exclusão de Dados

#### 5.1 Atualização de Dados na Tabela `produtos`
- **Atualização do nome de um produto:**
  ```sql
  UPDATE produtos
  SET nome = 'JBL Flip 6 Black'
  WHERE id = 12;
  ```
- **Atualização do estoque de todos os produtos:**
  ```sql
  UPDATE produtos
  SET estoque = estoque + 10;
  ```
- **Atualização do estoque de um produto específico:**
  ```sql
  UPDATE produtos
  SET estoque = estoque + 1
  WHERE id = 3;
  ```

#### 5.2 Exclusão de Dados
- **Exclusão de um produto específico pelo ID:**
  ```sql
  DELETE FROM produtos
  WHERE id = 1;
  ```

---

### 6. Consultas Avançadas

#### 6.1 Filtros e Ordenação
- **Produtos com estoque menor que 100 e preço maior que 30:**
  ```sql
  SELECT *
  FROM produtos
  WHERE 
	  estoque < 100
	  AND preco > 30;
  ```
- **Produtos com nome contendo "Flip":**
  ```sql
  SELECT *
  FROM produtos
  WHERE nome LIKE '%Flip%';
  ```
- **Produtos ordenados por estoque (crescente):**
  ```sql
  SELECT *
  FROM produtos
  ORDER BY estoque ASC;
  ```
- **Produtos ordenados por estoque (decrescente) limitando a 2 registros:**
  ```sql
  SELECT *
  FROM produtos
  ORDER BY estoque DESC
  LIMIT 2;
  ```

---

### 7. Trabalhando com Clientes e Pedidos

#### 7.1 Criação das Tabelas `clientes`, `pedidos` e `itens_pedido`
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

#### 7.2 Inserção de Dados
- **Clientes:**
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
- **Pedidos:**
  ```sql
  INSERT INTO pedidos (id_cliente, valor_total) VALUES
  (1, 5500.00),
  (2, 3500.00);
  ```
- **Itens do Pedido:**
  ```sql
  INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
  (1, 9, 1, 3500.00),
  (1, 10, 1, 2000.00),
  (2, 11, 1, 3500.00);
  ```

#### 7.3 Consultas com JOINs
- **INNER JOIN entre clientes e pedidos:**
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
- **FULL JOIN (simulado com UNION):**
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

### 8. Consultas com Agregação e Subqueries

#### 8.1 Agregações Básicas
- **Contagem de clientes por cidade:**
  ```sql
  SELECT
	  cidade,
	  COUNT(*) AS numero_clientes
  FROM clientes
  GROUP BY cidade;
  ```
- **Média de vendas por mês:**
  ```sql
  SELECT
	  DATE_FORMAT(data_pedido, '%Y-%m') AS mes,
	  AVG(valor_total) AS media_vendas
  FROM pedidos
  GROUP BY mes;
  ```
- **Outras funções de agregação:**
  ```sql
  SELECT SUM(valor_total)/COUNT(valor_total) FROM pedidos;
  SELECT MAX(valor_total) AS maior_pedido FROM pedidos;
  SELECT MIN(valor_total) AS menor_pedido FROM pedidos;
  ```

#### 8.2 Subquery e Filtragem na Agregação
- **Consulta com subquery para produtos com estoque menor que a média:**
  ```sql
  SELECT
	  nome,
	  estoque
  FROM produtos
  WHERE estoque < (SELECT AVG(estoque) FROM produtos);
  ```
- **Consulta com HAVING para filtrar agregações:**
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

## Study resources
- [Minicurso Codigo Fonte TV](https://youtu.be/dpanYy8IrcU?si=3a1uI7wQWzXujFqC)
- > ***Estudar Banco de Dados relacionais***

[↑ Index ↑](#index)