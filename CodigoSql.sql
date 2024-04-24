CREATE TABLE Livro (
    Titulo VARCHAR,
    ID_Livro INT PRIMARY KEY,
    Sessao VARCHAR,
    Numeros_De_Pags INT,
    Autor VARCHAR,
    Ano INT,
    Genero VARCHAR,
    Numero INT,
    fk_Emprestimo_ID_Emprestimo INT,
    fk_Editora_Nome_Editora VARCHAR
);

CREATE TABLE Autor (
    Nacionalidade VARCHAR,
    Nome VARCHAR PRIMARY KEY,
    Genero_Literario VARCHAR,
    Data_Nascimento DATE
);

CREATE TABLE Usuario (
    ID_Usuario INT PRIMARY KEY,
    Telefone VARCHAR,
    Email VARCHAR,
    Endereco VARCHAR,
    Data_de_Nascimento DATE,
    CPF VARCHAR,
    Nome VARCHAR,
    Idade INT
);

CREATE TABLE Emprestimo (
    ID_Emprestimo INT PRIMARY KEY,
    ID_Livro INT,
    ID_Usuario INT,
    Data_De_Emprestimo DATE,
    Data_De_Devolucao_Efetiva DATE,
    Data_De_Devolucao DATE,
    Disponibilidade VARCHAR
);

CREATE TABLE Bibliotecario (
    Nome_Funcionario VARCHAR,
    ID_Funcao_Biblioteca INT PRIMARY KEY
);

CREATE TABLE Editora (
    Nome_Editora VARCHAR PRIMARY KEY,
    Telefone VARCHAR,
    Email VARCHAR
);

CREATE TABLE Online (
    Aplicativo VARCHAR,
    Web_Site VARCHAR,
    fk_Emprestimo_ID_Emprestimo INT PRIMARY KEY,
    fk_Entregador_ID_Motoboy INT
);

CREATE TABLE Presencial_Biblioteca (
    Rua VARCHAR,
    Numero INT,
    fk_Emprestimo_ID_Emprestimo INT PRIMARY KEY
);

CREATE TABLE Entregador (
    ID_Motoboy INT PRIMARY KEY,
    Valor DECIMAL,
    Endereco VARCHAR
);

CREATE TABLE Professor (
    Disciplinas VARCHAR,
    Salario DECIMAL,
    fk_Usuario_ID_Usuario INT PRIMARY KEY
);

CREATE TABLE Aluno_Matricula (
    Mensalidade DECIMAL,
    RG VARCHAR,
    Notas DECIMAL,
    fk_Usuario_ID_Usuario INT,
    Numero INT,
    Materias_Matriculadas VARCHAR,
    Coeficiente_Rendimento DECIMAL,
    Historico_Escolar VARCHAR,
    PRIMARY KEY (fk_Usuario_ID_Usuario, Numero)
);

CREATE TABLE Disciplina (
    Codigo INT PRIMARY KEY,
    Descricao VARCHAR,
    Nome VARCHAR,
    Horario TIME,
    Carga_Horaria DECIMAL
);

CREATE TABLE Aula (
    Horario TIME,
    Presenca_Alunos VARCHAR,
    Codigo_Turma INT PRIMARY KEY,
    fk_Disciplina_Codigo INT
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
    Modalidade VARCHAR,
    Id_Aluno INT PRIMARY KEY
);

CREATE TABLE EAD (
    Plataforma VARCHAR,
    FK_Aula_Codigo_Turma INT PRIMARY KEY
);

CREATE TABLE Presencial_Escola (
    Local VARCHAR,
    fk_Aula_Codigo_Turma INT PRIMARY KEY
);

CREATE TABLE Coordenador (
    Salario DECIMAL,
    Email VARCHAR,
    CPF VARCHAR PRIMARY KEY,
    Telefone VARCHAR,
    fk_Professor_fk_Usuario_ID_Usuario INT
);

CREATE TABLE Escreve (
    fk_Livro_ID_Livro INT,
    fk_Autor_Nome VARCHAR
);

