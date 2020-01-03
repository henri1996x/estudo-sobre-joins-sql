CREATE TABLE profissoes(
id serial NOT NULL PRIMARY KEY,
cargo VARCHAR(60) NOT NULL
);

CREATE TABLE clientes(
id serial NOT NULL PRIMARY KEY,
nome VARCHAR(60) NOT NULL,
data_nascimento DATE NOT NULL,
telefone VARCHAR(10) NOT NULL,
id_profissao INT NOT NULL REFERENCES profissoes (id)
);

CREATE TABLE consumidor(
id serial NOT NULL PRIMARY KEY,
nome VARCHAR(50) NOT NULL,
contato VARCHAR(50) NOT NULL,
endereco VARCHAR(100) NOT NULL,
cidade VARCHAR(50) NOT NULL,
cep VARCHAR(20) NOT NULL,
pais VARCHAR(50) NOT NULL
);

INSERT INTO public.profissoes (cargo) VALUES ('Programador');
INSERT INTO public.profissoes (cargo) VALUES ('Analista de Sistemas');
INSERT INTO public.profissoes (cargo) VALUES ('Suporte');
INSERT INTO public.profissoes (cargo) VALUES ('Gerente');

INSERT INTO public.clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('João Pereira','1981-06-15','1234-5688',1);
INSERT INTO public.clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Ricardo da Silva','1973-10-10','2234-5669',2);
INSERT INTO public.clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Felipe Oliveira','1987-08-01','4234-5640',3);
INSERT INTO public.clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Mário Pirez','1991-02-05','5234-5621',1);

INSERT INTO public.consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Alfredo Nunes','Maria Nunes','Rua da Paz, 47','São Paulo', '123.456-87', 'Brasil');
INSERT INTO public.consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Ana Trujillo','Guilherme Souza','Rua Dourada, 452','Goiânia', '232.984-23', 'Brasil');
INSERT INTO public.consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Leandro Veloz','Pedro Siqueira','Rua Vazia, 72','São Paulo', '963.738-23', 'Brasil');
-------------------------------------------------------------------------------------------------------------------
--Introdução a novos tipos de SELECT.
--SELECT com alias e usando um comparador de igualdade

SELECT c.id, c.nome, c.data_nascimento, c.telefone, p.cargo     --Selecione estas colunas
FROM clientes AS c, profissoes AS p			                    --Da tabela cliente como c e profissoes como p
WHERE c.id_profissao = p.id;				                    --Onde id_profissão(clientes) for igual a id(profissão)
-------------------------------------------------------------------------------------------------------------------
--Junção Interna INNER JOIN
--Uma junção interna é caracterizada por uma consulta que retorna apenas os dados que atendem as condições de junção.
--isto é, quais linhas de uma tabela se relacionam com as linhas de outras tabelas.
--Para isso, utilizamos a cláusula ON, que é semelhante a cláusula WHERE

SELECT c.id, c.nome, c.data_nascimento, c.telefone, p.cargo     --Selecione estas colunas
FROM clientes AS c INNER JOIN profissoes AS p		            --Da tabela cliente como c juntando profissoes como p
ON c.id_profissao = p.id;			    	                    --Onde (ON) id_profissão(clientes) for igual a id(profissão)
------------------------------------------------------------------------------------------------------------------------
--Junção Externa OUTER JOIN
--Uma junção externa é uma consulta que não requer que os registros de uma tabela possuam registros equivalentes em outra tabela.
--Esse tipo de junção se subdivide dependendo da tabela do qual admitiremos os registros que não possuem correspondencia: tabela da esquerda, direita ou ambas.

--Junção externa LEFT OUTER JOIN
--O Resultado desta consulta sempre contém todos os registros da tabela esquerda (a primeira mencionada na consulta)
--Mesmo quando não exista registros correspondentes na tabela direita.
--Desta forma, esta consulta retorna todos os valores da tabela esquerda com os valores da tabela direita correspondente.
--Ou quando não há correspondencia, retorna um valor NULL

SELECT * FROM clientes					                        --Selecione tudo da tabela clientes
LEFT OUTER JOIN profissoes				                        --dados da tabela profissoes correspondendo aos dados da tabela clientes(tabela esquerda)
ON clientes.id_profissao = profissoes.id;		                --Onde (ON) id_profissão(clientes) for igual a id(profissão)

--Junção Externa RIGHT OUTER JOIN
--Esta consulta é inversa a anterior e retorna sempre todos os registros da tabela a direita(A segunda tabela mencionada na consulta)
--Mesmo se não existir registro correspondente na tabela a esquerda. Nestes casos, o valor NULL é retornado quando não há correspondencia.

