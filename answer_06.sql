-- Retrieve the customers who have made purchases in the year 2022. 
-- Display the customer code and name.

select 
	fv.DataVenda,
	dc.CodigoCliente,
	dc.NomeCliente 
	from datawarehouse.dim_cliente dc 
	join datawarehouse.fato_vendas fv on
	fv.CodigoCliente = dc.CodigoCliente AND 
	Year(fv.DataVenda) = '2012'
	order by fv.DataVenda
;