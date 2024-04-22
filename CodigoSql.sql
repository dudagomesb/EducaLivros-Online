CREATE TABLE Livro (
    Genero VARCHAR(60),
    Autor VARCHAR(60),
    Titulo VARCHAR(60),
    ID_Livro INT PRIMARY KEY,
    Sessao VARCHAR(60),
    Numeros_De_Pags INT
);

CREATE TABLE Autor (
    Nacionalidade VARCHAR(60),
    Nome VARCHAR(60) PRIMARY KEY,
    Genero_Literario VARCHAR(60),
    Data_Nascimento INT
);

CREATE TABLE Usuario (
    ID_Usuario INT PRIMARY KEY,
    Telefone INT,
    Email VARCHAR(60),
    Endereco VARCHAR(60),
    Data_de_Nascimento DATE,
    CPF VARCHAR(60),
    Nome VARCHAR(60),
    Idade INT
);

CREATE TABLE Emprestimo (
    ID_Emprestimo INT PRIMARY KEY,
    ID_Livro INT,
    ID_Usuario INT,
    Data_De_Emprestimo DATE,
    Data_De_Devolucao_Efetiva DATE,
    Data_De_Devolucao DATE,
    Disponibilidade VARCHAR(60)
);

CREATE TABLE Balcao_Biblioteca (
    Nome_Funcionario VARCHAR(60),
    ID_Funcao_Biblioteca INT PRIMARY KEY
);

CREATE TABLE Editora (
    Nome_Editora VARCHAR(60) PRIMARY KEY,
    Telefone INT,
    Email VARCHAR(60)
);

CREATE TABLE Online (
    Aplicativo VARCHAR(60),
    Web_Site VARCHAR(60),
    fk_Emprestimo_ID_Emprestimo INT PRIMARY KEY
);

CREATE TABLE Presencial_Biblioteca (
    Rua VARCHAR(60),
    Numero INT,
    fk_Emprestimo_ID_Emprestimo INT PRIMARY KEY
);
CREATE TABLE Presencial_Escola (
    Local VARCHAR(60),
    fk_Aula_Codigo_Turma INT PRIMARY KEY
);
CREATE TABLE Entregador (
    ID_Motoboy INT PRIMARY KEY,
    Valor INT,
    Endereco VARCHAR(60)
);

CREATE TABLE Professor (
    Ident INT,
    Salario DECIMAL,
    Disciplinas VARCHAR(60),
    fk_Usuario_ID_Usuario INT,
    PRIMARY KEY (Ident, fk_Usuario_ID_Usuario)
);

CREATE TABLE Aluno_Matricula (
    Mensalidade INT,
    RG INT,
    Notas INT,
    fk_Usuario_ID_Usuario INT,
    Numero INT,
    Materias_Matriculadas VARCHAR(60),
    Coeficiente_Rendimento INT,
    Historico_Escolar VARCHAR(60),
    PRIMARY KEY (RG, fk_Usuario_ID_Usuario, Numero)
);

CREATE TABLE Disciplina (
    Codigo INT PRIMARY KEY,
    Descricao VARCHAR(60),
    Nome VARCHAR(60),
    Horario INT,
    Carga_Horaria INT
);

CREATE TABLE Aula (
    Horario TIME,
    Presenca_Alunos VARCHAR(60),
    Codigo_Turma INT PRIMARY KEY
);

CREATE TABLE Obrigatoria (
    Percentual_Reprovacao DECIMAL,
    fk_Disciplina_Codigo INT PRIMARY KEY
);

CREATE TABLE Eletiva (
    Percentual_Alunos_Turma DECIMAL,
    fk_Disciplina_Codigo INT PRIMARY KEY
);

CREATE TABLE Avaliacao (
    Numero_Questoes INT,
    Modalidade VARCHAR(60),
    Id_Aluno INT PRIMARY KEY
);

CREATE TABLE EAD (
    Plataforma VARCHAR(60),
    FK_Aula_Codigo_Turma INT PRIMARY KEY
);



CREATE TABLE Coordenador (
    Salario DECIMAL,
    Email VARCHAR(60),
    CPF INT PRIMARY KEY,
    Telefone INT
);

CREATE TABLE Escreve (
    fk_Livro_ID_Livro INT,
    fk_Autor_Nome VARCHAR(60)
);

CREATE TABLE Contem (
    fk_Emprestimo_ID_Emprestimo INT,
    fk_Livro_ID_Livro INT
);

CREATE TABLE Comercializa (
    fk_Livro_ID_Livro INT,
    fk_Editora_Nome_Editora VARCHAR(60)
);

