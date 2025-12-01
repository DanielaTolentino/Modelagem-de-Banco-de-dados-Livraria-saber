-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: livraria_saber
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- ----------------------------------------------------------------------
-- DDL - CRIAÇÃO DE ESTRUTURA E TABELAS
-- ----------------------------------------------------------------------

-- Drop Tables Existentes (Se existirem)
DROP TABLE IF EXISTS `item_venda`;
DROP TABLE IF EXISTS `livro_autor`;
DROP TABLE IF EXISTS `venda`;
DROP TABLE IF EXISTS `livro`;
DROP TABLE IF EXISTS `papelaria`;
DROP TABLE IF EXISTS `vendedor`;
DROP TABLE IF EXISTS `cliente`;
DROP TABLE IF EXISTS `editora`;
DROP TABLE IF EXISTS `fornecedor`;
DROP TABLE IF EXISTS `autor`;

--
-- Table structure for table `autor`
--

CREATE TABLE `autor` (
  `id_autor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `nacionalidade` varchar(50) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `endereco` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `editora`
--

CREATE TABLE `editora` (
  `id_editora` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cnpj` varchar(18) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `contato` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_editora`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `fornecedor`
--

CREATE TABLE `fornecedor` (
  `id_fornecedor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cnpj` varchar(18) NOT NULL,
  `contato` varchar(100) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_fornecedor`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `livro`
--

CREATE TABLE `livro` (
  `id_livro` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `isbn` varchar(17) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `quantidade_estoque` int NOT NULL,
  `id_editora` int NOT NULL,
  PRIMARY KEY (`id_livro`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `id_editora` (`id_editora`),
  CONSTRAINT `livro_ibfk_1` FOREIGN KEY (`id_editora`) REFERENCES `editora` (`id_editora`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `livro_autor`
--

CREATE TABLE `livro_autor` (
  `id_livro` int NOT NULL,
  `id_autor` int NOT NULL,
  PRIMARY KEY (`id_livro`,`id_autor`),
  KEY `id_autor` (`id_autor`),
  CONSTRAINT `livro_autor_ibfk_1` FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id_livro`) ON DELETE CASCADE,
  CONSTRAINT `livro_autor_ibfk_2` FOREIGN KEY (`id_autor`) REFERENCES `autor` (`id_autor`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `papelaria`
--

CREATE TABLE `papelaria` (
  `id_papelaria` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `quantidade_estoque` int NOT NULL,
  `id_fornecedor` int NOT NULL,
  PRIMARY KEY (`id_papelaria`),
  KEY `id_fornecedor` (`id_fornecedor`),
  CONSTRAINT `papelaria_ibfk_1` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `vendedor`
--

CREATE TABLE `vendedor` (
  `id_vendedor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cargo` varchar(50) NOT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `comissao` decimal(5,2) DEFAULT '0.00',
  PRIMARY KEY (`id_vendedor`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `venda`
--

CREATE TABLE `venda` (
  `id_venda` int NOT NULL AUTO_INCREMENT,
  `data_venda` datetime NOT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  `forma_pagamento` varchar(50) DEFAULT NULL,
  `id_cliente` int NOT NULL,
  `id_vendedor` int NOT NULL,
  PRIMARY KEY (`id_venda`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_vendedor` (`id_vendedor`),
  CONSTRAINT `venda_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE RESTRICT,
  CONSTRAINT `venda_ibfk_2` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedor` (`id_vendedor`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Table structure for table `item_venda`
--

CREATE TABLE `item_venda` (
  `id_venda` int NOT NULL,
  `seq_item` int NOT NULL,
  `quantidade` int NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL,
  `id_livro` int DEFAULT NULL,
  `id_papelaria` int DEFAULT NULL,
  PRIMARY KEY (`id_venda`,`seq_item`),
  KEY `id_livro` (`id_livro`),
  KEY `id_papelaria` (`id_papelaria`),
  CONSTRAINT `item_venda_ibfk_1` FOREIGN KEY (`id_venda`) REFERENCES `venda` (`id_venda`) ON DELETE CASCADE,
  CONSTRAINT `item_venda_ibfk_2` FOREIGN KEY (`id_livro`) REFERENCES `livro` (`id_livro`) ON DELETE RESTRICT,
  CONSTRAINT `item_venda_ibfk_3` FOREIGN KEY (`id_papelaria`) REFERENCES `papelaria` (`id_papelaria`) ON DELETE RESTRICT,
  CONSTRAINT `item_venda_chk_1` CHECK (((`id_livro` is not null) xor (`id_papelaria` is not null)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- ----------------------------------------------------------------------
-- DML - POVOAMENTO (INSERT)
-- ----------------------------------------------------------------------

LOCK TABLES `autor` WRITE;
INSERT INTO `autor` VALUES 
(1,'Elena Castro','Brasileira','1980-05-15'),
(2,'Lucas Torres','Português','1975-11-20'),
(3,'Sarah Jones','Americana','1990-01-01');
UNLOCK TABLES;

LOCK TABLES `cliente` WRITE;
INSERT INTO `cliente` VALUES 
(1,'Ana Silva','111.111.111-11','(11) 98765-4321','ana.silva@email.com','Rua das Flores, 100, São Paulo'),
(2,'Bruno Costa','222.222.222-22','(21) 99887-7665','bruno.costa@email.com','Av. Central, 50, Rio de Janeiro'),
(3,'Carla Dias','333.333.333-33','(31) 97654-3210','carla.dias@email.com','Rua Minas Gerais, 75, Belo Horizonte'),
(4,'Felipe Mendes','444.444.444-44','(41) 98765-1234','felipe.mendes@email.com','Rua Curitiba, 30, Curitiba');
UNLOCK TABLES;

LOCK TABLES `editora` WRITE;
INSERT INTO `editora` VALUES 
(1,'Editora Fantasia','22.222.222/0001-22','(11) 7777-8888','Carlos Gomes'),
(2,'Mundos Novos Ltda','33.333.333/0001-33','(41) 9999-0000','Sofia Rocha');
UNLOCK TABLES;

LOCK TABLES `fornecedor` WRITE;
INSERT INTO `fornecedor` VALUES 
(1,'Fornecedora Papel Ltda','00.000.000/0001-00','Pedro Alves','(11) 3333-4444'),
(2,'Distr. Canetas e Cia','11.111.111/0001-11','Lúcia Ferreira','(21) 5555-6666');
UNLOCK TABLES;

LOCK TABLES `livro` WRITE;
INSERT INTO `livro` VALUES 
(1,'O Enigma do Tempo','978-8578870347',87.89,50,1),
(2,'A Biblioteca Secreta','978-8532511032',45.50,120,2),
(3,'As Crônicas de Atlas','978-8580570381',120.00,30,1);
UNLOCK TABLES;

LOCK TABLES `livro_autor` WRITE;
INSERT INTO `livro_autor` VALUES 
(1,1),(3,1),(2,2),(3,3);
UNLOCK TABLES;

LOCK TABLES `papelaria` WRITE;
INSERT INTO `papelaria` VALUES 
(1,'Caderno Universitário','Tilibra','Escolar',19.90,200,1),
(2,'Caneta Gel Azul','Pilot','Escrita',4.50,500,2),
(3,'Bloco de Notas Post-it','3M','Escritório',15.00,80,1);
UNLOCK TABLES;

LOCK TABLES `vendedor` WRITE;
INSERT INTO `vendedor` VALUES 
(1,'João Vianna','Consultor Sênior','(11) 91234-5678',5.00),
(2,'Maria Souza','Consultor Júnior','(11) 98765-4321',3.50);
UNLOCK TABLES;

LOCK TABLES `venda` WRITE;
INSERT INTO `venda` VALUES 
(1,'2025-10-25 10:30:00',125.40,'Cartão de Crédito',1,1),
(2,'2025-10-25 15:45:00',79.90,'PIX',2,2),
(3,'2025-10-26 11:00:00',120.00,'Débito',3,1);
UNLOCK TABLES;

LOCK TABLES `item_venda` WRITE;
INSERT INTO `item_venda` VALUES 
(1,1,1,45.50,2,NULL),
(1,2,1,19.90,NULL,1),
(1,3,2,4.50,NULL,2),
(2,1,1,79.90,1,NULL),
(3,1,1,120.00,3,NULL);
UNLOCK TABLES;


-- ----------------------------------------------------------------------
-- DML ADICIONAL - COMANDOS PARA AVALIAÇÃO (SELECT, UPDATE, DELETE)
-- ----------------------------------------------------------------------

-- ----------------------------------------------------------------------
-- 1. CONSULTAS DE DADOS (SELECT) - Mínimo 2 a 5 consultas com JOIN, WHERE, ORDER BY
-- ----------------------------------------------------------------------

-- Consulta 1: Listar todos os livros e seus respectivos autores (JOIN)
SELECT 
    l.titulo AS Livro, 
    a.nome AS Autor, 
    a.nacionalidade 
FROM 
    livro l
JOIN 
    livro_autor la ON l.id_livro = la.id_livro
JOIN 
    autor a ON la.id_autor = a.id_autor
ORDER BY 
    l.titulo;

-- Consulta 2: Mostrar o nome do cliente, a data da venda e o vendedor responsável (JOIN)
SELECT 
    v.id_venda, 
    v.data_venda, 
    c.nome AS Cliente, 
    vd.nome AS Vendedor,
    v.valor_total
FROM 
    venda v
JOIN 
    cliente c ON v.id_cliente = c.id_cliente
JOIN 
    vendedor vd ON v.id_vendedor = vd.id_vendedor
ORDER BY 
    v.data_venda DESC;

-- Consulta 3: Listar itens de papelaria com estoque abaixo de 200, mostrando o fornecedor (WHERE, JOIN, ORDER BY)
SELECT 
    p.nome AS Item, 
    p.preco, 
    p.quantidade_estoque,
    f.nome AS Fornecedor
FROM 
    papelaria p
JOIN 
    fornecedor f ON p.id_fornecedor = f.id_fornecedor
WHERE 
    p.quantidade_estoque < 200
ORDER BY 
    p.quantidade_estoque ASC;

-- ----------------------------------------------------------------------
-- 2. ATUALIZAÇÃO DE DADOS (UPDATE) - Mínimo 3 comandos com WHERE
-- ----------------------------------------------------------------------

-- Update 1: Aumentar a comissão do vendedor Maria Souza.
UPDATE vendedor
SET comissao = 5.50
WHERE nome = 'Maria Souza';

-- Update 2: Corrigir o preço de um livro no catálogo.
UPDATE livro
SET preco = 95.00
WHERE titulo = 'O Enigma do Tempo';

-- Update 3: Atualiza o endereço de um cliente específico.
UPDATE cliente
SET endereco = 'Rua das Flores, 150, São Paulo (Atualizado)'
WHERE id_cliente = 1;

-- ----------------------------------------------------------------------
-- 3. REMOÇÃO DE DADOS (DELETE) - Mínimo 3 comandos com WHERE, testando integridade
-- ----------------------------------------------------------------------

-- Delete 1: Remover um registro de relacionamento N:N (Tabela livro_autor - ON DELETE CASCADE).
-- Remove a Sarah Jones (id_autor=3) do livro As Crônicas de Atlas (id_livro=3).
DELETE FROM livro_autor 
WHERE id_livro = 3 AND id_autor = 3;

-- Delete 2: Remover item de papelaria que possui estoque alto (exemplo: Caneta Gel Azul).
-- Nota: Como o item está em uma venda (id_venda=1), a restrição ON DELETE RESTRICT impede o DELETE, a menos que a venda seja removida primeiro.
-- Para que este DELETE funcione em um ambiente de teste, o item_venda associado precisaria ser removido. 
-- Para fins de demonstração, vamos tentar deletar o Bloco de Notas (id_papelaria=3) que só está na Venda 1:
DELETE FROM papelaria 
WHERE id_papelaria = 3;

-- Delete 3: Remover um autor (funciona, pois seu único relacionamento foi deletado acima).
DELETE FROM autor
WHERE nome = 'Sarah Jones';

-- ----------------------------------------------------------------------
-- FIM DO SCRIPT
-- ----------------------------------------------------------------------
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
