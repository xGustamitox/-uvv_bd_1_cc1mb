WITH recursive classificacao_P AS (
SELECT cd.codigo, concat(nome) AS nome, cd.codigo_pai
FROM  classificacao AS cd
WHERE cd.codigo_pai is null