CREATE TABLE Efetua_Consulta (
    fk_Emprestimo_ID_Emprestimo INT,
    fk_Usuario_ID_Usuario INT
);

CREATE TABLE Cuida (
    fk_Balcao_Biblioteca_ID_Funcao_Biblioteca INT,
    fk_Presencial_fk_Emprestimo_ID_Emprestimo INT
);

CREATE TABLE Entrega (
    fk_Entregador_ID_Motoboy INT,
    fk_Online_fk_Emprestimo_ID_Emprestimo INT
);

CREATE TABLE Ministra (
    fk_Professor_Ident INT,
    fk_Professor_fk_Usuario_ID_Usuario INT,
    fk_Disciplina_Codigo INT,
    fk_Avaliacao_Id_Aluno INT
);

CREATE TABLE Estuda (
    fk_Aluno_Matricula_RG INT,
    fk_Aluno_Matricula_fk_Usuario_ID_Usuario INT,
    fk_Disciplina_Codigo INT
);

CREATE TABLE Assiste (
    fk_Aula_Codigo_Turma INT,
    fk_Aluno_Matricula_RG INT,
    fk_Aluno_Matricula_fk_Usuario_ID_Usuario INT
);

CREATE TABLE Associada (
    fk_Aula_Codigo_Turma INT,
    fk_Disciplina_Codigo INT
);

CREATE TABLE Coordena (
    fk_Professor_Ident INT,
    fk_Professor_fk_Usuario_ID_Usuario INT,
    fk_Coordenador_CPF INT
);

   
-- Inserções na tabela Livro
INSERT INTO Livro (Genero, Autor, Titulo, ID_Livro, Sessao, Numeros_De_Pags)
VALUES ('Ficção Científica', 'Isaac Asimov', 'Fundação', 1, 'A1', 300),
       ('Fantasia', 'J.R.R. Tolkien', 'O Senhor dos Anéis', 2, 'B2', 500);

-- Inserções na tabela Autor
INSERT INTO Autor (Nacionalidade, Nome, Genero_Literario, Data_Nascimento)
VALUES ('Americano', 'Isaac Asimov', 'Ficção Científica', 1920),
       ('Britânico', 'J.R.R. Tolkien', 'Fantasia', 1892);

-- Inserções na tabela Usuario
INSERT INTO Usuario (ID_Usuario, Telefone, Email, Endereco, Data_de_Nascimento, CPF, Nome, Idade)
VALUES (1, 123456789, 'usuario1@example.com', 'Rua A, 123', '1990-01-01', '123.456.789-00', 'Usuário 1', 34),
       (2, 987654321, 'usuario2@example.com', 'Rua B, 456', '1985-05-15', '987.654.321-00', 'Usuário 2', 39);

-- Inserções na tabela Emprestimo
INSERT INTO Emprestimo (ID_Emprestimo, ID_Livro, ID_Usuario, Data_De_Emprestimo, Data_De_Devolucao_Efetiva, Data_De_Devolucao, Disponibilidade)
VALUES (1, 1, 1, '2024-04-01', '2024-04-15', NULL, 'Disponível'),
       (2, 2, 2, '2024-04-05', NULL, NULL, 'Emprestado');

-- Inserções na tabela Balcao_Biblioteca
INSERT INTO Balcao_Biblioteca (Nome_Funcionario, ID_Funcao_Biblioteca)
VALUES ('João Silva', 1),
       ('Maria Souza', 2);

-- Inserções na tabela Editora
INSERT INTO Editora (Nome_Editora, Telefone, Email)
VALUES ('Editora A', 111111111, 'editoraA@example.com'),
       ('Editora B', 222222222, 'editoraB@example.com');

-- Inserções na tabela Online
INSERT INTO Online (Aplicativo, Web_Site, fk_Emprestimo_ID_Emprestimo)
VALUES ('AppLivros', 'www.applivros.com', 1),
       ('LeituraOnline', 'www.leituraonline.com', 2);

-- Inserções na tabela Presencial_Biblioteca
INSERT INTO Presencial_Biblioteca (Rua, Numero, fk_Emprestimo_ID_Emprestimo)
VALUES ('Rua X', 123, 1),
       ('Rua Y', 456, 2);

-- Inserções na tabela Presencial_Escola
INSERT INTO Presencial_Escola (Local, fk_Aula_Codigo_Turma)
VALUES ('Sala 101', 1),
       ('Sala 102', 2);

-- Inserções na tabela Entregador
INSERT INTO Entregador (ID_Motoboy, Valor, Endereco)
VALUES (1, 50, 'Rua Z, 789'),
       (2, 60, 'Av. Principal, 321');

