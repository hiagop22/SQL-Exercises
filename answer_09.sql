-- Find the customers who have made at least two consecutive purchases of the same product. 
-- Display the customer code, product code, and purchase dates.


create or replace view Sales as (
	select 
	fv.CodigoCliente,
	fv.DataVenda ,
	fv.CodigoProduto
	from datawarehouse.fato_vendas fv 
	where fv.CodigoProduto is not NULL 
	order by CodigoCliente, fv.DataVenda);


create or replace view FullTable as (
	select 
		s.CodigoCliente ,
		s.DataVenda ,
		s.CodigoProduto  ,
		LEAD (s.CodigoProduto) 
		over (PARTITION by s.CodigoCliente order by s.DataVenda) as NextPurchaseCode,
		LEAD (s.DataVenda) 
		over (PARTITION by s.CodigoCliente order by s.DataVenda) as NextPurchaseDate
		from sales s
	);

SELECT * 
    from FullTable f
    where f.NextPurchaseCode is not NULL and
    f.CodigoProduto = f.NextPurchaseCode;