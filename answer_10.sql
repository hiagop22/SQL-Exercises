-- List the products that have the highest average sales value (sales amount divided by quantity) 
-- in each product category. 
-- Display the category, product code, and average sales value.

with report as (
	SELECT 
	fv.CodigoProduto ,
	count(fv.Quantidade ) as CountQuantidade,
	sum(fv.Quantidade) as SumQuantidade,
	cast(count(fv.Quantidade ) / sum(fv.Quantidade) as decimal(10, 6)) as AverageSales
	from datawarehouse.fato_vendas fv 
	WHERE  fv.CodigoProduto  is not NULL 
	group by fv.CodigoProduto)	
SELECT  
	s.CodigoProduto,
	s.CountQuantidade,
	s.SumQuantidade,
	s.AverageSales,
	s.TipoProduto,
	case when 
		s.AverageSales = (MAX(s.AverageSales) over(PARTITION by s.TipoProduto))
	then 
		'Y'
	else
		'N'
	end IsHiggest
	from (
		select
		r.* ,
		dp.TipoProduto 
		from report r join datawarehouse.dim_produto dp 
		on r.CodigoProduto = dp.CodigoProduto
	) s	 
	order by s.TipoProduto
;