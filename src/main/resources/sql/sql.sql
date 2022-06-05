CREATE DATABASE siga
GO
USE siga
GO
-- Tabelas
CREATE TABLE aluno (
ra		CHAR(13)		NOT NULL,
nome	VARCHAR(50)		NOT NULL
PRIMARY KEY (ra)
)
GO
CREATE TABLE disciplina (
codigo		VARCHAR(255)			NOT NULL,
nome		VARCHAR(100)	NOT NULL, 
sigla		VARCHAR(10)	NOT NULL,
turno		VARCHAR(5)	NOT NULL,
num_aulas	INT			NOT NULL
PRIMARY KEY (codigo)
)
GO
CREATE TABLE faltas (
codigo_disciplina		VARCHAR(255)			NOT NULL,
ra_aluno				CHAR(13)	NOT NULL, 
data_falta				DATE		NOT NULL,
presenca				INT			NOT NULL
PRIMARY KEY(ra_aluno, codigo_disciplina,data_falta)
FOREIGN KEY(ra_aluno) REFERENCES aluno(ra),
FOREIGN KEY(codigo_disciplina) REFERENCES disciplina(codigo)
)
GO
CREATE TABLE avaliacao(
codigo		INT			NOT NULL,
tipo		VARCHAR(5)	NOT NULL
PRIMARY KEY(codigo)
)
GO
CREATE TABLE notas(
ra_aluno			CHAR(13)	NOT NULL,
codigo_disciplina	VARCHAR(255)	NOT NULL,
codigo_avaliacao	INT	NOT NULL,
nota				DECIMAL(7,1)	NOT NULL
PRIMARY KEY(ra_aluno, codigo_disciplina, codigo_avaliacao)
FOREIGN KEY(ra_aluno) REFERENCES aluno(ra),
FOREIGN KEY(codigo_disciplina) REFERENCES disciplina(codigo),
FOREIGN KEY(codigo_avaliacao) REFERENCES avaliacao(codigo)
)
GO

-- Inserçoes
INSERT INTO disciplina VALUES
('4203-010', 'Arquitetura e Organização de Computadores', 'AOC', 'tarde', 80),
('4203-020', 'Arquitetura e Organização de Computadores', 'AOC', 'noite', 80),
('4208-010', 'Laboratório de Hardware', 'LBH', 'tarde', 80),
('4226-004', 'Banco de Dados', 'BD', 'tarde', 80),
('4233-005', 'Laboratorio de Banco de Dados', 'LBD', 'tarde', 80),
('5005-220', 'Métodos Para a Produção do Conhecimento', 'MPC', 'manha', 40);

INSERT INTO avaliacao VALUES(1,'P1'), (2,'P2'),(3,'P3'),(4,'T'), (5,'R');

