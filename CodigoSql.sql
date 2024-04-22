CREATE TABLE Livro (
    Genero VARCHAR(60),
    Autor VARCHAR(100),
    Titulo VARCHAR(100),
    ID_Livro INT PRIMARY KEY NOT NULL,
    Sessao VARCHAR(60),
    Numeros_De_Pags INT CHECK (Numeros_De_Pags > 0)
);

CREATE TABLE Autor (
    Nacionalidade VARCHAR(60),
    Nome VARCHAR(60) PRIMARY KEY,
    Genero_Literario VARCHAR(60),
    Data_Nascimento DATE
);

CREATE TABLE Usuario (
    ID_Usuario INT PRIMARY KEY,
    Telefone INT  NOT NULL UNIQUE,
    Email VARCHAR(60) NOT NULL UNIQUE,
    Endereco VARCHAR(30),
    Data_de_Nascimento DATE,
    CPF VARCHAR(9) NOT NULL UNIQUE,
    Nome VARCHAR(60),
    Idade INT CHECK (Idade > 0)
);

CREATE TABLE Emprestimo (
    ID_Emprestimo INT PRIMARY KEY,
    ID_Livro INT NOT NULL,
    ID_Usuario INT NOT NULL,
    Data_De_Emprestimo DATE NOT NULL,
    Data_De_Devolucao_Efetiva DATE NOT NULL,
    Data_De_Devolucao DATE NOT NULL,
    Disponibilidade VARCHAR(60)
);

CREATE TABLE Balcao_Biblioteca (
    Nome_Funcionario VARCHAR(60),
    ID_Funcao_Biblioteca INT PRIMARY KEY
);

CREATE TABLE Editora (
    Nome_Editora VARCHAR(60) PRIMARY KEY,
    Telefone INT NOT NULL UNIQUE,
    Email VARCHAR(60)
);

CREATE TABLE Aula (
    Horario TIME,
    Presenca_Alunos VARCHAR(60),
    Codigo_Turma INT PRIMARY KEY
);

CREATE TABLE Entregador (
    ID_Motoboy INT PRIMARY KEY,
    Valor INT,
    Endereco VARCHAR(60)
);

CREATE TABLE Professor (
    Ident INT NOT NULL UNIQUE ,
    Salario DECIMAL,
    Disciplinas VARCHAR(60),
    fk_Usuario_ID_Usuario INT,
    PRIMARY KEY (Ident, fk_Usuario_ID_Usuario)
);

CREATE TABLE Aluno_Matricula (
    Mensalidade DECIMAL,
    RG INT NOT NULL UNIQUE,
    Notas DECIMAL,
    fk_Usuario_ID_Usuario INT,
    Numero INT NOT NULL UNIQUE,
    Materias_Matriculadas VARCHAR(60),
    Coeficiente_Rendimento DECIMAL,
    Historico_Escolar VARCHAR(60),
    PRIMARY KEY (RG, fk_Usuario_ID_Usuario, Numero),
    FOREIGN KEY (fk_Usuario_ID_Usuario) REFERENCES Usuario (ID_Usuario)
);

CREATE TABLE Disciplina (
    Codigo INT PRIMARY KEY,
    Descricao VARCHAR(60),
    Nome VARCHAR(60),
    Horario TIME,
    Carga_Horaria TIME
);


CREATE TABLE Obrigatoria (
    Percentual_Reprovacao DECIMAL,
    fk_Disciplina_Codigo INT PRIMARY KEY,
    FOREIGN KEY (fk_Disciplina_Codigo) REFERENCES Disciplina (Codigo)
);

CREATE TABLE Eletiva (
    Percentual_Alunos_Turma DECIMAL,
    fk_Disciplina_Codigo INT PRIMARY KEY,
    FOREIGN KEY (fk_Disciplina_Codigo) REFERENCES Disciplina (Codigo)
);

CREATE TABLE Avaliacao (
    Numero_Questoes INT,
    Modalidade VARCHAR(60),
    Id_Aluno INT PRIMARY KEY
);


CREATE TABLE Escreve (
    fk_Livro_ID_Livro INT,
    fk_Autor_Nome VARCHAR(60),
    FOREIGN KEY (fk_Livro_ID_Livro) REFERENCES Livro (ID_Livro)
);

