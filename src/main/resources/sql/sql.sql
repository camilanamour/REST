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
nota				DECIMAL	NOT NULL
PRIMARY KEY(ra_aluno, codigo_disciplina, codigo_avaliacao)
FOREIGN KEY(ra_aluno) REFERENCES aluno(ra),
FOREIGN KEY(codigo_disciplina) REFERENCES disciplina(codigo),
FOREIGN KEY(codigo_avaliacao) REFERENCES avaliacao(codigo)
)
GO
CREATE TABLE matricula (
codigo_disciplina		VARCHAR(255)			NOT NULL,
ra_aluno				CHAR(13)				NOT NULL
PRIMARY KEY(ra_aluno, codigo_disciplina)
FOREIGN KEY(ra_aluno) REFERENCES aluno(ra),
FOREIGN KEY(codigo_disciplina) REFERENCES disciplina(codigo)
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
('1110482012020','4203-010', 1, 10),
('1110482012020','4203-010', 2, 8)

-- NOTAS UDF
CREATE FUNCTION notas_turma(@codigo_disciplina VARCHAR(255)) 
RETURNS @table TABLE(ra_aluno INT, nome_aluno VARCHAR(100), nota1 DECIMAL, nota2 DECIMAL, nota3 DECIMAL, nota4 DECIMAL,
media_final DECIMAL, situacao VARCHAR(100))
AS 
BEGIN
	DECLARE @ra CHAR(13)
	DECLARE @nome VARCHAR(100)
	DECLARE @disc VARCHAR(255)
	DECLARE @avaliacao INT
	DECLARE @nota DECIMAL
	DECLARE @nota_peso DECIMAL
	DECLARE @num_aulas INT
	DECLARE @total INT

	SELECT @num_aulas = num_aulas FROM disciplina WHERE disciplina.codigo = @codigo_disciplina

	INSERT INTO @table SELECT ra, nome, 0, 0, 0, 0, 0, 0, null FROM aluno

	DECLARE cursor_notas CURSOR
	FOR SELECT notas.ra_aluno, aluno.nome, disciplina.codigo, avaliacao.codigo, notas.nota
	FROM notas, aluno, disciplina, avaliacao
	WHERE notas.ra_aluno = aluno.ra
		AND notas.codigo_disciplina = @codigo_disciplina
		AND notas.codigo_avaliacao = avaliacao.codigo
	ORDER BY notas.ra_aluno, notas.codigo_avaliacao
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
	SET @total = @total / 3
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
CREATE FUNCTION presencas(@presenca INT, @total INT)
RETURNS VARCHAR(4) AS
BEGIN
	DECLARE @pf VARCHAR(4)
	IF @total = 80 BEGIN
		SELECT @pf = CONCAT(REPLICATE('F',@presenca),REPLICATE('P', 4-@presenca))
	END
	ELSE
	BEGIN
		SELECT @pf = CONCAT(REPLICATE('F',@presenca),REPLICATE('P', 2-@presenca))
	END
	RETURN @pf;
END
GO
CREATE FUNCTION calcula_faltas(@ra CHAR(13), @disciplina VARCHAR(255))
RETURNS INT
AS
BEGIN
	DECLARE @faltas INT = 0;
	SELECT @faltas = SUM(presenca) FROM faltas WHERE codigo_disciplina = @disciplina AND codigo_disciplina = @ra
	RETURN @faltas;
END
GO
CREATE FUNCTION faltas_turma(@codigo_disciplina VARCHAR(255)) 
RETURNS @table TABLE(RA_Aluno CHAR(13), Nome_Aluno VARCHAR(255), Data1 VARCHAR(255), Data2 VARCHAR(255),
Data3 VARCHAR(255),Data4 VARCHAR(255),Data5 VARCHAR(255),Data6 VARCHAR(255),Data7 VARCHAR(255),Data8 VARCHAR(255), 
Data9 VARCHAR(255), Data10 VARCHAR(255), Data11 VARCHAR(255), Data12 VARCHAR(255), Data13 VARCHAR(255), Data14 VARCHAR(255), 
Data15 VARCHAR(255), Data16 VARCHAR(255), Data17 VARCHAR(255), Data18 VARCHAR(255), Data19 VARCHAR(255), Data20 VARCHAR(255), 
Total_Faltas INT, Debug VARCHAR(255))
AS
BEGIN
	DECLARE @ra CHAR(13)
	DECLARE @name VARCHAR(255)
	DECLARE @data DATETIME
	DECLARE @presenca INT
	DECLARE @num_aulas INT
	DECLARE @pf VARCHAR(4)
	DECLARE @total INT
	SELECT @num_aulas = num_aulas FROM disciplina WHERE disciplina.codigo = @codigo_disciplina
	DECLARE @t TABLE (RA_Aluno CHAR(13), Nome_Aluno VARCHAR(255), Data1 VARCHAR(255), Data2 VARCHAR(255),Data3 VARCHAR(255),Data4 VARCHAR(255),Data5 VARCHAR(255),Data6 VARCHAR(255),Data7 VARCHAR(255),Data8 VARCHAR(255), Data9 VARCHAR(255), Data10 VARCHAR(255), Data11 VARCHAR(255), Data12 VARCHAR(255), Data13 VARCHAR(255), Data14 VARCHAR(255), Data15 VARCHAR(255), Data16 VARCHAR(255), Data17 VARCHAR(255), Data18 VARCHAR(255), Data19 VARCHAR(255), Data20 VARCHAR(255), Total_Faltas INT, Debug VARCHAR(255))
	DECLARE cursor_faltas CURSOR
	FOR SELECT faltas.ra_aluno, nome, data_falta, presenca 
	FROM faltas, aluno, matricula
	WHERE faltas.ra_aluno = aluno.ra 
		AND faltas.codigo_disciplina = @codigo_disciplina
		AND matricula.ra_aluno = aluno.ra 
		AND matricula.codigo_disciplina = @codigo_disciplina
	ORDER BY faltas.data_falta
	OPEN cursor_faltas
	FETCH NEXT FROM cursor_faltas INTO @ra, @name, @data, @presenca

	WHILE @@FETCH_STATUS = 0
	BEGIN
	DECLARE @exists INT
	SELECT @exists = COUNT(*) FROM @table WHERE RA_Aluno = @ra
	INSERT INTO @t SELECT * FROM @table WHERE RA_Aluno = @ra	
	SELECT @pf = dbo.presencas(@presenca, @num_aulas);
	SELECT @total = dbo.calcula_faltas(@ra, @codigo_disciplina);
	IF @exists = 0 BEGIN
		INSERT INTO @table VALUES(@ra, @name, @pf,NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, @total, '');
	END
	ELSE
	BEGIN
		DECLARE @col VARCHAR(255);
		SELECT @col =  (case when Data2 is null then 'Data2'
             when Data3 is null then 'Data3'
             when Data4 is null then 'Data4'
			 when Data5 is null then 'Data5'
			 when Data6 is null then 'Data6'
			 when Data7 is null then 'Data7'
			 when Data8 is null then 'Data8'
			 when Data9 is null then 'Data9'
			 when Data10 is null then 'Data10'
			 when Data11 is null then 'Data11'
			 when Data12 is null then 'Data12'
			 when Data13 is null then 'Data13'
			 when Data14 is null then 'Data14'
			 when Data15 is null then 'Data15'
			 when Data16 is null then 'Data16'
			 when Data17 is null then 'Data17'
			 when Data18 is null then 'Data18'
			 when Data19 is null then 'Data19'
			 when Data20 is null then 'Data20'
        end) FROM @table WHERE RA_Aluno = @ra;
		UPDATE @table SET Debug = @pf;

		if @col = 'Data2' BEGIN
			UPDATE @table SET Data2 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data3' BEGIN
			UPDATE @table SET Data3 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data4' BEGIN
			UPDATE @table SET Data4 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data5' BEGIN
			UPDATE @table SET Data5 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data6' BEGIN
			UPDATE @table SET Data6 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data7' BEGIN
			UPDATE @table SET Data7 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data8' BEGIN
			UPDATE @table SET Data8 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data9' BEGIN
			UPDATE @table SET Data9 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data10' BEGIN
			UPDATE @table SET Data10 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data11' BEGIN
			UPDATE @table SET Data11 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data12' BEGIN
			UPDATE @table SET Data12 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data13' BEGIN
			UPDATE @table SET Data13 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data14' BEGIN
			UPDATE @table SET Data14 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data15' BEGIN
			UPDATE @table SET Data15 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data16' BEGIN
			UPDATE @table SET Data16 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data17' BEGIN
			UPDATE @table SET Data17 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data18' BEGIN
			UPDATE @table SET Data18 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data19' BEGIN
			UPDATE @table SET Data19 = @pf WHERE RA_Aluno = @ra;
		END
		if @col = 'Data20' BEGIN
			UPDATE @table SET Data20 = @pf WHERE RA_Aluno = @ra;
		END
	END
	FETCH NEXT FROM cursor_faltas INTO @ra, @name, @data, @presenca
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