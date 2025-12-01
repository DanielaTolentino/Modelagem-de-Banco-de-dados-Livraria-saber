# Modelagem-de-Banco-de-dados-Livraria-saber
Este repositório contém os scripts SQL para a criação e manipulação do banco de dados relacional livraria_saber

📚 **Livraria Saber - Projeto de Banco de Dados SQL**
Este repositório contém os scripts SQL para a criação e manipulação do banco de dados relacional livraria_saber, desenvolvido como parte da Experiência Prática IV. O projeto simula a gestão de uma livraria, incluindo tabelas para livros, autores, clientes, vendas, produtos de papelaria, fornecedores e editoras.

O projeto demonstra a aplicação de comandos DML (Data Manipulation Language) e o gerenciamento de integridade de dados através de chaves primárias e estrangeiras.

📝 **Estrutura do Banco de Dados (Mini-mundo)**
O modelo lógico da livraria é implementado através das seguintes tabelas:
autor: Informações sobre os autores dos livros.
editora: Dados das editoras.
fornecedor: Dados dos fornecedores de papelaria.
livro: Catálogo de livros.
papelaria: Catálogo de produtos de papelaria.
cliente: Cadastro dos clientes.
vendedor: Cadastro dos vendedores.
venda: Registros das transações de venda.
livro_autor: Tabela de relacionamento N:N entre Livro e Autor.
item_venda: Itens detalhados de cada venda (Livros ou Papelaria).

**🛠️ Tecnologias Utilizadas**
SGBD: MySQL (Utilizando MySQL Workbench)
Linguagem: SQL (DDL e DML)

**🚀 Como Executar o Script**
Para replicar o banco de dados em seu ambiente, siga os passos abaixo:
Instalação: Certifique-se de ter o MySQL Server e o MySQL Workbench (ou outra ferramenta de sua preferência, como DBeaver ou HeidiSQL) instalados.
Criação do Schema: No MySQL Workbench, crie um novo schema chamado livraria_saber.
Execução do Script DDL/DML:
Abra o arquivo Livraria_s.sql.
Selecione o schema livraria_saber para uso (ou adicione USE livraria_saber; no topo do arquivo).
Execute o script completo. Ele criará todas as tabelas, definirá as restrições e as chaves (DDL), e em seguida, populará as tabelas com dados iniciais (DML - INSERT).

**💻 Comandos SQL Essenciais**
O script demonstra o uso dos principais comandos DML, garantindo a manipulação e integridade dos dados.

**1. Inserção de Dados (INSERT)**
O arquivo Livraria_s.sql inclui comandos INSERT para todas as tabelas.

SQL
-- Exemplo de INSERT
INSERT INTO autor (nome, nacionalidade, data_nascimento) VALUES 
('Elena Castro', 'Brasileira', '1980-05-15'),
('Lucas Torres', 'Português', '1975-11-20');

INSERT INTO cliente (nome, cpf, telefone, email, endereco) VALUES 
('Felipe Mendes', '444.444.444-44', '(41) 98765-1234', 'felipe.mendes@email.com', 'Rua Curitiba, 30, Curitiba');
2. Consultas de Dados (SELECT)
As consultas abaixo demonstram o uso de WHERE, ORDER BY e JOIN para extrair informações relevantes.

SQL
-- 1. Consultar todos os livros da Editora Fantasia, ordenados por preço decrescente (JOIN)
SELECT 
    l.titulo, 
    l.preco, 
    e.nome AS editora 
FROM 
    livro l
JOIN 
    editora e ON l.id_editora = e.id_editora
WHERE 
    e.nome = 'Editora Fantasia'
ORDER BY 
    l.preco DESC;

-- 2. Consultar os itens de papelaria com estoque abaixo de 100 unidades (WHERE)
SELECT 
    nome, 
    marca, 
    quantidade_estoque 
FROM 
    papelaria
WHERE 
    quantidade_estoque < 100;

-- 3. Listar todas as vendas realizadas e o nome do cliente correspondente (JOIN)
SELECT 
    v.id_venda, 
    v.data_venda, 
    c.nome AS nome_cliente, 
    v.valor_total
FROM 
    venda v
JOIN 
    cliente c ON v.id_cliente = c.id_cliente
ORDER BY 
    v.data_venda DESC;
3. Atualização de Dados (UPDATE)
Comandos para modificar dados existentes.

SQL

-- 1. Aumentar o preço do Caderno Universitário em 10%
UPDATE papelaria
SET preco = preco * 1.10
WHERE nome = 'Caderno Universitário';

-- 2. Atualizar o cargo de um vendedor
UPDATE vendedor
SET cargo = 'Gerente de Vendas'
WHERE nome = 'João Vianna';

-- 3. Corrigir o email de um cliente específico
UPDATE cliente
SET email = 'ana.silva_novo@email.com'
WHERE id_cliente = 1;
4. Remoção de Dados (DELETE)
Comandos para remover registros, testando as restrições de integridade referencial (ON DELETE RESTRICT e ON DELETE CASCADE).

SQL

-- 1. Remover o relacionamento entre um livro e um autor (Tabela N:N com CASCADE)
DELETE FROM livro_autor 
WHERE id_livro = 3 AND id_autor = 3;

-- 2. Remover um fornecedor que não está vinculado a nenhum produto de papelaria (DELETE Simples)
DELETE FROM fornecedor 
WHERE nome = 'Fornecedor Fictício'; -- (Assumindo que este registro foi inserido para testes)

-- 3. Remover um cliente específico (Restrição ON DELETE RESTRICT na tabela 'venda' impede a exclusão se houver vendas vinculadas)
-- Para que funcione, seria necessário deletar as vendas do cliente primeiro.
DELETE FROM cliente 
WHERE id_cliente = 4;.