CREATE TABLE Contem (
    fk_Emprestimo_ID_Emprestimo INT,
    fk_Livro_ID_Livro INT,
    FOREIGN KEY (fk_Emprestimo_ID_Emprestimo) REFERENCES Emprestimo (ID_Emprestimo),
    FOREIGN KEY (fk_Livro_ID_Livro) REFERENCES Livro (ID_Livro)
);

CREATE TABLE Comercializa (
    fk_Livro_ID_Livro INT,
    fk_Editora_Nome_Editora VARCHAR(60),
    FOREIGN KEY (fk_Livro_ID_Livro) REFERENCES Livro (ID_Livro),
    FOREIGN KEY (fk_Editora_Nome_Editora) REFERENCES Editora (Nome_Editora)
);

CREATE TABLE Efetua_Consulta (
    fk_Emprestimo_ID_Emprestimo INT,
    fk_Usuario_ID_Usuario INT,
    FOREIGN KEY (fk_Emprestimo_ID_Emprestimo) REFERENCES Emprestimo (ID_Emprestimo),
    FOREIGN KEY (fk_Usuario_ID_Usuario) REFERENCES Usuario (ID_Usuario)
);

CREATE TABLE Cuida (
    fk_Balcao_Biblioteca_ID_Funcao_Biblioteca INT,
    fk_Presencial_fk_Emprestimo_ID_Emprestimo INT,
    FOREIGN KEY (fk_Balcao_Biblioteca_ID_Funcao_Biblioteca) REFERENCES Balcao_Biblioteca (ID_Funcao_Biblioteca),
    FOREIGN KEY (fk_Presencial_fk_Emprestimo_ID_Emprestimo) REFERENCES Emprestimo (ID_Emprestimo)
);

CREATE TABLE Entrega (
    fk_Entregador_ID_Motoboy INT,
    fk_Online_fk_Emprestimo_ID_Emprestimo INT,
    FOREIGN KEY (fk_Entregador_ID_Motoboy) REFERENCES Entregador (ID_Motoboy),
    FOREIGN KEY (fk_Online_fk_Emprestimo_ID_Emprestimo) REFERENCES Emprestimo (ID_Emprestimo)
);

CREATE TABLE Ministra (
    fk_Professor_Ident INT,
    fk_Professor_fk_Usuario_ID_Usuario INT,
    fk_Disciplina_Codigo INT,
    fk_Avaliacao_Id_Aluno INT,
    FOREIGN KEY (fk_Professor_Ident, fk_Professor_fk_Usuario_ID_Usuario) REFERENCES Professor (Ident, fk_Usuario_ID_Usuario),
    FOREIGN KEY (fk_Disciplina_Codigo) REFERENCES Disciplina (Codigo),
    FOREIGN KEY (fk_Avaliacao_Id_Aluno) REFERENCES Avaliacao (Id_Aluno)
);

CREATE TABLE Estuda (
    fk_Aluno_Matricula_RG INT ,
    fk_Aluno_Matricula_fk_Usuario_ID_Usuario INT,
    fk_Aluno_Matricula_Numero INT,
    fk_Disciplina_Codigo INT,
    PRIMARY KEY (fk_Aluno_Matricula_RG, fk_Aluno_Matricula_fk_Usuario_ID_Usuario, fk_Aluno_Matricula_Numero, fk_Disciplina_Codigo),
    FOREIGN KEY (fk_Aluno_Matricula_RG, fk_Aluno_Matricula_fk_Usuario_ID_Usuario, fk_Aluno_Matricula_Numero) 
        REFERENCES Aluno_Matricula (RG, fk_Usuario_ID_Usuario, Numero),
    FOREIGN KEY (fk_Disciplina_Codigo) REFERENCES Disciplina (Codigo)
);

