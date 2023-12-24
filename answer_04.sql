-- List the top 3 salespersons who have made sales in the most distinct product categories. 
-- Include the salesperson code and the number of distinct categories.


create or replace view MostDistinct as 
	SELECT  
	DISTINCT 
	fv.CodigoVendedor as CodigoVendedor,
	fv.CodigoProduto as CodigoProduto
	from datawarehouse.fato_vendas fv 
	where fv.CodigoProduto is not NULL 
;

select 
	md.CodigoVendedor as SalesPerson,
	count(md.CodigoVendedor) as NumbersOfCategories
	from MostDistinct md
	group by md.CodigoVendedor
	order by count(md.CodigoVendedor) desc
	limit 3 
;