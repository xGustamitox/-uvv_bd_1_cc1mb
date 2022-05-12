-- QUESTÃO 1: 
SELECT AVG(f.salario) AS mediaSalario, d.nome_departamento  
FROM  funcionarios f 
INNER JOIN departamento d 
ON(d.numero_departamento=f.numero_departamento)
GROUP BY d.nome_departamento   


-- QUESTÃO 2:
SELECT AVG(f.salario) AS mediaSalario, f.sexo 
FROM funcionarios f 
GROUP BY f.sexo 

-- QUESTÃO 3:
SELECT d.nome_departamento, CONCAT (primeiro_nome,' ', nome_meio, ' ', ultimo_nome) AS NomeCompleto, FLOOR(DATEDIFF(NOW(), f.data_nascimento) / 365.25) AS idade,f.data_nascimento, f.salario 
FROM departamento d 
INNER JOIN 
funcionarios f 
ON f.numero_departamento = d.numero_departamento 


-- QUESTÃO 4: 
SELECT CONCAT (primeiro_nome ,' ', nome_meio, ' ', ultimo_nome) AS NomeCompleto, FLOOR(DATEDIFF(NOW(), data_nascimento) / 365.25) AS idade, f.data_nascimento, 
f.salario AS salarioAtual,
CASE WHEN (f.salario < 35) then 20
WHEN (f.salario > 35 ) then 15 
END AS taxaReajuste,
CASE WHEN (f.salario  < 35) then  (f.salario  * 0.2)
ELSE (f.salario  * 0.15) + f.salario
END AS salarioReajustado
FROM funcionarios f 

-- QUESTÃO 5: 
WITH gerente AS (SELECT CONCAT (f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as NomeCompleto, f.cpf
FROM funcionarios f)
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome), d.nome_departamento, f.salario, FLOOR(DATEDIFF(NOW(), f.data_nascimento ) / 365.25) AS idade
FROM departamento d
INNER JOIN funcionarios f
ON f.numero_departamento = d.numero_departamento
INNER JOIN gerente g ON g.cpf = d.cpf_gerente
ORDER BY d.nome_departamento ASC, f.salario DESC


-- QUESTÃO 6:  
SELECT CONCAT (f.primeiro_nome  ,' ', f.nome_meio, ' ', f.ultimo_nome) AS nomeCompleto_funcionario,
CONCAT(d.nome_dependente,' ', f.nome_meio, ' ', f.ultimo_nome) AS nomeCompleto_dependente, dpt.nome_departamento, 
FLOOR(DATEDIFF(NOW(), d.data_nascimento ) / 365.25) AS idade, 
(CASE WHEN d.sexo = 'F' 
THEN 'FEMININO'
ELSE 'MASCULINO'
END) AS sexo_dependente
FROM funcionarios f 
INNER JOIN departamento dpt 
ON f.numero_departamento = dpt.numero_departamento 
INNER JOIN dependente d 
ON f.CPF = d.cpf_funcionario 

--QUESTÃO 7:
SELECT CONCAT (f.primeiro_nome,' ', f.nome_meio,' ',f.ultimo_nome) AS nomeCompleto_funcionario, d2.nome_departamento, f.salario
FROM funcionarios f 
INNER JOIN departamento d2 
ON f.numero_departamento = d2.numero_departamento 
lEFT JOIN dependente d 
ON f.CPF = d.cpf_funcionario 
WHERE d.nome_dependente IS NULL 

--QUESTÃO 8: 
SELECT CONCAT (f.primeiro_nome,' ', f.nome_meio,' ',f.ultimo_nome) AS nomeCompleto_funcionario, d.nome_departamento, p.nome_projeto, t.horas 
FROM funcionarios f 
INNER JOIN departamento d on d.numero_departamento = f.numero_departamento 
INNER JOIN trabalha_em t on t.cpf_funcionario = f.CPF
INNER JOIN projeto p on p.numero_projeto = t.numero_projeto 
ORDER BY p.numero_projeto 

--QUESTÃO 9:
SELECT d.nome_departamento, p.nome_projeto as projeto,
SUM(DISTINCT(t.horas)) as horasTotais
FROM trabalha_em te 
INNER JOIN funcionarios f on  (te.cpf_funcionario = f.CPF) 
INNER JOIN departamento d on (d.nome_departamento = f.numero_departamento)
INNER JOIN projeto p on (p.numero_projeto = te.numero_projeto)
GROUP BY p.nome_projeto 

--QUESTÃO 10:
SELECT AVG(f.salario) AS mediaSalario, d.nome_departamento  
FROM funcionarios f 
INNER JOIN departamento d 
ON(d.numero_departamento=f.numero_departamento)
GROUP BY d.nome_departamento

   
--QUESTÃO 11: 
SELECT  CONCAT (f.primeiro_nome,' ', f.nome_meio,' ',f.ultimo_nome) AS nomeCompleto_funcionario, p.nome_projeto,
(CASE WHEN t.horas > 0 THEN (t.horas * 50)
WHEN t.horas < 0 THEN (t.horas * 0)
END) AS pagamento_Hora 
FROM funcionarios f 
INNER JOIN trabalha_em t on t.cpf_funcionario = f.CPF 
INNER JOIN projeto p on p.numero_projeto = t.numero_projeto 

		
--QUESTÃO 12: 
SELECT d.nome_departamento, CONCAT (f.primeiro_nome,' ', f.nome_meio,' ',f.ultimo_nome) AS nomeCompleto_funcionario, p.nome_projeto, t.horas 
FROM funcionarios f 
INNER join departamento d on d.numero_departamento = f.numero_departamento 
INNER join trabalha_em t on t.cpf_funcionario = f.CPF 
INNER join projeto p on p.numero_projeto = t.numero_projeto 
where t.horas = 0 
 
   
--QUESTÃO 13: 
SELECT CONCAT (f.primeiro_nome,'', f.nome_meio,'', f.ultimo_nome) AS nomeCompleto_funcionario, FLOOR(DATEDIFF(NOW(), f.data_nascimento ) / 365.25) AS idade, f.sexo  
FROM funcionarios f  
UNION
SELECT CONCAT (d.nome_dependente,'', f.nome_meio,'', f.ultimo_nome),FLOOR(DATEDIFF(NOW(), d.data_nascimento ) / 365.25) AS idade, f.sexo  
FROM dependente d 
INNER JOIN funcionarios f on f.CPF = d.cpf_funcionario 
ORDER BY idade DESC


--QUESTÃO 14: 
SELECT CONCAT (f.primeiro_nome,'', f.nome_meio,'', f.ultimo_nome) AS nomeCompleto_funcionario, dpt.nome_departamento
FROM funcionarios f 
INNER JOIN departamento dpt ON dpt.numero_departamento = f.numero_departamento 


--QUESTÃO 15:
SELECT DISTINCT CONCAT(f.primeiro_nome, ' ', f.nome_meio, '. ', f.ultimo_nome) AS nomeCompleto_funcionario, dp.nome_departamento, p.nome_projeto
FROM departamento dp
INNER JOIN funcionarios f ON dp.numero_departamento = f.numero_departamento
INNER JOIN trabalha_em t ON t.cpf_funcionario = f.CPF 
INNER JOIN projeto p ON p.numero_projeto = t.numero_projeto
	   