INSERT INTO aluno VALUES
('1110482012001', 'Ana'),
('1110482012002', 'Bianca'),
('1110482012003', 'Camila'),
('1110482012004', 'Débora'),
('1110482012005', 'Erick'),
('1110482012006', 'Fernando'),
('1110482012007', 'Gabriel'),
('1110482012008', 'Henrique'),
('1110482012009', 'Igor'),
('1110482012010', 'Juliana'),
('1110482012011', 'Kelly'),
('1110482012012', 'Luana'),
('1110482012013', 'Maria'),
('1110482012014', 'Natalia'),
('1110482012015', 'Otavio'),
('1110482012016', 'Pedro'),
('1110482012017', 'Roberto'),
('1110482012018', 'Sonia'),
('1110482012019', 'Tiago'),
('1110482012020', 'Vinicius')
GO
INSERT INTO notas VALUES
('1110482012020','4203-010', 1, 10.0),
('1110482012020','4203-010', 2, 8.0),
('1110482012020','4203-010', 4, 8.0)
GO
INSERT INTO notas VALUES
('1110482012016','4203-010', 1, 5.0),
('1110482012016','4203-010', 2, 5.0),
('1110482012016','4203-010', 4, 2.0),
('1110482012016','4208-010', 1, 10.0),
('1110482012016','4208-010', 2, 8.0),
('1110482012016','4208-010', 4, 8.0)
GO
INSERT INTO notas VALUES
('1110482012003','4233-005', 1, 9.0),
('1110482012003','4233-005', 2, 7.0),
('1110482012003','4233-005', 3, 4.0)
GO
INSERT INTO faltas VALUES
('4203-010','1110482012016', '2022-01-01', 0),
('4203-010','1110482012016', '2022-01-02', 1),
('4203-010','1110482012016', '2022-01-03', 0),
('4203-010','1110482012016', '2022-01-04', 0),
('4203-010','1110482012016', '2022-01-05', 2),
('4203-010','1110482012016', '2022-01-06', 0),
('4203-010','1110482012016', '2022-01-07', 0),
('4203-010','1110482012016', '2022-01-08', 0),
('4203-010','1110482012016', '2022-01-09', 0),
('4203-010','1110482012016', '2022-01-10', 1),
('4203-010','1110482012016', '2022-01-11', 0),
('4203-010','1110482012016', '2022-01-12', 1),
('4203-010','1110482012016', '2022-01-13', 0),
('4203-010','1110482012016', '2022-01-14', 0),
('4203-010','1110482012016', '2022-01-15', 2),
('4203-010','1110482012016', '2022-01-16', 0),
('4203-010','1110482012016', '2022-01-17', 0),
('4203-010','1110482012016', '2022-01-18', 0),
('4203-010','1110482012016', '2022-01-19', 0),
('4203-010','1110482012016', '2022-01-20', 1)
GO
INSERT INTO faltas VALUES
('4203-010','1110482012020', '2022-01-01', 0),
('4203-010','1110482012020', '2022-01-02', 1),
('4203-010','1110482012020', '2022-01-03', 0),
('4203-010','1110482012020', '2022-01-04', 0),
('4203-010','1110482012020', '2022-01-05', 2),
('4203-010','1110482012017', '2022-01-01', 0),
('4203-010','1110482012017', '2022-01-02', 0)


SELECT * FROM notas_turma('4203-010') -- AOC
SELECT * FROM notas_turma('4208-010') -- LabHW
SELECT * FROM notas_turma('4233-005') -- LabBD

SELECT * FROM faltas_turma('4203-010') -- AOC