-- Inserções na tabela Professor
INSERT INTO Professor (Ident, Salario, Disciplinas, fk_Usuario_ID_Usuario)
VALUES (101, 5000.00, 'Matemática', 3),
       (102, 5500.00, 'História', 4);

-- Inserções na tabela Aluno_Matricula
INSERT INTO Aluno_Matricula (Mensalidade, RG, Notas, fk_Usuario_ID_Usuario, Numero, Materias_Matriculadas, Coeficiente_Rendimento, Historico_Escolar)
VALUES (1000, 123456, 85, 5, 1, 'Matemática, Física', 7, 'Bom desempenho acadêmico'),
       (1100, 987654, 75, 6, 2, 'História, Geografia', 6, 'Desempenho satisfatório');

-- Inserções na tabela Disciplina
INSERT INTO Disciplina (Codigo, Descricao, Nome, Horario, Carga_Horaria)
VALUES (1, 'Cálculo I', 'Cálculo Diferencial e Integral', 8, 60),
       (2, 'História do Brasil', 'História do Brasil Colonial', 10, 80);

-- Inserções na tabela Aula
INSERT INTO Aula (Horario, Presenca_Alunos, Codigo_Turma)
VALUES ('08:00:00', 'Presente', 1),
       ('10:00:00', 'Ausente', 2);

-- Inserções na tabela Obrigatoria
INSERT INTO Obrigatoria (Percentual_Reprovacao, fk_Disciplina_Codigo)
VALUES (10.5, 1),
       (8.2, 2);

-- Inserções na tabela Eletiva
INSERT INTO Eletiva (Percentual_Alunos_Turma, fk_Disciplina_Codigo)
VALUES (20.3, 1),
       (15.8, 2);

-- Inserções na tabela Avaliacao
INSERT INTO Avaliacao (Numero_Questoes, Modalidade, Id_Aluno)
VALUES (20, 'Prova', 1),
       (30, 'Trabalho', 2);

-- Inserções na tabela EAD
INSERT INTO EAD (Plataforma, FK_Aula_Codigo_Turma)
VALUES ('Moodle', 1),
       ('Canvas', 2);

-- Inserções na tabela Coordenador
INSERT INTO Coordenador (Salario, Email, CPF, Telefone)
VALUES (7000.00, 'coordenador1@example.com', '12345678900', 111111111),
       (7500.00, 'coordenador2@example.com', '98765432100', 222222222);

-- Inserções na tabela Escreve
INSERT INTO Escreve (fk_Livro_ID_Livro, fk_Autor_Nome)
VALUES (1, 'Isaac Asimov'),
       (2, 'J.R.R. Tolkien');

-- Inserções na tabela Contem
INSERT INTO Contem (fk_Emprestimo_ID_Emprestimo, fk_Livro_ID_Livro)
VALUES (1, 1),
       (2, 2);

-- Inserções na tabela Comercializa
INSERT INTO Comercializa (fk_Livro_ID_Livro, fk_Editora_Nome_Editora)
VALUES (1, 'Editora A'),
       (2, 'Editora B');

-- Inserções na tabela Efetua_Consulta
INSERT INTO Efetua_Consulta (fk_Emprestimo_ID_Emprestimo, fk_Usuario_ID_Usuario)
VALUES (1, 1),
       (2, 2);

-- Inserções na tabela Cuida
INSERT INTO Cuida (fk_Balcao_Biblioteca_ID_Funcao_Biblioteca, fk_Presencial_fk_Emprestimo_ID_Emprestimo)
VALUES (1, 1),
       (2, 2);

-- Inserções na tabela Entrega
INSERT INTO Entrega (fk_Entregador_ID_Motoboy, fk_Online_fk_Emprestimo_ID_Emprestimo)
VALUES (1, 1),
       (2, 2);

-- Inserções na tabela Ministra
INSERT INTO Ministra (fk_Professor_Ident, fk_Professor_fk_Usuario_ID_Usuario, fk_Disciplina_Codigo, fk_Avaliacao_Id_Aluno)
VALUES (101, 3, 1, 1),
       (102, 4, 2, 2);

-- Inserções na tabela Estuda
INSERT INTO Estuda (fk_Aluno_Matricula_RG, fk_Aluno_Matricula_fk_Usuario_ID_Usuario, fk_Disciplina_Codigo)
VALUES (123456, 5, 1),
       (987654, 6, 2);

-- Inserções na tabela Assiste
INSERT INTO Assiste (fk_Aula_Codigo_Turma, fk_Aluno_Matricula_RG, fk_Aluno_Matricula_fk_Usuario_ID_Usuario)
VALUES (1, 123456, 5),
       (2, 987654, 6);