CREATE TABLE Efetua_Consulta (
    fk_Usuario_ID_Usuario INT,
    fk_Emprestimo_ID_Emprestimo INT
);

CREATE TABLE Auxilia (
    fk_Presencial_Biblioteca_fk_Emprestimo_ID_Emprestimo INT,
    fk_Bibliotecario_ID_Funcao_Biblioteca INT
);

CREATE TABLE Ministra (
    fk_Professor_fk_Usuario_ID_Usuario INT,
    fk_Disciplina_Codigo INT,
    fk_Avaliacao_Id_Aluno INT
);

CREATE TABLE Estuda (
    fk_Aluno_Matricula_fk_Usuario_ID_Usuario INT,
    fk_Disciplina_Codigo INT
);

CREATE TABLE Assiste (
    fk_Aluno_Matricula_fk_Usuario_ID_Usuario INT,
    fk_Aula_Codigo_Turma INT
);
 
ALTER TABLE Livro ADD CONSTRAINT FK_Livro_2
    FOREIGN KEY (fk_Emprestimo_ID_Emprestimo)
    REFERENCES Emprestimo (ID_Emprestimo)
    ON DELETE RESTRICT;
 
ALTER TABLE Livro ADD CONSTRAINT FK_Livro_3
    FOREIGN KEY (fk_Editora_Nome_Editora)
    REFERENCES Editora (Nome_Editora)
    ON DELETE RESTRICT;
 
ALTER TABLE Online ADD CONSTRAINT FK_Online_2
    FOREIGN KEY (fk_Emprestimo_ID_Emprestimo)
    REFERENCES Emprestimo (ID_Emprestimo)
    ON DELETE CASCADE;
 
ALTER TABLE Online ADD CONSTRAINT FK_Online_3
    FOREIGN KEY (fk_Entregador_ID_Motoboy)
    REFERENCES Entregador (ID_Motoboy)
    ON DELETE RESTRICT;
 
ALTER TABLE Presencial_Biblioteca ADD CONSTRAINT FK_Presencial_Biblioteca_2
    FOREIGN KEY (fk_Emprestimo_ID_Emprestimo)
    REFERENCES Emprestimo (ID_Emprestimo)
    ON DELETE CASCADE;
 
ALTER TABLE Professor ADD CONSTRAINT FK_Professor_2
    FOREIGN KEY (fk_Usuario_ID_Usuario)
    REFERENCES Usuario (ID_Usuario)
    ON DELETE CASCADE;
 
ALTER TABLE Aluno_Matricula ADD CONSTRAINT FK_Aluno_Matricula_2
    FOREIGN KEY (fk_Usuario_ID_Usuario)
    REFERENCES Usuario (ID_Usuario)
    ON DELETE CASCADE;
 
ALTER TABLE Aula ADD CONSTRAINT FK_Aula_2
    FOREIGN KEY (fk_Disciplina_Codigo)
    REFERENCES Disciplina (Codigo)
    ON DELETE RESTRICT;
 
ALTER TABLE Obrigatoria ADD CONSTRAINT FK_Obrigatoria_2
    FOREIGN KEY (fk_Disciplina_Codigo)
    REFERENCES Disciplina (Codigo)
    ON DELETE CASCADE;
 
ALTER TABLE Eletiva ADD CONSTRAINT FK_Eletiva_2
    FOREIGN KEY (fk_Disciplina_Codigo)
    REFERENCES Disciplina (Codigo)
    ON DELETE CASCADE;
 
ALTER TABLE EAD ADD CONSTRAINT FK_EAD_2
    FOREIGN KEY (FK_Aula_Codigo_Turma)
    REFERENCES Aula (Codigo_Turma)
    ON DELETE CASCADE;
 
ALTER TABLE Presencial_Escola ADD CONSTRAINT FK_Presencial_Escola_2
    FOREIGN KEY (fk_Aula_Codigo_Turma)
    REFERENCES Aula (Codigo_Turma)
    ON DELETE CASCADE;
 