-- NOTAS UDF
CREATE FUNCTION notas_turma(@codigo_disciplina VARCHAR(255)) 
RETURNS @table TABLE(ra_aluno CHAR(13), nome_aluno VARCHAR(100), nota1 DECIMAL(7,2), nota2 DECIMAL(7,2), nota3 DECIMAL(7,2), nota4 DECIMAL(7,2),
media_final DECIMAL(7,2), situacao VARCHAR(100))
AS 
BEGIN
	DECLARE @ra CHAR(13)
	DECLARE @nome VARCHAR(100)
	DECLARE @disc VARCHAR(255)
	DECLARE @avaliacao INT
	DECLARE @nota DECIMAL(7,2)
	DECLARE @nota_peso DECIMAL(7,2)
	DECLARE @num_aulas INT
	DECLARE @total INT

	SELECT @num_aulas = num_aulas FROM disciplina WHERE disciplina.codigo = @codigo_disciplina

	INSERT INTO @table SELECT aluno.ra, aluno.nome, 0, 0, 0, 0, 0, null 
	FROM aluno, notas, disciplina, avaliacao
	WHERE aluno.ra = notas.ra_aluno
		AND disciplina.codigo = notas.codigo_disciplina
		AND notas.codigo_avaliacao = avaliacao.codigo
		AND disciplina.codigo = @codigo_disciplina
	GROUP BY aluno.ra, aluno.nome

	DECLARE cursor_notas CURSOR
	FOR SELECT aluno.ra, aluno.nome, disciplina.codigo, avaliacao.codigo, notas.nota
	FROM notas, aluno, disciplina, avaliacao
	WHERE notas.ra_aluno = aluno.ra
		AND notas.codigo_disciplina = disciplina.codigo
		AND notas.codigo_avaliacao = avaliacao.codigo
		AND notas.codigo_disciplina = @codigo_disciplina
	ORDER BY aluno.ra, avaliacao.codigo
	OPEN cursor_notas
	FETCH NEXT FROM cursor_notas INTO @ra, @nome, @disc, @avaliacao, @nota

	WHILE @@FETCH_STATUS = 0
		BEGIN

		IF(@avaliacao = 1)
		BEGIN
			IF(@disc = '4213-003' OR @disc = '4213-013')
			BEGIN
				SET @nota_peso = @nota * 0.35
			END
			IF(@disc = '4203-010' OR @disc = '4203-020' OR @disc = '4208-010' OR @disc = '4226-004')
			BEGIN
				SET @nota_peso = @nota * 0.3
			END
			IF(@disc = '4233-005')
			BEGIN
				SET @nota_peso = @nota * 0.333
			END
			IF(@disc = '5005-220')
			BEGIN
				SET @nota_peso = @nota * 0.8
			END
			UPDATE @table SET nota1 = @nota, media_final = media_final + @nota_peso WHERE RA_Aluno = @ra
		END
		IF(@avaliacao = 2)
		BEGIN
			IF(@disc = '4213-003' OR @disc = '4213-013')
			BEGIN
				SET @nota_peso = @nota * 0.35
			END
			IF(@disc = '4203-010' OR @disc = '4203-020' OR @disc = '4208-010' OR @disc = '4226-004')
			BEGIN
				SET @nota_peso = @nota * 0.5
			END
			IF(@disc = '4233-005')
			BEGIN
				SET @nota_peso = @nota * 0.333
			END
			IF(@disc = '5005-220')
			BEGIN
				SET @nota_peso = @nota * 0.2
			END
			UPDATE @table SET nota2 = @nota, media_final = media_final + @nota_peso WHERE RA_Aluno = @ra
		END
		IF(@avaliacao = 3)
		BEGIN
			IF(@disc = '4233-005')
			BEGIN
				SET @nota_peso = @nota * 0.333
			END
			UPDATE @table SET nota3 = @nota, media_final = media_final + @nota_peso WHERE RA_Aluno = @ra
		END
		IF(@avaliacao = 4)
		BEGIN
			IF(@disc = '4213-003' OR @disc = '4213-013')
			BEGIN
				SET @nota_peso = @nota * 0.3
			END
			IF(@disc = '4203-010' OR @disc = '4203-020' OR @disc = '4208-010' OR @disc = '4226-004')
			BEGIN
				SET @nota_peso = @nota * 0.2
			END
			UPDATE @table SET nota3 = @nota, media_final = media_final + @nota_peso WHERE RA_Aluno = @ra
		END

		SELECT @total = media_final FROM @table WHERE ra_aluno = @ra
		IF(@total < 6)
		BEGIN
			UPDATE @table SET situacao = 'Reprovado', media_final = @total WHERE RA_Aluno = @ra
		END
		IF(@total >= 6)
		BEGIN
			UPDATE @table SET situacao = 'Aprovado', media_final = @total WHERE RA_Aluno = @ra
		END
		FETCH NEXT FROM cursor_notas INTO @ra, @nome, @disc, @avaliacao, @nota
	END
	CLOSE cursor_notas
	DEALLOCATE cursor_notas
	RETURN;
END
GO

-- FALTAS UDF
CREATE FUNCTION presencas(@presenca INT) -- Mostrar em tabela
RETURNS VARCHAR(4) AS
BEGIN
	DECLARE @pf VARCHAR(4)
	IF @presenca = 0
	BEGIN
		SET @pf = 'PPPP'
	END
	IF @presenca = 1
	BEGIN
		SET @pf = 'FPPP'
	END
	IF @presenca = 2
	BEGIN
		SET @pf = 'FFPP'
	END
	IF @presenca = 3
	BEGIN
		SET @pf = 'FFFP'
	END
	IF @presenca = 4
	BEGIN
		SET @pf = 'FFFF'
	END
	RETURN @pf
