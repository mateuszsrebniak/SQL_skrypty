use cleaning_company;

with sales_by_weeks as (
select 
	weekofyear(cleaning_date) week_of_year,
    round(sum(total_cost),0) sales
from orders_with_costs
group by weekofyear(cleaning_date)
)
select 
	week_of_year,
    sales,
    round((sales/lag(sales) over (order by week_of_year))*100, 2) - 100 vs_lm,
    round((sales / sum(sales) over()) * 100, 2) share_of_total_sales
from sales_by_weeks;
