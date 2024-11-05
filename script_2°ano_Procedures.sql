-- Este código contém o script de procedures.
-- As procedures foram criadas com o intuito de facilitar a inserção em todas as tabelas do banco de dados.

---------------------------------- CRIAÇÃO DAS Procedures --------------------------------------
 
CREATE OR REPLACE PROCEDURE excluir_escola(escola_id INT)
-- declarando a linguagem
LANGUAGE plpgsql
AS $$
BEGIN
    -- Exclui responsáveis pelos alunos+
    DELETE FROM Responsavel
    WHERE responsavel.id_aluno IN (
        SELECT id FROM Aluno WHERE aluno.id_turma IN (
            SELECT id FROM Turma WHERE turma.id_escola = escola_id
        )
    );

    -- Exclui alunos da turma
    DELETE FROM Aluno
    WHERE id_turma IN (
        SELECT id FROM Turma WHERE turma.id_escola = escola_id
    );

    -- Exclui turmas da escola
    DELETE FROM Turma WHERE turma.id_escola = escola_id;

    -- Exclui a escola
    DELETE FROM Escola WHERE id = escola_id;

    RAISE NOTICE 'Escola e registros relacionados a ela excluídos com sucesso';
END;
$$;
------------------------------------- FIM 'excluir_escola' ----------------------------------------------

----------------------------------- Procedure 'transferir_alunos'  --------------------------------------


-- Esta procedure recebe como parâmetro o id da turma origem e o id da turma destino para transferir todos os 
-- alunos de uma turma para outra. A procedure atualiza o 
-- campo idTurma de todos os registros de alunos que estão na turma de origem.
-- Após a transferência, a procedure exibe uma mensagem de sucesso com os IDs da 
-- turma de origem e destino usando RAISE NOTICE.


-- Excluir aluno (funcional)
CREATE OR REPLACE PROCEDURE excluir_aluno(aluno_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Excluir os registros do aluno associados ao responsável
    DELETE FROM Responsavel WHERE responsavel.id_aluno = aluno_id;

    -- Excluir o registro do responsável
    DELETE FROM Aluno WHERE id = aluno_id;

    -- Mensagem para indicar sucesso
    RAISE NOTICE 'Aluno com ID % e seus registros relacionados foram excluídos.', aluno_id;
END;
$$;

-- Excluir turma (funcional)
CREATE OR REPLACE PROCEDURE excluir_turma(turma_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Excluir os registros de alunos associados à turma
    DELETE FROM Aluno WHERE aluno.id_turma = turma_id;


    -- Excluir o registro da turma
    DELETE FROM Turma WHERE id = turma_id;

    -- Mensagem para indicar sucesso
    RAISE NOTICE 'Turma com ID % e seus registros relacionados foram excluídos.', turma_id;
END;
$$;

-- comandos para o crud
-- add aluno (certo)
CREATE OR REPLACE PROCEDURE inserir_aluno (nome1 VARCHAR (20), sobrenome1 VARCHAR (20), xp1 INT, email1 VARCHAR (50), senha1 VARCHAR(20), turma1 VARCHAR(20))
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO aluno (nome, sobrenome, xp, email, senha, id_turma) 
						VALUES (
							nome1
							, sobrenome1
							, xp1
							, email1
							, senha1
							, (select id from turma
								 where concat(serie, ' - ',  nomenclatura) = turma1));
	RAISE NOTICE 'Aluno inserido com sucesso';
END;
$$;

-- add responsavel (certo)
CREATE OR REPLACE PROCEDURE inserir_responsavel (nome1 VARCHAR (20), sobrenome1 VARCHAR (20), email1 VARCHAR (50), nomeInteiro1 VARCHAR (70))
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO responsavel (nome, sobrenome, email, id_aluno)
							VALUES (
								nome1
								, sobrenome1
								, email1
								, (select id from aluno 
								   where concat(nome, ' ', sobrenome) = nomeInteiro1));
	RAISE NOTICE 'Responsavel inserido com sucesso';
END;
$$;

-- add escola
CREATE OR REPLACE PROCEDURE inserir_escola ( nome1 VARCHAR (20), email1 VARCHAR (50), telefone1 INT, endereco1 VARCHAR (500))
LANGUAGE plpgsql
AS $$
BEGIN
	-- Inserindo o valor da variável "endereco" na tabela de endereços
	INSERT INTO endereco (numero, rua, bairro, cidade, estado, cep)
							 	VALUES (
									cast (split_part(endereco1, ',', 2) as INT)
									, split_part(endereco1, ',', 1)
									, split_part(endereco1, ',', 3)
									, split_part(endereco1, ',', 4)
									, split_part(endereco1, ',', 5)
									, split_part(endereco1, ',', 6)
							);
	
	-- Inserindo escola com id correspondente ao endereço criado
	INSERT INTO escola (nome, email, telefone, id_endereco)
							VALUES (
							nome1
							, email1
							, cast (telefone1 as INT)
							, (select id from endereco 
							  where concat(rua, ',', numero, ',', bairro, ',', cidade, ',', estado, ',', cep) = endereco1));
	
	RAISE NOTICE 'Escola inserida com sucesso';
END;
$$;

-- add turma
CREATE OR REPLACE PROCEDURE inserir_turma (serie1 INT
										   , nomenclatura1 VARCHAR(5)
										   , ano1 INT
										   ,  escola1 VARCHAR (40)
										   , professor1 VARCHAR (60))
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO turma (serie, nomenclatura, ano, id_escola, id_professor)
						VALUES (
							serie1
							, nomenclatura1
							, ano1
							, (select id from escola 
							  where nome = escola1)
							, (select id from professor
							  where concat(nome, ' ', sobrenome) = professor1)
						);
	RAISE NOTICE 'Turma inserida com sucesso';
END;
$$;

-- ATUALIZAR ESCOLA 2
CREATE OR REPLACE PROCEDURE atualizar_escola(
id1 INT,
nome1 VARCHAR(100),
email1 VARCHAR(50),
telefone1 VARCHAR(15),
rua VARCHAR(100),
numero INT,
bairro VARCHAR(50),
cidade VARCHAR(50),
estado VARCHAR(50),
cep VARCHAR(15)
)
LANGUAGE plpgsql
AS $$
DECLARE
    novo_id_endereco INT;
BEGIN
    -- Inserindo o novo endereço diretamente com os parâmetros
    INSERT INTO endereco (numero, rua, bairro, cidade, estado, cep)
    VALUES (
        numero,
        rua,
        bairro,
        cidade,
        estado,
        cep
    )
    RETURNING id INTO novo_id_endereco;

    -- Atualizando a tabela escola com o novo id de endereço
    UPDATE escola
    SET 
        nome = nome1,
        email = email1,
        telefone = telefone1,
        id_endereco = novo_id_endereco
    WHERE id = id1;

    -- Removendo endereços antigos não referenciados por nenhuma escola
    DELETE FROM endereco
    WHERE id NOT IN (SELECT id_endereco FROM escola);

    RAISE NOTICE 'Escola atualizada com sucesso!';
END;
$$;