SELECT * FROM clientes					                        --Selecione tudo da tabela clientes
RIGHT OUTER JOIN profissoes				                        --dados da tabela profissoes correspondendo aos dados da tabela clientes(tabela esquerda) mostrando tudo.
ON clientes.id_profissao = profissoes.id;		                --Onde (ON) id_profissão(clientes) for igual a id(profissão)

--Junção Externa FULL OUTER JOIN
--Esta consulta apresenta todos os dados das tabelas a esquerda e a direita, mesmo que não possuam correspondencia em outra tabela.
--A tabela combinada possuirá assim, todos os registros de ambas as tabelas e apresentará os valores nulos para os registros sem correspondencia.

SELECT * FROM clientes					                        --Selecione tudo da tabela clientes
FULL OUTER JOIN profissoes				                        --dados da tabela profissoes correspondendo aos dados da tabela clientes(tabela esquerda) mostrando tudo.
ON clientes.id_profissao = profissoes.id;		                --Onde (ON) id_profissão(clientes) for igual a id(profissão)

--Junção Externa CROSS JOIN
--Esta consulta é usada quando queremos juntar duas ou mais tabelas por cruzamento.
--Ou seja, para cada linha de uma tabela queremos todos os dados da outra tabela ou vice-versa.

SELECT c.id, c.nome, c.data_nascimento, c.telefone, p.cargo     --Selecione estas colunas
FROM clientes AS c					                            --Da tabela clientes como c
CROSS JOIN profissoes AS p;				                        --Juntando com a tabela profissoes.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Auto Junção SELF FOIN
--Esta consulta é uma auto junção de uma tabela a si mesma.
--//Saber os consumidores que moram na mesma cidade//--
 SELECT a.nome AS Consumidor1, b.nome AS Consumidor2, a.cidade	--Selecione as colunas nome (Como Consumidor1), nome(Como Consumidor2) e cidade
 FROM consumidor AS a						                    --Da tabela consumidor como a
 INNER JOIN consumidor AS b					                    --Junte a tabela consumidor como b
 ON a.id <> b.id						                        --Quando a.id for diferente de b.id
 AND a.cidade = b.cidade;					                    --E a.cidade for igual a b.cidade

 --Junção baseada em comparador EQUI-JOIN
 --Uma função equi-join é um tipo específico de junção baseada em comparador, que usa apenas comparações de igualdade na junção.

SELECT * FROM clientes						                    --Selecione tudo da tabela clientes
JOIN profissoes							                        --Junte com a tabela profissões
ON clientes.id_profissao = profissoes.id;			            --Quando a coluna clientes.id_profissao for igual a profissoes.id

--Junção Natural NATURAL JOIN
--Uma função natural-join é um caso especial de equi-join. O resultado desta junção é o conjunto de todas as combinações
--que são iguais em seus nomes de atributos comuns.
--//Nesse caso, está errado pois esta junção só funciona bem se os cammpos chaves (onde acontecem os relacionamentos)
--tiverem o mesmo nome em ambas as tabelas.
--Veja que Mário Perez está com o cargo errado
--Na tabela cliente, o id é 4 e na tabela profissoes, o id gerente é 4//--

SELECT * FROM clientes NATURAL JOIN profissoes;			        --Selecione tudo da tabela clientes, juntando com a tabela profissões (ignorando colunas com dados iguais)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--RESUMO

--Junção de Produto Cartesiano:
--É uma junção entre duas tabelas que origina uma terceira tabela constituida por todos os elementos da primeira tabela
--combinada com todos os elementos da segunda.

--Junção Interna (INNER JOIN):
--Todas as linhas de uma tabela se relacionam com todas as linhas de outras tabelas se elas tiverem ao menos 1 campo em comum.

--Junção Externa Esquerda (LEFT OUTER JOIN):
--Tras todos os registros da tabela esquerda mesmo quando não exista registros correspondentes na tabela direita.

--Junção Externa Direita (RIGHT OUTER JOIN):
--Traz todos os registros da tabela direita mesmo quando não exista registros correspondentes na tabela esquerda.

--Junção Externa Completa (FULL OUTER JOIN) apresenta todos os dados das tabelas a esquerda e a direita, mesmo que não possuam correspondencia em outra tabela.

--Junção Cruzada (CROSS JOIN):
--É uma junção entre todos os campos de ambas as tabelas

--Auto Junção (SELF JOIN):
--Realiza uma auto junção da própria tabela.

--Junção baseada em comparador (EQUI-JOIN):
--Traz todos os registros das tabelas utilizando operador de comparação

--Junção Natural (NATURAL JOIN):
--Traz todos os registros das tabelas de acordo com os nomes de atributos em comum.