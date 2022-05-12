create user gustavo with encrypted password 'gust04' superuser createdb createrole;



     create database uvv
     WITH 
     OWNER = gustavo
     ENCODING = 'UTF8'
     template = template0
     LC_COLLATE = 'pt_BR.UTF-8'
     LC_CTYPE = 'pt_BR.UTF-8'
        ALLOW_CONNECTIONS = true;
\c uvv ;

create schema elmasri authorization gustavo;
grant all privileges on all tables in schema elmasri to gustavo;
SET search_path TO elmasri, "$gustavo", public;

CREATE TABLE "funcionario" (
  "cpf" CHAR(11) PRIMARY KEY NOT NULL,
  "primeiro_nome" VARCHAR(15) NOT NULL,
  "nome_meio" CHAR(1),
  "ultimo_nome" VARCHAR(15) NOT NULL,
  "data_nascimento" DATE,
  "endereco" VARCHAR(30),
  "sexo" CHAR(1),
  "salario" NUMERIC(10, 2),
  "cpf_supervisor" CHAR(11) ,
  "numero_departamento" INTEGER NOT NULL
);
COMMENT ON TABLE funcionario IS 'Tabela "funcionario" informações dos funcionários, cpf, nome, data de nascimento, endereço, sexo, salário, cpf do supervisor.';

CREATE TABLE "departamento" (
  "numero_departamento" INTEGER PRIMARY KEY NOT NULL,
  "nome_departamento" VARCHAR(15) NOT NULL,
  "cpf_gerente" CHAR(11) NOT NULL,
  "data_inicio_gerente" DATE
);
COMMENT ON TABLE departamento IS 'Tabela "departamento" informações do departamento, o número e o nome dele, cpf do gerente, data que começou o gerente.';

CREATE TABLE "projeto" (
  "numero_projeto" INTEGER PRIMARY KEY NOT NULL,
  "nome_projeto" VARCHAR(15) NOT NULL,
  "local_projeto" VARCHAR(150),
  "numero_departamento" INTEGER NOT NULL
);
COMMENT ON TABLE projeto IS 'Tabela "projeto" informações sobre os projetos desenvolvidos, número, nome, local do projeto, além do departamento.';
COMMENT ON COLUMN projeto.nome_projeto IS 'Criação da UNIQUE KEY ou ALTERNATE KEY no atributo "nome_projeto".';

CREATE TABLE "localizacoes_departamento" (
  "numero_departamento" INTEGER NOT NULL,
  "local" VARCHAR(15) NOT NULL,
  PRIMARY KEY ("numero_departamento", "local")
);
COMMENT ON TABLE localizacoes_departamento IS 'Tabela "localizacoes_departamento" o número do departamento e o local.';

CREATE TABLE "trabalha_em" (
  "cpf_funcionario" CHAR(11) NOT NULL,
  "numero_projeto" INTEGER NOT NULL,
  "horas" NUMERIC(3, 1) NOT NULL,
  PRIMARY KEY ("cpf_funcionario", "numero_projeto")
);
COMMENT ON TABLE trabalha_em IS 'Tabela "trabalha_em" é responsável por armazenar em que projeto cada funcionário trabalha, referindo-se os atributos do cpf do funcionário, o nome do projeto que ele trabalha e as horas.';

CREATE TABLE "dependente" (
  "cpf_funcionario" CHAR(11) NOT NULL,
  "nome_dependente" VARCHAR(15) NOT NULL,
  "sexo" CHAR(1),
  "data_nascimento" DATE,
  "parentesco" VARCHAR(15),
  PRIMARY KEY ("cpf_funcionario", "nome_dependente")
);
COMMENT ON TABLE dependente IS 'Tabela "dependente" mostra os dependentes associados a cada funcionário. Os atributos da tabela são nome, cpf funcionario, data de nascimento, sexo e parentesco dos dependentes.';

insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('João', 'B', 'Silva', 12345678966, '1965-01-09', 'R.dasFlores, 751, SP, SP', 'M', 30000, 5);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Fernando', 'T', 'Wong', 33344555587, '1955-12-08', 'R.daLapa, 34, SP, SP', 'M', 40000, 5);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Alice', 'J', 'Zelaya', 99988777767, '1968-01-19', 'R.SouzaLima, 35, CBW, PR', 'F', 25000, 4);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Jennifer', 'S', 'Souza', 98765432168, '1941-06-20', 'Av.Art.DeLima, 54, S.André, SP', 'F', 43000, 4);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Ronaldo', 'K', 'Lima', 66688444476, '1962-09-15', 'R.Rebouças, 65, RMP, SP', 'M', 38000, 5);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Joice', 'A', 'Leite', 45345345376, '1972-07-31', 'Av.LucasObes, 74, SP, SP', 'F', 25000, 5);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('André', 'V', 'Pereira', 98798798733, '1969-03-29', 'R.Timbira, 35, SP, SP', 'M', 25000, 4);
insert into funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
values ('Jorge', 'E', 'Brito', 88866555576, '1937-11-10', 'R.doHorto, 35, SP, SP', 'M', 55000, 1);

