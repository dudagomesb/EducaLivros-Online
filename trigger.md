## Triggers

*Este arquivo contem o passo a passo de cada Trigger utilizado.*

### Trigger 1: Guardando Alterações

Este trigger tem o objetivo de registrar todas as alterações (inserções, atualizações e deleções) realizadas na tabela `Usuario` em uma tabela de auditoria chamada `Usuario_Audit`. Isso permite manter um histórico das operações realizadas, facilitando o rastreamento das mudanças feitas nos registros dos usuários.

1. **Criação da Função**:

```sql
CREATE OR REPLACE FUNCTION log_usuario_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO Usuario_Audit (operation, usuario_id, usuario_nome, change_time)
        VALUES ('INSERT', NEW.ID_Usuario, NEW.Nome, NOW());
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO Usuario_Audit (operation, usuario_id, usuario_nome, change_time)
        VALUES ('UPDATE', NEW.ID_Usuario, NEW.Nome, NOW());
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO Usuario_Audit (operation, usuario_id, usuario_nome, change_time)
        VALUES ('DELETE', OLD.ID_Usuario, OLD.Nome, NOW());
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

 2. **Agora, precisamos criar nossa tabela que irá armazenar as operações:**

 ```sql
CREATE TABLE Usuario_Audit (
    audit_id SERIAL PRIMARY KEY,
    operation VARCHAR(10),
    usuario_id INT,
    usuario_nome VARCHAR,
    change_time TIMESTAMP
);
 ```
3. **Por fim, criar nosso Trigger:**

```sql
CREATE TRIGGER usuario_changes_trigger
AFTER INSERT OR UPDATE OR DELETE ON Usuario
FOR EACH ROW EXECUTE FUNCTION log_usuario_changes();
```
*Para testar é bem simples, siga o passo a passo:* 

1. **Insira um novo Usuário :** 

```sql
INSERT INTO Usuario (ID_Usuario, Telefone, Email, Endereco, Data_de_Nascimento, CPF, Nome, Idade)
VALUES (11, '555555555', 'teste.usuario@example.com', 'Rua K, 808', '2000-01-01', '123.456.789-00', 'Teste Usuario', 24);
```

2. **Atualize esse Usuário :** 
```sql
UPDATE Usuario SET Nome = 'Teste Usuario Atualizado' WHERE ID_Usuario = 11;
```

3. **Exclua o Usuário:** 
```sql
DELETE FROM Usuario WHERE ID_Usuario = 11;
```
4. Agora consulte a tabela auxiliar: 
```sql
SELECT * FROM Usuario_Audit;
```

### Trigger 2: Guardando Alterações

Este trigger tem o mesmo objetivo de registrar todas as alterações (inserções, atualizações e deleções), mas agora na tabela emprestimo. 


1. **Criação da Função**:
```sql
CREATE OR REPLACE FUNCTION log_emprestimo_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO Emprestimo_Audit (operation, emprestimo_id, livro_id, usuario_id, data_emprestimo, data_devolucao, data_devolucao_efetiva, disponibilidade, change_time)
        VALUES ('INSERT', NEW.ID_Emprestimo, NEW.ID_Livro, NEW.ID_Usuario, NEW.Data_De_Emprestimo, NEW.Data_De_Devolucao, NEW.Data_De_Devolucao_Efetiva, NEW.Disponibilidade, NOW());
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO Emprestimo_Audit (operation, emprestimo_id, livro_id, usuario_id, data_emprestimo, data_devolucao, data_devolucao_efetiva, disponibilidade, change_time)
        VALUES ('UPDATE', NEW.ID_Emprestimo, NEW.ID_Livro, NEW.ID_Usuario, NEW.Data_De_Emprestimo, NEW.Data_De_Devolucao, NEW.Data_De_Devolucao_Efetiva, NEW.Disponibilidade, NOW());
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO Emprestimo_Audit (operation, emprestimo_id, livro_id, usuario_id, data_emprestimo, data_devolucao, data_devolucao_efetiva, disponibilidade, change_time)
        VALUES ('DELETE', OLD.ID_Emprestimo, OLD.ID_Livro, OLD.ID_Usuario, OLD.Data_De_Emprestimo, OLD.Data_De_Devolucao, OLD.Data_De_Devolucao_Efetiva, OLD.Disponibilidade, NOW());
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

 2. **Agora, precisamos criar nossa tabela que irá armazenar as operações:**
 ```sql
CREATE TABLE Emprestimo_Audit (
    audit_id SERIAL PRIMARY KEY,
    operation VARCHAR(10),
    emprestimo_id INT,
    livro_id INT,
    usuario_id INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    data_devolucao_efetiva DATE,
    disponibilidade VARCHAR,
    change_time TIMESTAMP
);
 ```

3. **Por fim, criar nosso Trigger:**
```sql
CREATE TRIGGER emprestimo_changes_trigger
AFTER INSERT OR UPDATE OR DELETE ON Emprestimo
FOR EACH ROW EXECUTE FUNCTION log_emprestimo_changes();
```
4. **Teste Resumido:**

```sql
--- Inserção
INSERT INTO Emprestimo (ID_Emprestimo, ID_Livro, ID_Usuario, Data_De_Emprestimo, Data_De_Devolucao, Data_De_Devolucao_Efetiva, Disponibilidade)
VALUES (1, 101, 1001, '2024-05-27', '2024-06-03', NULL, 'Emprestado');

--- Atualizar
UPDATE Emprestimo SET Data_De_Devolucao_Efetiva = '2024-06-02', Disponibilidade = 'Disponível' WHERE ID_Emprestimo = 1;

--- Deletar
DELETE FROM Emprestimo WHERE ID_Emprestimo = 1;

--- Verifique se funcionou ;)
SELECT * FROM Emprestimo_Audit;
```

### Trigger 3: Validação de Dados

A ideia desse trigger é garantir que o campo Telefone inserido na tabela Usuario sempre siga um formato específico, por exemplo: "(XX) XXXX-XXXX", antes de permitir a inserção ou atualização. Se o telefone não estiver no formato correto, uma exceção será lançada e a operação será impedida.

1. **Criar a função que o trigger vai chamar**:

```sql
CREATE OR REPLACE FUNCTION validate_phone_format()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificar se o telefone inserido atende ao formato esperado
    IF NEW.Telefone !~ '^\(\d{2}\) \d{4}-\d{4}$' THEN
        -- Se não atender, lançar um erro e impedir a inserção
        RAISE EXCEPTION 'O telefone deve seguir o formato (XX) XXXX-XXXX';
    END IF;
    
    -- Se o telefone estiver no formato correto, permitir a inserção
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

2. **Criar o trigger que chama a função antes de inserir na tabela Usuario**:
```sql
CREATE TRIGGER validate_phone_trigger
BEFORE INSERT OR UPDATE ON Usuario
FOR EACH ROW EXECUTE FUNCTION validate_phone_format();
```

2. **Testando nosso Trigger**:
```sql
INSERT INTO Usuario (ID_Usuario, Telefone, Email, Endereco, Data_de_Nascimento, CPF, Nome, Idade)
VALUES (1003, '123-456-7890', 'teste2@example.com', 'Rua XYZ, 456', '1980-01-01', '987.654.321-00', 'Outro Teste', 40);
```