WITH recursive classificacao_P 
AS ( SELECT cod_p.codigo, concat(nome) AS nome, cod_p.codigo_pai
FROM  classificacao AS cod_p
WHERE cod_p.codigo_pai is null
  
UNION ALL

SELECT cod_f.codigo, concat(cla.nome,|| '-->' ||, cod_f.nome), cod_f.codigo_pai
FROM classificacao AS cod_f
INNER JOIN classificacao_P AS cla ON cla.codigo = cod_f.codigo_pai
WHERE cod_f.codigo_pai IS NOT NULL)

SELECT*
FROM classificacao_P
ORDER BY classificacao_P.nome;  
