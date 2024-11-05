-- Este código contém o script de log, funções e triggers.
-- As triggers monitoram todas as tabelas e, caso ocorra alguma modificação, a trigger será disparada,
-- resultando no registro da modificação na tabela de log correspondente.
 
 ---------------- CRIAÇÃO DAS TABELAS DE LOG / TRIGGERS e Function --------------------------------------
 
-- Log para a tabela 'Responsavel'
CREATE TABLE Log_Responsavel (
    log_id SERIAL PRIMARY KEY,                
    usuario TEXT NOT NULL,                      
    dt_operacao TIMESTAMP DEFAULT NOW(),     
    operacao TEXT NOT NULL                    
);
 
-- Função de log para a tabela 'Responsavel'
CREATE OR REPLACE FUNCTION log_responsavel()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Log_Responsavel (usuario, dt_operacao, operacao)
    VALUES (current_user, NOW(), TG_OP);
    IF (TG_OP = 'DELETE') THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;
 
-- Trigger para monitorar a tabela 'Responsavel'
CREATE TRIGGER trigger_log_responsavel
AFTER INSERT OR UPDATE OR DELETE
ON Responsavel
FOR EACH ROW
EXECUTE FUNCTION log_responsavel();
 
 
-- Log para a tabela 'Professor'
CREATE TABLE Log_Professor (
    log_id SERIAL PRIMARY KEY,                
    usuario TEXT NOT NULL,                       
    dt_operacao TIMESTAMP DEFAULT NOW(),     
    operacao TEXT NOT NULL                    
);
 
-- Função de log para a tabela 'Professor'
CREATE OR REPLACE FUNCTION log_professor()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Log_Professor (usuario, dt_operacao, operacao)
    VALUES (current_user, NOW(), TG_OP);
    IF (TG_OP = 'DELETE') THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;
 
-- Trigger para monitorar a tabela 'Professor'
CREATE TRIGGER trigger_log_professor
AFTER INSERT OR UPDATE OR DELETE
ON Professor
FOR EACH ROW
EXECUTE FUNCTION log_professor();
 
 
-- Log para a tabela 'Endereco'
CREATE TABLE Log_Endereco (
    log_id SERIAL PRIMARY KEY,                
    usuario TEXT NOT NULL,                       
    dt_operacao TIMESTAMP DEFAULT NOW(),     
    operacao TEXT NOT NULL                    
);
 
-- Função de log para a tabela 'Endereco'
CREATE OR REPLACE FUNCTION log_endereco()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Log_Endereco (usuario, dt_operacao, operacao)
    VALUES (current_user, NOW(), TG_OP);
    IF (TG_OP = 'DELETE') THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;
 
-- Trigger para monitorar a tabela 'Endereco'
CREATE TRIGGER trigger_log_endereco
AFTER INSERT OR UPDATE OR DELETE
ON Endereco
FOR EACH ROW
EXECUTE FUNCTION log_endereco();
 
 
-- Log para a tabela 'Escola'
CREATE TABLE Log_Escola (
    log_id SERIAL PRIMARY KEY,                
    usuario TEXT NOT NULL,                       
    dt_operacao TIMESTAMP DEFAULT NOW(),     
    operacao TEXT NOT NULL                    
);
 
-- Função de log para a tabela 'Escola'
CREATE OR REPLACE FUNCTION log_escola()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Log_Escola (usuario, dt_operacao, operacao)
    VALUES (current_user, NOW(), TG_OP);
    IF (TG_OP = 'DELETE') THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;
 
-- Trigger para monitorar a tabela 'Escola'
CREATE TRIGGER trigger_log_escola
AFTER INSERT OR UPDATE OR DELETE
ON Escola
FOR EACH ROW
EXECUTE FUNCTION log_escola();
 
 
-- Log para a tabela 'Turma'
CREATE TABLE Log_Turma (
    log_id SERIAL PRIMARY KEY,                
    usuario TEXT NOT NULL,                       
    dt_operacao TIMESTAMP DEFAULT NOW(),     
    operacao TEXT NOT NULL                    
);
 
-- Função de log para a tabela 'Turma'
CREATE OR REPLACE FUNCTION log_turma()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Log_Turma (usuario, dt_operacao, operacao)
    VALUES (current_user, NOW(), TG_OP);
    IF (TG_OP = 'DELETE') THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;
 
-- Trigger para monitorar a tabela 'Turma'
CREATE TRIGGER trigger_log_turma
AFTER INSERT OR UPDATE OR DELETE
ON Turma
FOR EACH ROW
EXECUTE FUNCTION log_turma();
 
 
-- Log para a tabela 'Aluno'
CREATE TABLE Log_Aluno (
    log_id SERIAL PRIMARY KEY,                
    usuario TEXT NOT NULL,                       
    dt_operacao TIMESTAMP DEFAULT NOW(),     
    operacao TEXT NOT NULL                    
);
 
-- Função de log para a tabela 'Aluno'
CREATE OR REPLACE FUNCTION log_aluno()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Log_Aluno (usuario, dt_operacao, operacao)
    VALUES (current_user, NOW(), TG_OP);
    IF (TG_OP = 'DELETE') THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;
 
-- Trigger para monitorar a tabela 'Aluno'
CREATE TRIGGER trigger_log_aluno
AFTER INSERT OR UPDATE OR DELETE
ON Aluno

FOR EACH ROW
EXECUTE FUNCTION log_aluno();