END
GO
CREATE FUNCTION faltas_turma(@codigo_disciplina VARCHAR(255)) 
	RETURNS @table TABLE(RA_Aluno CHAR(13), Nome_Aluno VARCHAR(100), Data1 VARCHAR(4), Data2 VARCHAR(4),
	Data3 VARCHAR(4),Data4 VARCHAR(4),Data5 VARCHAR(4),Data6 VARCHAR(4),Data7 VARCHAR(4),Data8 VARCHAR(4), 
	Data9 VARCHAR(4), Data10 VARCHAR(4), Data11 VARCHAR(4), Data12 VARCHAR(4), Data13 VARCHAR(4), Data14 VARCHAR(4), 
	Data15 VARCHAR(4), Data16 VARCHAR(4), Data17 VARCHAR(4), Data18 VARCHAR(4), Data19 VARCHAR(4), Data20 VARCHAR(4), 
	Total_Faltas INT)
AS
BEGIN
	DECLARE @ra CHAR(13), @nome VARCHAR(100), @data DATETIME, @presenca INT
	DECLARE @num_aulas INT, @pf VARCHAR(4), @query VARCHAR(255)
	DECLARE @total INT, @contar INT = 1, @limite INT

	SELECT @num_aulas = num_aulas FROM disciplina WHERE disciplina.codigo = @codigo_disciplina
		
	INSERT INTO @table SELECT faltas.ra_aluno, aluno.nome, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @num_aulas
		FROM aluno, disciplina, faltas
		WHERE faltas.ra_aluno = aluno.ra
			AND faltas.codigo_disciplina = disciplina.codigo
			AND faltas.codigo_disciplina = @codigo_disciplina
		GROUP BY faltas.ra_aluno, aluno.nome

	DECLARE cursor_faltas CURSOR
	FOR SELECT faltas.ra_aluno, aluno.nome, faltas.data_falta, faltas.presenca 
	FROM faltas, aluno, disciplina
	WHERE faltas.ra_aluno = aluno.ra 
		AND faltas.codigo_disciplina = disciplina.codigo
		AND faltas.codigo_disciplina = @codigo_disciplina
	ORDER BY faltas.ra_aluno, faltas.data_falta

	OPEN cursor_faltas
	FETCH NEXT FROM cursor_faltas INTO @ra, @nome, @data, @presenca

	WHILE @@FETCH_STATUS = 0
		BEGIN
		SET @contar = 1
		SELECT @limite = COUNT(ra_aluno) FROM faltas WHERE ra_aluno = @ra
		WHILE @contar <= @limite AND @@FETCH_STATUS = 0
			BEGIN
			SELECT @pf = dbo.presencas(@presenca)
			IF @contar = 1
			BEGIN
				UPDATE @table SET Data1 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 2
			BEGIN
				UPDATE @table SET Data2 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 3
			BEGIN
				UPDATE @table SET Data3 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 4
			BEGIN
				UPDATE @table SET Data4 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 5
			BEGIN
				UPDATE @table SET Data5 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 6
			BEGIN
				UPDATE @table SET Data6 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 7
			BEGIN
				UPDATE @table SET Data7 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 8
			BEGIN
				UPDATE @table SET Data8 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 9
			BEGIN
				UPDATE @table SET Data9 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 10
			BEGIN
				UPDATE @table SET Data10 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 11
			BEGIN
				UPDATE @table SET Data11 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 12
			BEGIN
				UPDATE @table SET Data12 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 13
			BEGIN
				UPDATE @table SET Data13 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 14
			BEGIN
				UPDATE @table SET Data14 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 15
			BEGIN
				UPDATE @table SET Data15 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 16
			BEGIN
				UPDATE @table SET Data16 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 17
			BEGIN
				UPDATE @table SET Data17 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 18
			BEGIN
				UPDATE @table SET Data18 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 19
			BEGIN
				UPDATE @table SET Data19 = @pf WHERE RA_Aluno = @ra
			END
			IF @contar = 20
			BEGIN
				UPDATE @table SET Data20 = @pf WHERE RA_Aluno = @ra
			END
			UPDATE @table SET Total_Faltas = Total_Faltas - @presenca WHERE RA_Aluno = @ra
			FETCH NEXT FROM cursor_faltas INTO @ra, @nome, @data, @presenca
			SET @contar = @contar + 1
		END		
	END
	CLOSE cursor_faltas
	DEALLOCATE cursor_faltas
	RETURN;
END

SELECT * FROM aluno
SELECT * FROM avaliacao
SELECT * FROM disciplina
SELECT * FROM notas
SELECT * FROM faltas
SELECT * FROM matricula