CREATE TABLE Assiste (
    fk_Aula_Codigo_Turma INT,
    fk_Aluno_Matricula_RG INT,
    fk_Aluno_Matricula_fk_Usuario_ID_Usuario INT,
    fk_Aluno_Matricula_Numero INT,
    FOREIGN KEY (fk_Aula_Codigo_Turma) REFERENCES Aula (Codigo_Turma),
    FOREIGN KEY (fk_Aluno_Matricula_RG, fk_Aluno_Matricula_fk_Usuario_ID_Usuario, fk_Aluno_Matricula_Numero) REFERENCES Aluno_Matricula (RG, fk_Usuario_ID_Usuario, Numero)
);
CREATE TABLE Associada (
    fk_Aula_Codigo_Turma INT,
    fk_Disciplina_Codigo INT,
    FOREIGN KEY (fk_Aula_Codigo_Turma) REFERENCES Aula (Codigo_Turma),
    FOREIGN KEY (fk_Disciplina_Codigo) REFERENCES Disciplina (Codigo)
);

CREATE TABLE Coordena (
    fk_Professor_Ident INT,
    fk_Professor_fk_Usuario_ID_Usuario INT,
    fk_Coordenador_CPF INT,
    FOREIGN KEY (fk_Professor_Ident, fk_Professor_fk_Usuario_ID_Usuario) REFERENCES Professor (Ident, fk_Usuario_ID_Usuario),
    FOREIGN KEY (fk_Coordenador_CPF) REFERENCES Coordenador (CPF)
);


INSERT INTO Livro (Genero, Autor, Titulo, ID_Livro, Sessao, Numeros_De_Pags)
VALUES ('Ficcao Cientifica', 'Isaac Asimov', 'Fundação', 1, 'A1', 300),
       ('Fantasia', 'J.R.R. Tolkien', 'O Senhor dos Anéis', 2, 'B2', 500),
       ('Biologia', 'J.R.R. Tolkien', 'Ouvido', 3, 'C1', 500),
       ('Biologia', 'J.R.R. Tolkien', 'Corpo', 4, 'C1', 500),
       ('Biologia', 'J.R.R. Tolkien', 'Olho', 5, 'C2', 500);

INSERT INTO Autor (Nacionalidade, Nome, Genero_Literario, Data_Nascimento)
VALUES ('Americano', 'Isaac Asimov', 'Ficção Científica', '1920-01-01'),
       ('Britânico', 'J.R.R. Tolkien', 'Fantasia', '1892-01-01'),
       ('Desconhecido', 'John Doe', 'Mistério', NULL);

INSERT INTO Usuario (ID_Usuario, Telefone, Email, Endereco, Data_de_Nascimento, CPF, Nome, Idade)
VALUES (1, 123456789, 'usuario1@example.com', 'Rua A, 123', '1990-01-01', '123.456.789-00', 'Usuário 1', 34),
       (2, 987654321, 'usuario2@example.com', 'Rua B, 456', '1985-05-15', '987.654.321-00', 'Usuário 2', 39);

INSERT INTO Emprestimo (ID_Emprestimo, ID_Livro, ID_Usuario, Data_De_Emprestimo, Data_De_Devolucao_Efetiva, Data_De_Devolucao, Disponibilidade)
VALUES (1, 1, 1, '2024-04-01', '2024-04-15', '2024-05-10', 'Disponível'),
       (2, 2, 2, '2024-04-05', '2024-04-20', '2024-05-10', 'Emprestado');

INSERT INTO Balcao_Biblioteca (Nome_Funcionario, ID_Funcao_Biblioteca)
VALUES ('João Silva', 1),
       ('Maria Souza', 2);

INSERT INTO Editora (Nome_Editora, Telefone, Email)
VALUES ('Editora A', 111111111, 'editoraA@example.com'),
       ('Editora B', 222222222, 'editoraB@example.com');

INSERT INTO Aula (Horario, Presenca_Alunos, Codigo_Turma)
VALUES ('08:00:00', 'Presente', 1),
       ('10:00:00', 'Ausente', 2);

INSERT INTO Entregador (ID_Motoboy, Valor, Endereco)
VALUES (1, 50, 'Rua Z, 789'),
       (2, 60, 'Av. Principal, 321');

INSERT INTO Professor (Ident, Salario, Disciplinas, fk_Usuario_ID_Usuario)
VALUES (101, 5000.00, 'Matemática', 3),
       (102, 6000.00, 'Português', 4);

