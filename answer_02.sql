-- For each year, find the month with the highest total sales amount. Display the year, month, and total sales.

with sales as(
	select 
	YEAR(fv.DataVenda) as year,
	MONTH(fv.DataVenda) as month,
	sum(fv.Quantidade) as sales_qtde
	from datawarehouse.fato_vendas fv 
	group by YEAR, MONTH)
select 
s1.*,
s2.s_month
from 
	(select 
	s.year as s_year,
	max(s.sales_qtde) as s_sales_qtde
	from sales s
	group by s_year) s1
left JOIN 
	(select 
	s.year as s_year,
	s.month as s_month,
	max(s.sales_qtde) as s_sales_qtde
	from sales s
	group by s_year, s_month) s2
on 
s1.s_year = s2.s_year and 
s1.s_sales_qtde = s2.s_sales_qtde
order by s_year asc
;