insert into departamento ( nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
values
('Pesquisa', 5, '33344555587', '22-05-1988'),
('Administração', 4, '98765432168', '01-01-1995'),
('Matriz', 1, '88866555576', '19-06-1981');

insert into localizacoes_departamento (numero_departamento, local)
values (1, 'São Paulo');
insert into localizacoes_departamento (numero_departamento, local)
values (4, 'Mauá');
insert into localizacoes_departamento (numero_departamento, local)
values (5, 'Santo André');
insert into localizacoes_departamento (numero_departamento, local)
values (5, 'Itu');
insert into localizacoes_departamento (numero_departamento, local)
values (5, 'São Paulo');

insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('ProdutoX', 1, 'Santo André', 5);
insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('ProdutoY', 2, 'Itu', 5);
insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('ProdutoZ', 3, 'São Paulo', 5);
insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('Informatização', 10, 'Mauá', 4);
insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('Reorganização', 20, 'São Paulo', 1);
insert into projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
values ('Novosbenefícios', 30, 'Mauá', 4);

insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (33344555587, 'Alicia', 'F', '1986-04-05', 'Filha'); 
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (33344555587, 'Tiago', 'M', '1983-10-25', 'Filho'); 
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (33344555587, 'Janaína', 'F', '1958-05-03', 'Esposa');
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (98765432168, 'Antonio', 'M', '1942-02-28', 'Marido');
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (12345678966, 'Michael', 'M', '1988-01-04', 'Filho');
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (12345678966, 'Alicia', 'F', '1988-12-30', 'Filha');
insert into dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
values (12345678966, 'Elizabeth', 'F', '1967-05-05', 'Esposa');

insert into trabalha_em (cpf_funcionario, numero_projeto, horas) 
values ('12345678966', '1', '32.5'),
       ('12345678966', '2', '7.5'),
       ('66688444476', '3', '40'),
       ('45345345376', '1', '20'),
       ('45345345376', '2', '20'),
       ('33344555587', '2', '10'),
       ('33344555587', '3', '10'),
       ('33344555587', '10', '10'),
       ('33344555587', '20', '10'),
       ('99988777767', '30', '30'),
       ('99988777767', '10', '10'),
       ('98798798733', '10', '35'),
       ('98798798733', '30', '5'),
       ('98765432168', '30', '20'),
       ('98765432168', '20', '15'),
       ('88866555576', '20', '0');

COMMENT ON COLUMN "projeto"."nome_projeto" IS 'Criação da UNIQUE KEY ou ALTERNATE KEY no atributo "nome_projeto".';

ALTER TABLE "funcionario" ADD FOREIGN KEY ("cpf_supervisor") REFERENCES "funcionario" ("cpf") ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMENT ON TABLE funcionario IS 'A tabela "funcionario" foi alterada para adicionar uma foreign key em "cpf_supervisor" remetente a "cpf", ambas na mesma tabela.';

ALTER TABLE "dependente" ADD FOREIGN KEY ("cpf_funcionario") REFERENCES "funcionario" ("cpf") ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMENT ON TABLE dependente IS 'Alteração na tabela "dependente" para adicionar uma foreign key ao atributo "cpf_funcionario" referente a "cpf" na tabela "funcionario".';

ALTER TABLE "trabalha_em" ADD FOREIGN KEY ("cpf_funcionario") REFERENCES "funcionario" ("cpf") ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMENT ON TABLE trabalha_em IS 'Alteração na tabela "trabalha_em" para adicionar uma foreign key ao atributo "cpf_funcionario" referente a "cpf" na tabela "funcionario".';

ALTER TABLE "departamento" ADD FOREIGN KEY ("cpf_gerente") REFERENCES "funcionario" ("cpf") ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMENT ON TABLE departamento IS 'Alteração na tabela "departamento" para adicionar uma foreign key ao atributo "cpf_gerente" referente a "cpf" na tabela "funcionario".';

ALTER TABLE "localizacoes_departamento" ADD FOREIGN KEY ("numero_departamento") REFERENCES "departamento" ("numero_departamento") ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMENT ON TABLE localizacoes_departamento IS 'Alteração na tabela "localizacoes_departamento" para adicionar uma foreign key ao atributo "numero_departamento" referente a "numero_departamento" na tabela "departamento".';

ALTER TABLE "projeto" ADD FOREIGN KEY ("numero_departamento") REFERENCES "departamento" ("numero_departamento") ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMENT ON TABLE projeto IS 'Alteração na tabela "projeto" para adicionar uma foreign key ao atributo "numero_departamento" referente a "numero_departamento" na tabela "departamento".';

ALTER TABLE "trabalha_em" ADD FOREIGN KEY ("numero_projeto") REFERENCES "projeto" ("numero_projeto") ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMENT ON TABLE trabalha_em IS 'Alteração na tabela "trabalha_em" para adicionar uma foreign key ao atributo "numero_projeto" referente a "numero_projeto" na tabela "projeto".';

	   
	   
