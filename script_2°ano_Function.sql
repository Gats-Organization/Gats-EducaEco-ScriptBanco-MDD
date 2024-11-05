---------------------------------- CRIAÇÃO DA FUNCTION --------------------------------------

CREATE OR REPLACE FUNCTION formatar_telefone(p_telefone VARCHAR)
RETURNS VARCHAR AS $$
DECLARE
    telefone_formatado VARCHAR;
BEGIN

    IF LENGTH(p_telefone) < 7 OR LENGTH(p_telefone) > 11 THEN
        RAISE EXCEPTION 'Telefone % é inválido. Deve ter entre 7 e 11 dígitos.', p_telefone;
    END IF;
 
    IF LENGTH(p_telefone) = 11 THEN
        telefone_formatado := '(' || substr(p_telefone, 1, 2) || ') ' || substr(p_telefone, 3, 5) || '-' || substr(p_telefone, 8, 4);
    ELSIF LENGTH(p_telefone) = 10 THEN
        telefone_formatado := '(' || substr(p_telefone, 1, 2) || ') ' || substr(p_telefone, 3, 4) || '-' || substr(p_telefone, 7, 4);
    END IF;
 
    RETURN telefone_formatado;
END;
$$ LANGUAGE plpgsql;
