-- Tworzenie tabeli products2
CREATE TABLE products2 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100)
);

-- Wstawianie przykładowych danych do tabeli products2
INSERT INTO products2 (product_id, product_name) VALUES
(1, 'Product A'),
(2, 'Product B'),
(3, 'Product C'),
(4, 'Product D');

-- Tworzenie tabeli orders2
CREATE TABLE orders2 (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Wstawianie przykładowych danych do tabeli orders2
INSERT INTO orders2 (order_id, product_id, quantity, order_date) VALUES
(1, 1, 5, '2024-01-10'),
(2, 2, 3, '2024-02-15'),
(3, 1, 2, '2024-03-20'),
(4, 3, 4, '2024-04-25');

-- Masz dwie tabelki products i orders, zawierające informacje o produktach i zamówieniach. 
-- Twoim zadaniem jest stworzenie zapytania, które zwróci listę produktów, 
-- które nigdy nie zostały zamówione.

select product_id, product_name
from products2 p
-- Klauzula WHERE wybierze tylko te produkty, których nie ma w tabeli 'orders2', 
-- czyli nie zostały nigdy zamówione
where product_id not in (
	select distinct product_id
    from orders2
	);
    
select count(*)
from products2