ALTER TABLE Coordenador ADD CONSTRAINT FK_Coordenador_2
    FOREIGN KEY (fk_Professor_fk_Usuario_ID_Usuario)
    REFERENCES Professor (fk_Usuario_ID_Usuario)
    ON DELETE SET NULL;
 
ALTER TABLE Escreve ADD CONSTRAINT FK_Escreve_1
    FOREIGN KEY (fk_Livro_ID_Livro)
    REFERENCES Livro (ID_Livro)
    ON DELETE RESTRICT;
 
ALTER TABLE Escreve ADD CONSTRAINT FK_Escreve_2
    FOREIGN KEY (fk_Autor_Nome)
    REFERENCES Autor (Nome)
    ON DELETE RESTRICT;
 
ALTER TABLE Efetua_Consulta ADD CONSTRAINT FK_Efetua_Consulta_1
    FOREIGN KEY (fk_Usuario_ID_Usuario)
    REFERENCES Usuario (ID_Usuario)
    ON DELETE RESTRICT;
 
ALTER TABLE Efetua_Consulta ADD CONSTRAINT FK_Efetua_Consulta_2
    FOREIGN KEY (fk_Emprestimo_ID_Emprestimo)
    REFERENCES Emprestimo (ID_Emprestimo)
    ON DELETE SET NULL;
 
ALTER TABLE Auxilia ADD CONSTRAINT FK_Auxilia_1
    FOREIGN KEY (fk_Presencial_Biblioteca_fk_Emprestimo_ID_Emprestimo)
    REFERENCES Presencial_Biblioteca (fk_Emprestimo_ID_Emprestimo)
    ON DELETE RESTRICT;
 
ALTER TABLE Auxilia ADD CONSTRAINT FK_Auxilia_2
    FOREIGN KEY (fk_Bibliotecario_ID_Funcao_Biblioteca)
    REFERENCES Bibliotecario (ID_Funcao_Biblioteca)
    ON DELETE RESTRICT;
 
ALTER TABLE Ministra ADD CONSTRAINT FK_Ministra_Professor_Disciplina_Avaliacao_1
    FOREIGN KEY (fk_Professor_fk_Usuario_ID_Usuario)
    REFERENCES Professor (fk_Usuario_ID_Usuario)
    ON DELETE NO ACTION;
 
ALTER TABLE Ministra ADD CONSTRAINT FK_Ministra_Professor_Disciplina_Avaliacao_2
    FOREIGN KEY (fk_Disciplina_Codigo)
    REFERENCES Disciplina (Codigo)
    ON DELETE RESTRICT;
 
ALTER TABLE Ministra ADD CONSTRAINT FK_Ministra_Professor_Disciplina_Avaliacao_3
    FOREIGN KEY (fk_Avaliacao_Id_Aluno)
    REFERENCES Avaliacao (Id_Aluno)
    ON DELETE NO ACTION;
 
 
ALTER TABLE Estuda ADD CONSTRAINT FK_Estuda_2
    FOREIGN KEY (fk_Disciplina_Codigo)
    REFERENCES Disciplina (Codigo)
    ON DELETE SET NULL;

ALTER TABLE Estuda
	ADD CONSTRAINT FK_Estuda_1
	FOREIGN KEY (fk_Aluno_Matricula_fk_Usuario_ID_Usuario, fk_Disciplina_Codigo)
	REFERENCES Aluno_Matricula (fk_Usuario_ID_Usuario, Numero)
	ON DELETE SET NULL;

ALTER TABLE Assiste
	ADD CONSTRAINT FK_Assiste_1
	FOREIGN KEY (fk_Aluno_Matricula_fk_Usuario_ID_Usuario, fk_Aula_Codigo_Turma)
	REFERENCES Aluno_Matricula (fk_Usuario_ID_Usuario, Numero)
	ON DELETE RESTRICT;
 
ALTER TABLE Assiste ADD CONSTRAINT FK_Assiste_2
    FOREIGN KEY (fk_Aula_Codigo_Turma)
    REFERENCES Aula (Codigo_Turma)
    ON DELETE RESTRICT;
    
 