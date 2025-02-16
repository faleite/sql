-- DDL (Data Definition Language) - Linguagem de Definição de Dados
-- Criando tabelas
CREATE TABLE marcas (
	id INTEGER PRIMARY KEY AUTO_INCREMENT, -- Chave primária
	nome VARCHAR(100) NOT NULL UNIQUE, -- Tipo de dado com limite de caracteres e unico
	size VARCHAR(100),
	telefone VARCHAR(15)
); -- Ponto e vírgula para finalizar a query


CREATE TABLE produtos (
	id INTEGER PRIMARY KEY AUTO_INCREMENT, -- Chave primária
	nome VARCHAR(100) NOT NULL, -- Tipo de dado e limite de caracteres
	preco REAL, -- Tipo de dado com casas decimais
	estoque INTEGER DEFAULT 0 -- Tipo de dado com valor padrão
); -- Ponto e vírgula para finalizar a query

-- Adicionar uma coluna na tabela produtos
ALTER TABLE produtos ADD COLUMN id_marca INT NOT NULL; 

-- Modificar o tipo de dado da coluna nome da tabela produtos
ALTER TABLE produtos MODIFY COLUMN nome VARCHAR(150); 

-- Adicionar uma chave estrangeira na tabela produtos
ALTER TABLE produtos ADD FOREIGN KEY (id_marca) REFERENCES marcas(id); 


CREATE TABLE controle (
	id INTEGER PRIMARY KEY,
	data_entrada DATE
);

-- Removendo tabelas
DROP TABLE controle;
-- Ou
DROP TABLE IF EXISTS controle;

-- Cria um índice na coluna nome da tabela produtos
CREATE INDEX idx_produtos_nome ON produtos (nome); 

-- Modifica o nome da coluna size para site na tabela marcas
ALTER TABLE marcas CHANGE COLUMN size site VARCHAR(100); 

-- DML (Data Manipulation Language) - Linguagem de Manipulação de Dados
-- Inserindo dados na tabela marcas
INSERT INTO marcas
	(nome, site, telefone)
VALUES
	('Bose', 'http://bose.com', '(11) 99999-1111'),
	('JBL', 'http://jbl.com.br', '(11) 88888-2222');

-- Insert omitindo a lista de campos
INSERT INTO produtos
VALUES
	(1, 'Produto 1', 10.5, 100, 1);

INSERT INTO produtos 
	(nome, preco, estoque, id_marca)
VALUES
	('Bose QuietComfort 45', 379.99, 40, 1),
	('Bose SoundSport', 299.99, 30, 1),
	('JBL Charge 5', 199.99, 50, 2),
	('JBL Flip 6', 219.99, 45, 2);

-- Consulta de dados

-- Consulta de todos os campos da tabela marcas ("*" significa todos)
SELECT * FROM marcas;

-- Consulta de campos específicos da tabela marcas
SELECT id, nome FROM marcas;

-- Consulta com filtro WHERE
SELECT id, nome FROM marcas WHERE id = 1;
SELECT id, nome FROM marcas WHERE id > 1;

-- Consulta com filtro AND
SELECT id, nome FROM marcas WHERE id > 1 AND id < 4;

CREATE TABLE produtos_apple (
	nome VARCHAR(150) NOT NULL,	
	estoque INTEGER DEFAULT 0
)

INSERT INTO produtos_apple
SELECT nome, estoque FROM produtos WHERE id_marca = 1;

SELECT * FROM produtos_apple;

-- Deleta todos os registros da tabela
TRUNCATE TABLE produtos_apple;

-- Deleta a tabela
DROP TABLE produtos_apple;

-- O ideal é criar uma clausula com SELECT para verificar os dados antes de deletar
UPDATE produtos
SET nome = 'JBL Flip 6 Black'
WHERE id = 12;

-- Atualiza o estoque de todos os produtos
UPDATE produtos
SET estoque = estoque + 10

-- Atualiza o estoque de um produto específico pelo ID
UPDATE produtos
SET estoque = estoque + 1
WHERE id = 3;

-- Deleta um produto pelo ID
DELETE FROM produtos
WHERE id = 1

-- Mostra os produtos com estoque menor que 100 e preço maior que 30
SELECT *
FROM produtos
WHERE 
	estoque < 100 -- <, >, <=, >=, =, <> (diferente)
	AND preco > 30; -- AND, OR

-- Mostra os produtos com nome que contém "tua"
SELECT *
FROM produtos
WHERE 
	nome LIKE '%Flip%'; -- LIKE, NOT LIKE, % (qualquer coisa), _ (qualquer caractere)

-- Mostra os produtos em ordem crescente de estoque
SELECT *
FROM produtos
ORDER BY estoque ASC; -- ASC, DESC

