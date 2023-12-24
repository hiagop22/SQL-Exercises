-- Find the products that have experienced a sales increase of more than 50% from the previous month. 
-- Display the product code, month, and the percentage increase.

create or replace view report as (
	select 
	*,
	lag(r.MonthSale) 
	OVER(PARTITION  by r.ProductCode, r.YearSale
		Order by r.ProductCode, r.YearSale, r.MonthSale) as PrevMonth
	from( 
		select 
		fv.CodigoProduto as ProductCode,
		Year(fv.DataVenda) as YearSale,
		MONTH(fv.DataVenda) as MonthSale,
		sum(fv.Quantidade * fv.ValorUnitario) as ValueSale
		from datawarehouse.fato_vendas fv 
		where fv.CodigoProduto is not Null
		group by 
		fv.CodigoProduto , Year(fv.DataVenda), MONTH(fv.DataVenda)
		order by fv.CodigoProduto , Year(fv.DataVenda), MONTH(fv.DataVenda)
	) r
);

select 
    r1.ProductCode,
    r1.YearSale,
    r1.MonthSale,
    r1.ValueSale,
    r2.ValueSale as PrevValueSale,
    (r1.ValueSale - r2.ValueSale)/r2.ValueSale as RelativeIncrease
    from report r1
    join report r2
    on 
    r1.ProductCode = r2.ProductCode AND
    r1.YearSale = r2.YearSale AND
    r2.MonthSale = r1.PrevMonth
    where r1.ValueSale >= r2.ValueSale * 1.5 And r1.PrevMonth is not Null
;