INSERT INTO Aluno_Matricula (Mensalidade, RG, Notas, fk_Usuario_ID_Usuario, Numero, Materias_Matriculadas, Coeficiente_Rendimento, Historico_Escolar)
VALUES (1000, 123456, 85, 1, 1, 'Matemática, Física', 7, 'Bom desempenho acadêmico'),
       (1100, 987654, 75, 2, 2, 'História, Geografia', 6, 'Desempenho satisfatório');

INSERT INTO Disciplina (Codigo, Descricao, Nome, Horario, Carga_Horaria)
VALUES (1, 'Cálculo I', 'Cálculo Diferencial e Integral', '08:00:00', '60:00:00'),
       (2, 'História do Brasil', 'História do Brasil Colonial', '10:00:00', '80:00:00');

INSERT INTO Obrigatoria (Percentual_Reprovacao, fk_Disciplina_Codigo)
VALUES (10.5, 1),
       (8.2, 2);

INSERT INTO Eletiva (Percentual_Alunos_Turma, fk_Disciplina_Codigo)
VALUES (20.3, 1),
       (15.8, 2);

INSERT INTO Avaliacao (Numero_Questoes, Modalidade, Id_Aluno)
VALUES (20, 'Prova', 1),
       (30, 'Trabalho', 2);

INSERT INTO Escreve (fk_Livro_ID_Livro, fk_Autor_Nome)
VALUES (1, 'Isaac Asimov'),
       (2, 'J.R.R. Tolkien');

INSERT INTO Contem (fk_Emprestimo_ID_Emprestimo, fk_Livro_ID_Livro)
VALUES (1, 1),
       (2, 2);

INSERT INTO Comercializa (fk_Livro_ID_Livro, fk_Editora_Nome_Editora)
VALUES (1, 'Editora A'),
       (2, 'Editora B');

INSERT INTO Efetua_Consulta (fk_Emprestimo_ID_Emprestimo, fk_Usuario_ID_Usuario)
VALUES (1, 1),
       (2, 2);

INSERT INTO Cuida (fk_Balcao_Biblioteca_ID_Funcao_Biblioteca, fk_Presencial_fk_Emprestimo_ID_Emprestimo)
VALUES (1, 1),
       (2, 2);

INSERT INTO Entrega (fk_Entregador_ID_Motoboy, fk_Online_fk_Emprestimo_ID_Emprestimo)
VALUES (1, 1),
       (2, 2);

INSERT INTO Ministra (fk_Professor_Ident, fk_Professor_fk_Usuario_ID_Usuario, fk_Disciplina_Codigo, fk_Avaliacao_Id_Aluno)
VALUES (101, 3, 1, 1),
       (102, 4, 2, 2);

INSERT INTO Estuda (fk_Aluno_Matricula_RG, fk_Aluno_Matricula_fk_Usuario_ID_Usuario, fk_Aluno_Matricula_Numero, fk_Disciplina_Codigo)
VALUES (123456, 1, 1, 1),
       (987654, 2, 2, 2);

INSERT INTO Assiste (fk_Aula_Codigo_Turma, fk_Aluno_Matricula_RG, fk_Aluno_Matricula_fk_Usuario_ID_Usuario, fk_Aluno_Matricula_Numero)
VALUES (1, 123456, 1, 1),
       (2, 987654, 2, 2);

INSERT INTO Associada (fk_Aula_Codigo_Turma, fk_Disciplina_Codigo)
VALUES (1, 1),
       (2, 2);

INSERT INTO Coordena (fk_Professor_Ident, fk_Professor_fk_Usuario_ID_Usuario, fk_Coordenador_CPF)
VALUES (101, 3, '123.456.789-00'),
       (102, 4, '987.654.321-00');

UPDATE Usuario
SET Email = 'novo_email@example.com'
WHERE ID_Usuario = 1;

DELETE FROM Usuario
WHERE ID_Usuario = 2;

UPDATE Emprestimo
SET Data_De_Devolucao = '2024-04-20'
WHERE ID_Emprestimo = 1;

DELETE FROM Emprestimo
WHERE ID_Emprestimo = 2;

UPDATE Professor
SET Salario = 5500.00
WHERE Ident = 101;

DELETE FROM Professor
WHERE Ident = 102;