-- Mostra os produtos em ordem decrescente de estoque e limita a 2 registros
SELECT *
FROM produtos
ORDER BY estoque DESC
LIMIT 2; -- LIMIT, OFFSET

-- CLIENTES
CREATE TABLE clientes (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	cidade VARCHAR(200),
	data_nascimento DATE
);

-- PEDIDOS
CREATE TABLE pedidos (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	data_pedido DATE DEFAULT (NOW()),
	id_cliente INT,
	valor_total REAL,
	FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

-- ITENS DO PEDIDO
CREATE TABLE itens_pedido (
	id_pedido INT,
	id_produto INT,
	quantidade INT,
	preco_unitario REAL,
	FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
	FOREIGN KEY (id_produto) REFERENCES produtos(id),
	PRIMARY KEY (id_pedido, id_produto)
);

-- INSERINDO DADOS
-- clientes
INSERT INTO clientes
    (nome, email, cidade)
VALUES
    ('Carlos Silva', 'carlos.silva@example.com', 'São Paulo'),
    ('Mariana Costa', 'mariana.costa@example.com', 'Rio de Janeiro'),
    ('João Almeida', 'joao.almeida@example.com', 'Belo Horizonte'),
    ('Fernanda Souza', 'fernanda.souza@example.com', 'Curitiba'),
    ('Rafael Martins', 'rafael.martins@example.com', 'Fortaleza'),
	('Maria Oliveira', 'maria@examplecom', 'São Paulo'),
	('José Santos', 'josé@example.com', 'Rio de Janeiro');

-- pedidos
INSERT INTO pedidos (id_cliente, valor_total) VALUES
(1, 5500.00),
(2, 3500.00);

-- itens_pedido
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 9, 1, 3500.00),
(1, 10, 1, 2000.00),
(2, 11, 1, 3500.00); 

SELECT -- Para listar o nome do cliente e o valor total do pedido
	clientes.nome,
	pedidos.valor_total
FROM -- Para juntar as tabelas clientes e pedidos
	clientes
	INNER JOIN pedidos ON clientes.id = pedidos.id_cliente;

-- SUBQUERY
-- Para listar o nome do produto e o preço dos produtos da marca JBL ou Bose
SELECT
	nome, preco
FROM
	produtos
WHERE
	id_marca IN (
		SELECT id
		FROM marcas
		WHERE nome = 'JBL'
		OR nome = 'Bose'
	);

SELECT -- Para listar o nome do cliente e o valor total do pedido
	clientes.nome,
	pedidos.valor_total
FROM -- Para juntar as tabelas clientes e pedidos
	clientes
	LEFT JOIN pedidos ON clientes.id = pedidos.id_cliente;


SELECT -- Para listar o nome do cliente e o valor total do pedido
	clientes.nome,
	pedidos.valor_total
FROM -- Para juntar as tabelas clientes e pedidos
	clientes
	RIGHT JOIN pedidos ON clientes.id = pedidos.id_cliente;

-- FULL JOIN
-- No mysql não existe FULL JOIN, mas podemos simular com UNION
SELECT -- Para listar o nome do cliente e o valor total do pedido
	clientes.nome,
	pedidos.valor_total
FROM -- Para juntar as tabelas clientes e pedidos
	clientes
	LEFT JOIN pedidos ON clientes.id = pedidos.id_cliente

UNION

SELECT -- Para listar o nome do cliente e o valor total do pedido
	clientes.nome,
	pedidos.valor_total
FROM -- Para juntar as tabelas clientes e pedidos
	clientes
	RIGHT JOIN pedidos ON clientes.id = pedidos.id_cliente;

SELECT
	cidade,
	COUNT(*) AS numero_clientes -- Cria um campo com o total de clientes para cada cidade
FROM
	clientes
GROUP BY cidade;

SELECT
	DATE_FORMAT(data_pedido, '%Y-%m') AS mes,
	AVG(valor_total) AS media_vendas
FROM
	pedidos
GROUP BY mes;

SELECT sum(valor_total)/COUNT(valor_total) FROM pedidos;

SELECT MAX(valor_total) AS maior_pedido FROM pedidos;

SELECT MIN(valor_total) AS menor_pedido FROM pedidos;

SELECT
	nome,
	estoque
FROM
	produtos
WHERE
	estoque < (SELECT AVG(estoque) FROM produtos);

SELECT
	c.cidade,
	SUM(p.valor_total) AS total_vendas
FROM
	clientes AS c
	INNER JOIN pedidos AS p ON c.id = p.id_cliente
WHERE
	c.cidade IN ('São Paulo', 'Rio de Janeiro')
GROUP BY c.cidade
HAVING total_vendas < 5000; -- HAVING é utilizado para filtrar resultados de funções agregadas