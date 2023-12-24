-- Calculate the cumulative sum of sales (Quantidade * ValorUnitario) for each product over time. 
-- Display the product code, date, and cumulative sales along the days for each product.


with sale as (select 
	fv.CodigoProduto as ProductCode,
	fv.DataVenda as SaleDate,
	sum(fv.Quantidade ) * avg(fv.ValorUnitario) as IndividualSale
	from datawarehouse.fato_vendas fv 
	group by ProductCode, SaleDate
	order by ProductCode, SaleDate)
select 
	s1.ProductCode,
	s1.SaleDate,
	s1.IndividualSale,
	sum(s2.IndividualSale) as CumulativeSale
	from sale as s1
	join sale as s2
	on 
	s1.ProductCode = s2.ProductCode and
	s1.SaleDate >= s2.SaleDate
	group by s1.ProductCode, s1.SaleDate
	order by s1.ProductCode, s1.SaleDate
;
