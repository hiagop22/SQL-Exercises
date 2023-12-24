-- - Calculate the average time between consecutive purchases for each customer. 
-- Display the customer code and the average time in days.

with delta as (
	select 
	CodigoCliente ,
	DataVenda ,
	PrevDataVenda
	from (	
		select 
		*,
		lag(r.DataVenda, 1) 
        over(PARTITION by r.CodigoCliente order by r.DataVenda) as PrevDataVenda
		from (
			select * from
			datawarehouse.fato_vendas fv1
			order by fv1.CodigoCliente, fv1.DataVenda
			) r
	) s
	where s.PrevDataVenda is not Null
)
select 
	CodigoCliente,
	avg(DATEDIFF(DataVenda, PrevDataVenda)) as AvgDifferenceInDays
	from delta
	group by CodigoCliente
;