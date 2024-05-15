CREATE TABLE sales (
    date DATE,
    region VARCHAR(50),
    product VARCHAR(50),
    sales INT
);

-- Wypełnianie tabeli losowymi danymi
INSERT INTO sales (date, region, product, sales)
SELECT
    DATE_ADD('2022-01-01', INTERVAL FLOOR(RAND() * 36) MONTH) AS date,
    CASE FLOOR(RAND() * 4)
        WHEN 0 THEN 'North'
        WHEN 1 THEN 'South'
        WHEN 2 THEN 'East'
        ELSE 'West'
    END AS region,
    CASE FLOOR(RAND() * 3)
        WHEN 0 THEN 'Product A'
        WHEN 1 THEN 'Product B'
        ELSE 'Product C'
    END AS product,
    FLOOR(RAND() * 1000) AS sales
FROM
    information_schema.tables AS t1,
    information_schema.tables AS t2;
    
-- Analiza Trendów
-- Masz tabelę sales zawierającą informacje o sprzedaży produktów w różnych regionach i miesiącach. 
-- Twoim zadaniem jest obliczenie miesięcznych zmian w sprzedaży dla każdego produktu, 
-- aby zidentyfikować trendy wzrostu lub spadku.

with grouped_sales as (
select product, date, sum(sales) total_sales
from sales
group by product, date
)
select product, date,
	round((
		total_sales/
				lag(total_sales) over (partition by product order by date)) 
                * 100, 1)
					- 100 as vs_last_month
	-- funkcja LAG(), która odwołuje się do poprzedniego rekordu.
    -- Dzięki temu sprzedaż można podzielić przez sprzedaż z poprzedniego miesiąca i uzyskać 
    -- procentowy stosunek obecnej sprzedaży vs LM
from grouped_sales;