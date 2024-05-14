-- Masz tabelę employees zawierającą hierarchię pracowników (np. pole employee_id i manager_id). 
-- Twoim zadaniem jest stworzenie zapytania rekurencyjnego, 
-- które zwróci listę pracowników wraz z ich poziomem w hierarchii.

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT
);

INSERT INTO employees (employee_id, employee_name, manager_id, level) VALUES
(1, 'John Smith', NULL),
(2, 'Jane Doe', 1,
(3, 'Michael Johnson', 1),
(4, 'Emily Brown', 2),
(5, 'David Wilson', 2),
(6, 'Lisa Taylor', 3),
(7, 'Mark Anderson', 3),
(8, 'Sarah Martinez', 6),
(9, 'Matthew Clark', 6),
(10, 'Jennifer White', 7);

-- Zapytanie zwracające nazwisko pracownika i nazwisko jego menadżera w kolejnej kolumnie.
-- LEFT JOIN sprawi, że dla pracownika, który nie ma przełożonego, 
-- w kolumnie 'manager' zwrócona zostanie wartość NULL
-- Mamy tutaj self-join. ID managera łączymy z ID pracownika, co pozwala osiągnąć zamierzony efekt.
select e.employee_id, e.employee_name as employee, m.employee_name as manager
from employees e
left join employees m on e.manager_id=m.employee_id;

-- Zapytanie rekurencyjne, które ma zwrócić poziom pracownika w organizacji.
-- Na przykład: Jeśli przełożony pracownika ma przełożonego, a ten już przełożonych nie ma,
-- to pracownik jest na 3 poziomie.
-- Najwyższy poziom, czyli pracownik bez przełożonych (Krzysztof Jarzyna) jest na poziomie 1.
with recursive employee_level as (
-- bazowe zapytanie wykorzystane w pierwszej iteracji. 
-- Ustalamy poziom nr 1 dla pracownika bez przełożonych. NULL w kolumnie 'manager_id'
	select employee_id, employee_name, 1 as emp_level
    from employees
    where manager_id is null
    
    union all
    
    select e.employee_id, e.employee_name, el.emp_level + 1
    from employee_level el
    inner join employees e on el.employee_id = e.manager_id
)
select *
from employee_level;