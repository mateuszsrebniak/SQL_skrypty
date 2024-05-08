-- Zadanie 1: Obliczanie Mediany
-- Masz tabelę orders zawierającą informacje o zamówieniach, w tym ceny produktów. 
-- Twoim zadaniem jest obliczenie mediany cen produktów dla każdego klienta.

USE Cleaning_Company;

with ranked_rows as (
select 
	customer_id_fk, cleaning_cost_without_travel,
    row_number() over (partition by customer_id_fk order by cleaning_cost_without_travel) row_num,
    -- numerowanie rekordów od najmniejszego do największego pod kątem kolumny "cleaning_cost_without_travel"
    -- dla każdego klienta osobno
    count(*) over (partition by customer_id_fk) c
    -- zliczenie liczby zamówień dla każdego klienta
from orders_with_costs
),
median as (
select 
	customer_id_fk, cleaning_cost_without_travel
from ranked_rows
where row_num in (floor((c+1)/2), ceil((c+1)/2))
-- wyciągnięcie tylko tych rekordów, które są rekordem środkowym (w przypadku nieparzystej liczby rekordów)
-- lub jednym z dwóch środkowych (w przypadku parzystej liczby rekordów)
)
select customer_id_fk, avg(cleaning_cost_without_travel) median
-- wyciągnięcie średniej wartości zamówienia, czyli w tym przypadku wyciągnięcie mediany.
-- Zapytanie zwraca albo wartość jedynego, środkowego rekordu,
-- albo średnią dwóch środkowych rekordów
from median
group by customer_id_fk