-- Inserções na tabela Associada
INSERT INTO Associada (fk_Aula_Codigo_Turma, fk_Disciplina_Codigo)
VALUES (1, 1),
       (2, 2);

-- Inserções na tabela Coordena
INSERT INTO Coordena (fk_Professor_Ident, fk_Professor_fk_Usuario_ID_Usuario, fk_Coordenador_CPF)
VALUES (101, 3, '12345678900'),
       (102, 4, '98765432100');

 
ALTER TABLE Online 
    ADD CONSTRAINT (FK_Online_2)
    FOREIGN KEY (fk_Emprestimo_ID_Emprestimo)
    REFERENCES Emprestimo (ID_Emprestimo)
    ON DELETE CASCADE;
 
ALTER TABLE Presencial 
    ADD CONSTRAINT (FK_Presencial_2)
    FOREIGN KEY (fk_Emprestimo_ID_Emprestimo)
    REFERENCES Emprestimo (ID_Emprestimo)
    ON DELETE CASCADE;
 
ALTER TABLE Professor 
    ADD CONSTRAINT (FK_Professor_2)
    FOREIGN KEY (fk_Usuario_ID_Usuario)
    REFERENCES Usuario (ID_Usuario)
    ON DELETE CASCADE;
 
ALTER TABLE Aluno_Matricula 
    ADD CONSTRAINT (FK_Aluno_Matricula_2)
    FOREIGN KEY (fk_Usuario_ID_Usuario)
    REFERENCES Usuario (ID_Usuario)
    ON DELETE CASCADE;
 
ALTER TABLE Obrigatoria 
    ADD CONSTRAINT (FK_Obrigatoria_2)
    FOREIGN KEY (fk_Disciplina_Codigo)
    REFERENCES Disciplina (Codigo)
    ON DELETE CASCADE;
 
ALTER TABLE Eletiva 
    ADD CONSTRAINT (FK_Eletiva_2)
    FOREIGN KEY (fk_Disciplina_Codigo)
    REFERENCES Disciplina (Codigo)
    ON DELETE CASCADE;
 
ALTER TABLE EAD 
    ADD CONSTRAINT (FK_EAD_2)
    FOREIGN KEY (FK_Aula_Codigo_Turma)
    REFERENCES Aula (Codigo_Turma)
    ON DELETE CASCADE;
 
ALTER TABLE Presencial 
    ADD CONSTRAINT (FK_Presencial_2)
    FOREIGN KEY (fk_Aula_Codigo_Turma)
    REFERENCES Aula (Codigo_Turma)
    ON DELETE CASCADE;
 
ALTER TABLE Escreve 
    ADD CONSTRAINT (FK_Escreve_1)
    FOREIGN KEY (fk_Livro_ID_Livro)
    REFERENCES Livro (ID_Livro)
    ON DELETE RESTRICT;
 
ALTER TABLE Escreve 
    ADD CONSTRAINT (FK_Escreve_2)
    FOREIGN KEY (fk_Autor_Nome)
    REFERENCES Autor (Nome)
    ON DELETE RESTRICT;
 
ALTER TABLE Contem 
    ADD CONSTRAINT (FK_Contem_1)
    FOREIGN KEY (fk_Emprestimo_ID_Emprestimo)
    REFERENCES Emprestimo (ID_Emprestimo)
    ON DELETE RESTRICT;
 
ALTER TABLE Contem 
    ADD CONSTRAINT (FK_Contem_2)
    FOREIGN KEY (fk_Livro_ID_Livro)
    REFERENCES Livro (ID_Livro)
    ON DELETE SET NULL;
 
ALTER TABLE Comercializa 
    ADD CONSTRAINT (FK_Comercializa_1)
    FOREIGN KEY (fk_Livro_ID_Livro)
    REFERENCES Livro (ID_Livro)
    ON DELETE RESTRICT;
 
ALTER TABLE Comercializa 
    ADD CONSTRAINT (FK_Comercializa_2)
    FOREIGN KEY (fk_Editora_Nome_Editora)
    REFERENCES Editora (Nome_Editora)
    ON DELETE RESTRICT;
 
ALTER TABLE Efetua_Consulta 
    ADD CONSTRAINT (FK_Efetua_Consulta_1)
    FOREIGN KEY (fk_Emprestimo_ID_Emprestimo)
    REFERENCES Emprestimo (ID_Emprestimo)
    ON DELETE RESTRICT;
 
