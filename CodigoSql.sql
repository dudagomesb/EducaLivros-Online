/* Lógico_1: */

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
    ADD CONSTRAINT (FK_Ministra_3
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

