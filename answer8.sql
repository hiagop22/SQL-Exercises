-- Identify the products that have not been that have not been sold in the last 6 months since the most recent purchase. 
-- Display the product code and name.

create or replace view MostRecentSold as (
	select 
	max(fv.DataVenda) as DataVenda
	from datawarehouse.fato_vendas fv 
);

select 
	p.NomeProduto,
	r.*
	from (
		select 
		r.*
		from
		(select 
			fv.CodigoProduto,
			min(DATEDIFF(mr.DataVenda, fv.DataVenda)) as TimeSinceLastSold
			from 
			datawarehouse.fato_vendas fv ,
			MostRecentSold mr
			group by fv.CodigoProduto 
		) r,
		MostRecentSold mr
		where TimeSinceLastSold > DATEDIFF(mr.DataVenda, DATE_SUB(mr.DataVenda, INTERVAL 6 MONTH))
		) r left join
		datawarehouse.dim_produto p
		on r.CodigoProduto = p.CodigoProduto 
		order by TimeSinceLastSold desc
;
