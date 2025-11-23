use library_db;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);
CREATE TABLE Orders1 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Customer VALUES
(1, 'Aman', 'Delhi'),
(2, 'Rita', 'Mumbai'),
(3, 'Mahesh', 'Delhi'),
(4, 'John', 'Chennai');

INSERT INTO Orders1 VALUES
(101, 1, 5000),
(102, 1, 2500),
(103, 2, 3000),
(104, 3, 1000);

SELECT 
    customer_name,
    (SELECT SUM(amount) 
     FROM Orders1
     WHERE Orders1.customer_id = Customer.customer_id
    ) AS total_spent
FROM Customer;

SELECT customer_name
FROM Customer
WHERE customer_id IN (
      SELECT customer_id 
      FROM Orders1
);

SELECT customer_name
FROM Customer
WHERE customer_id IN (
      SELECT customer_id 
      FROM Orders1
);

SELECT customer_name
FROM Customer C
WHERE EXISTS (
    SELECT 1 
    FROM Orders1 O
    WHERE O.customer_id = C.customer_id
);

SELECT customer_name
FROM Customer
WHERE customer_id = (
      SELECT customer_id
      FROM Orders1
      GROUP BY customer_id
      ORDER BY SUM(amount) DESC
      LIMIT 1
);

SELECT * 
FROM (
       SELECT customer_id, SUM(amount) AS total_amt
       FROM Orders1
       GROUP BY customer_id
     ) AS t
WHERE total_amt > 3000;

SELECT customer_id, amount
FROM Orders1 O1
WHERE amount > (
      SELECT AVG(amount)
      FROM Orders O2
      WHERE O1.customer_id = O2.customer_id
);




