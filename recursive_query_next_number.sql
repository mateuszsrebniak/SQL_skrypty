with recursive numbers as (
	select 1 as num
    -- wybieramy 1 jako początek listy
    union all
    -- łączymy wszystkie kolejne wyniki w jeden
    select n.num + 1
    -- do wyniku z rekurencyjnego CTE dodajemy 1
    from numbers n
    -- odwołujemy się do wyników rekurencyjnego CTE, czyli za pierwszym razem wynikiem jest tylko 1
    where n.num <100
    -- dodajemy tak długo, dopóki wyniki w rekurencyjnym CTE są mniejsze niż 100
)
select *
from numbers;