ALTER TABLE Efetua_Consulta 
    ADD CONSTRAINT (FK_Efetua_Consulta_2)
    FOREIGN KEY (fk_Usuario_ID_Usuario)
    REFERENCES Usuario (ID_Usuario)
    ON DELETE SET NULL;
 
ALTER TABLE Cuida 
    ADD CONSTRAINT (FK_Cuida_1)
    FOREIGN KEY (fk_Balcao_Biblioteca_ID_Funcao_Biblioteca)
    REFERENCES Balcao_Biblioteca (ID_Funcao_Biblioteca)
    ON DELETE RESTRICT;
 
ALTER TABLE Cuida 
    ADD CONSTRAINT (FK_Cuida_2)
    FOREIGN KEY (fk_Presencial_fk_Emprestimo_ID_Emprestimo)
    REFERENCES Presencial (fk_Emprestimo_ID_Emprestimo)
    ON DELETE RESTRICT;
 
ALTER TABLE Entrega 
    ADD CONSTRAINT (FK_Entrega_1)
    FOREIGN KEY (fk_Entregador_ID_Motoboy)
    REFERENCES Entregador (ID_Motoboy)
    ON DELETE RESTRICT;
 
ALTER TABLE Entrega 
    ADD CONSTRAINT (FK_Entrega_2)
    FOREIGN KEY (fk_Online_fk_Emprestimo_ID_Emprestimo)
    REFERENCES Online (fk_Emprestimo_ID_Emprestimo)
    ON DELETE RESTRICT;
 
ALTER TABLE Ministra 
    ADD CONSTRAINT (FK_Ministra_1)
    FOREIGN KEY (fk_Professor_Ident, fk_Professor_fk_Usuario_ID_Usuario)
    REFERENCES Professor (Ident, fk_Usuario_ID_Usuario)
    ON DELETE NO ACTION;
 
ALTER TABLE Ministra 
    ADD CONSTRAINT (FK_Ministra_2)
    FOREIGN KEY (fk_Disciplina_Codigo)
    REFERENCES Disciplina (Codigo)
    ON DELETE RESTRICT;
 
ALTER TABLE Ministra 
    ADD CONSTRAINT (FK_Ministra_3)
    FOREIGN KEY (fk_Avaliacao_Id_Aluno)
    REFERENCES Avaliacao (Id_Aluno)
    ON DELETE NO ACTION;
 
ALTER TABLE Estuda 
    ADD CONSTRAINT (FK_Estuda_1)
    FOREIGN KEY (fk_Aluno_Matricula_RG, fk_Aluno_Matricula_fk_Usuario_ID_Usuario, ???)
    REFERENCES Aluno_Matricula (RG, fk_Usuario_ID_Usuario, ???)
    ON DELETE SET NULL;
 
ALTER TABLE Estuda 
    ADD CONSTRAINT (FK_Estuda_2)
    FOREIGN KEY (fk_Disciplina_Codigo)
    REFERENCES Disciplina (Codigo)
    ON DELETE SET NULL;
 
ALTER TABLE Assiste 
    ADD CONSTRAINT (FK_Assiste_1)
    FOREIGN KEY (fk_Aula_Codigo_Turma)
    REFERENCES Aula (Codigo_Turma)
    ON DELETE RESTRICT;
 
ALTER TABLE Assiste 
    ADD CONSTRAINT (FK_Assiste_2)
    FOREIGN KEY (fk_Aluno_Matricula_RG, fk_Aluno_Matricula_fk_Usuario_ID_Usuario, ???)
    REFERENCES Aluno_Matricula (RG, fk_Usuario_ID_Usuario, ???)
    ON DELETE SET NULL;
 
ALTER TABLE Associada 
    ADD CONSTRAINT (FK_Associada_1)
    FOREIGN KEY (fk_Aula_Codigo_Turma)
    REFERENCES Aula (Codigo_Turma)
    ON DELETE RESTRICT;
 
ALTER TABLE Associada 
    ADD CONSTRAINT (FK_Associada_2)
    FOREIGN KEY (fk_Disciplina_Codigo)
    REFERENCES Disciplina (Codigo)
    ON DELETE RESTRICT;
 
ALTER TABLE Coordena 
    ADD CONSTRAINT (FK_Coordena_1)
    FOREIGN KEY (fk_Professor_Ident, fk_Professor_fk_Usuario_ID_Usuario)
    REFERENCES Professor (Ident, fk_Usuario_ID_Usuario)
    ON DELETE SET NULL;
 
ALTER TABLE Coordena 
    ADD CONSTRAINT (FK_Coordena_2)
    FOREIGN KEY (fk_Coordenador_CPF)
    REFERENCES Coordenador (CPF)
    ON DELETE SET NULL;