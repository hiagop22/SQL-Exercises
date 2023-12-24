-- Retrieve the top 5 products with the highest total sales amount. 
-- Include the product name and the total sales amount.

SELECT 
	dp.NomeProduto , 
	fv.CodigoProduto , 
	sum(fv.Quantidade) as Quantidade, 
	sum(fv.Quantidade) * avg(fv.ValorUnitario) as Income
	from datawarehouse.fato_vendas fv 
	join  datawarehouse.dim_produto dp
	on dp.CodigoProduto = fv.CodigoProduto 
	group by fv.CodigoProduto, dp.NomeProduto  
	order by Quantidade DESC 
	limit 5
;