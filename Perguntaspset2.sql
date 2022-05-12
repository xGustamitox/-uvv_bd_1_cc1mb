-- QUESTÃO 1:
SELECT avg(f.salario) AS media_salarial, d.nome_departamento
FROM funcionario f
INNER JOIN departamento d
ON d.numero_departamento = f.numero_departamento
GROUP BY d.nome_departamento;

-- QUESTÃO 2:
SELECT avg(f.salario) AS media_salarial, f.sexo
FROM funcionario f
GROUP BY f.sexo;

-- QUESTÃO 3:
SELECT d.nome_departamento,
       concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
       f.data_nascimento,
       extract(year FROM age(current_date, f.data_nascimento)) AS idade,
       f.salario
FROM departamento d
INNER JOIN funcionario f
ON f.numero_departamento = d.numero_departamento;

-- QUESTÃO 4:
SELECT concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
       f.data_nascimento,
       extract(year FROM age(current_date, f.data_nascimento)) AS idade,
       f.salario AS salario_atual,
       (case when (f.salario < 35) then 20
        else 15
        end) AS taxa_reajuste,
       (case when (f.salario < 35) then f.salario + (f.salario * 0.2)
        else f.salario + (f.salario * 0.15)
        end) AS salario_ajustado
FROM funcionario f;

-- QUESTÃO 5:
WITH gerente AS (
     SELECT concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome,
            f.cpf
     FROM funcionario f)
SELECT d.nome_departamento,
       concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
       f.data_nascimento,
       extract(year FROM age(current_date, f.data_nascimento)) AS idade,
       f.salario,
       g.nome AS nome_gerente
FROM departamento d
INNER JOIN funcionario f
ON f.numero_departamento = d.numero_departamento
INNER JOIN gerente g ON g.cpf = d.cpf_gerente
ORDER BY d.nome_departamento ASC, f.salario DESC;

-- QUESTÃO 6:
SELECT d.nome_departamento,
       concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
       dn.nome_dependente,
       extract(year FROM age(current_date, dn.data_nascimento)) AS idade_dependente,
       (case
        when (dn.sexo = 'M') then 'Masculino'
        else 'Feminino'
        end) AS sexo_dependente
FROM departamento d
INNER JOIN funcionario f
ON f.numero_departamento = d.numero_departamento
INNER JOIN dependente dn ON dn.cpf_funcionario = f.cpf;

-- QUESTÃO 7:
WITH dependente_count AS (
    SELECT count(dn) AS count,
           dn.cpf_funcionario
    FROM dependente dn
    GROUP BY dn.cpf_funcionario
)
SELECT d.nome_departamento,
       concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_funcionario,
       f.salario
FROM funcionario f
INNER JOIN departamento d ON d.numero_departamento = f.numero_departamento
LEFT JOIN dependente_count dc ON dc.cpf_funcionario = f.cpf
WHERE dc.count isnull;

-- QUESTÃO 8:
SELECT d.nome_departamento,
       p.nome_projeto,
       concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
       te.horas
FROM departamento d
INNER JOIN projeto p
ON p.numero_departamento = d.numero_departamento
INNER JOIN trabalha_em te
ON te.numero_projeto = p.numero_projeto
INNER JOIN funcionario f
ON f.cpf = te.cpf_funcionario;

-- QUESTÃO 9:
SELECT d.nome_departamento,
       p.nome_projeto,
       sum(te.horas)
FROM departamento d
INNER JOIN projeto p
ON p.numero_departamento = d.numero_departamento
INNER JOIN trabalha_em te
ON te.numero_projeto = p.numero_projeto
INNER JOIN funcionario f
ON f.cpf = te.cpf_funcionario
GROUP BY d.nome_departamento, p.nome_projeto;


-- QUESTÃO 10:
SELECT avg(f.salario) AS media_salarial, d.nome_departamento
FROM funcionario f
INNER JOIN departamento d
on d.numero_departamento = f.numero_departamento
GROUP BY d.nome_departamento;


-- QUESTÃO 11:
SELECT p.nome_projeto,
       concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario,
       te.horas * 50 AS valor
FROM funcionario f
INNER JOIN trabalha_em te
ON te.cpf_funcionario = f.cpf
INNER JOIN projeto p
ON p.numero_projeto  = te.numero_projeto;

-- QUESTÃO 12:
SELECT d.nome_departamento,
       p.nome_projeto,
       concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario
FROM departamento d
INNER JOIN projeto p
ON p.numero_departamento = d.numero_departamento
INNER JOIN trabalha_em te ON
te.numero_projeto = p.numero_projeto
INNER JOIN funcionario f
ON f.cpf = te.cpf_funcionario
WHERE te.horas isnull OR te.horas = 0;
-- ISSO AQUI NUNCA VAI PEGAR O ISNULL PQ O MODELO DO ELMASRI USA
-- TRABALHA_EM.HORAS NOTNULL


-- QUESTÃO 13:
SELECT concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome,
       extract(year FROM age(current_date, f.data_nascimento)) AS idade,
       f.sexo
FROM funcionario f
UNION
SELECT d.nome_dependente,
	   extract(year FROM age(current_date, d.data_nascimento)) AS idade,
	   d.sexo
FROM dependente d
ORDER BY idade;

-- QUESTÃO 14:
SELECT d.nome_departamento, count(f) AS numero_funcionarios
FROM departamento d
INNER JOIN funcionario f
ON d.numero_departamento = f.numero_departamento
GROUP BY f.numero_departamento, d.nome_departamento;

-- QUESTÃO 15:
SELECT d.nome_departamento,
       p.nome_projeto,
       concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS nome_funcionario
FROM departamento d
INNER JOIN projeto p
ON p.numero_departamento = d.numero_departamento
LEFT JOIN trabalha_em te
ON te.numero_projeto = p.numero_projeto
INNER JOIN funcionario f
ON f.numero_departamento = d.numero_departamento;
