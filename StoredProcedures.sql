-- Stored Procedure para calcular o total de empréstimos de um determinado livro
CREATE OR REPLACE FUNCTION Total_Emprestimos_Livro(livro_id INT) RETURNS INT AS $$
DECLARE
    total_emprestimos INT;
BEGIN
    SELECT COUNT(*) INTO total_emprestimos
    FROM Emprestimo
    WHERE ID_Livro = livro_id;

    RETURN total_emprestimos;
END; $$
LANGUAGE plpgsql;

-- Stored Procedure para atualizar a disponibilidade de um livro
CREATE OR REPLACE PROCEDURE Atualizar_Disponibilidade_Livro()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Emprestimo
    SET Disponibilidade = CASE
        WHEN Data_De_Devolucao_Efetiva IS NULL THEN 'Indisponível'
        ELSE 'Disponível'
    END;
END; $$

-- Stored Procedure para atualizar o saldo de mensalidades dos alunos
CREATE OR REPLACE PROCEDURE Atualizar_Saldo_Mensalidades()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Aluno_Matricula
    SET Mensalidade = Mensalidade * 0.9
    WHERE Coeficiente_Rendimento >= 8.0;

    UPDATE Aluno_Matricula
    SET Mensalidade = Mensalidade * 1.1
    WHERE Coeficiente_Rendimento < 8.0;
END; $$
