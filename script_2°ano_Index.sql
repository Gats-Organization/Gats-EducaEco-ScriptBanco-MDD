---------------------------------- CRIAÇÃO DOS INDEXS --------------------------------------


-- Índice para a tabela 'Endereco'
-- Índice no campo 'cep' para melhorar a busca por CEP, útil em filtros de localização.
CREATE INDEX idx_endereco_cep ON Endereco(cep); 

-- Índices para a tabela 'Escola'
-- Índice no campo 'nome' para agilizar buscas por nome da escola.
CREATE INDEX idx_escola_nome ON Escola(nome);

-- Índice no campo 'id_endereco' para otimizar consultas com junção na tabela 'Endereco'.
CREATE INDEX idx_escola_id_endereco ON Escola(id_endereco);

-- Índices para a tabela 'Professor'
-- Índice no campo 'email' para melhorar o desempenho de consultas onde o email do professor é critério.
CREATE INDEX idx_professor_email ON Professor(email);

-- Índices para a tabela 'Turma'
-- Índice no campo 'nomenclatura' para agilizar consultas por nomenclatura de turma.
CREATE INDEX idx_turma_nomenclatura ON Turma(nomenclatura);

-- Índice no campo 'id_escola' para melhorar o desempenho de consultas com junção na tabela 'Escola'.
CREATE INDEX idx_turma_id_escola ON Turma(id_escola);

-- Índice no campo 'id_professor' para otimizar consultas com junção na tabela 'Professor'.
CREATE INDEX idx_turma_id_professor ON Turma(id_professor);

-- Índices para a tabela 'Aluno'
-- Comentário: Índice no campo 'email' para melhorar a busca por email de alunos.
CREATE INDEX idx_aluno_email ON Aluno(email);

-- Índice no campo 'id_turma' para otimizar consultas com junção na tabela 'Turma'.
CREATE INDEX idx_aluno_id_turma ON Aluno(id_turma);

-- Índices para a tabela 'Responsavel'
-- Índice no campo 'email' para melhorar a busca por email de responsáveis.
CREATE INDEX idx_responsavel_email ON Responsavel(email);

-- Índice no campo 'id_aluno' para otimizar consultas com junção na tabela 'Aluno'.
CREATE INDEX idx_responsavel_id_aluno ON Responsavel(id_aluno);
