create database najd_delights; 
show databases; 
-- lab 4
use najd_delights;

CREATE TABLE staff (
    staff_ID INT,
    Fname VARCHAR(60),
    Lname VARCHAR(60),
    Phone VARCHAR(60),
    role ENUM('chef', 'waiter', 'cashier')
);
describe staff;

CREATE TABLE Orders (
Order_ID INT,
Customer_ID INT,
Staff_ID INT,
Order_Date DATETIME,
Order_Type ENUM('Dine_in', 'Takeaway'),
Payment_Method ENUM('Cash', 'Card'),
Total_Amount DECIMAL(8,2));

describe Orders;


CREATE TABLE Dish (
Dish_ID INT,
Dish_Name VARCHAR(100),
Price DECIMAL(6,2),
Category ENUM('Appetizer', 'Main_Dish', 'Dessert','Drink')
);

describe dish;

CREATE TABLE Order_Details (
Order_ID INT,
Dish_ID INT,
Quantity INT
);

describe Order_Details;

CREATE TABLE customer (
    customer_ID INT,
    Fname VARCHAR(60),
    Lname VARCHAR(60),
    phone VARCHAR(20)
);
DESCRIBE customer;

ALTER TABLE customer
ADD Email VARCHAR(100);

ALTER TABLE customer
RENAME COLUMN phone TO phoneNumber;

ALTER TABLE customer
MODIFY COLUMN phoneNumber VARCHAR(10);

DESCRIBE customer;

SHOW TABLES;

ALTER TABLE customer
DROP COLUMN Email;

ALTER TABLE customer
DROP column role;

describe CUSTOMER;

ALTER TABLE dish
DROP COLUMN role;
DESCRIBE dish;
ALTER TABLE Orders
DROP COLUMN role;
describe orders;
DROP TABLE order_details;

CREATE TABLE order_details (
    dish_ID INT,
    orders_ID INT,
    Quantity INT
);
Describe order_details;
 
-- lab5
show tables;

INSERT INTO customer VALUES (customer_ID, Fname, Lname, phoneNumber),
(1, 'Sara', 'Ahmed','0551234567'), 
(2, 'Khalid','Ali', '0569876543'),
(3, 'Mona','Hassan','0571122334'),
(4,'Omar','Saleh','0589988776');

INSERT INTO Staff VALUEs 
(1, 'Saleh', 'Yasser', '0555551234', 'Chef'),
(2, 'Omar', 'Majed', '0562223344', 'Chef'),
(3, 'Yuosuf', 'Ahmad', '0573334455', 'Waiter'),
(4, 'Salem', 'Abdullah', '0584445566', 'Cashier');


INSERT INTO Dish VALUES (Dish_ID, Dish_Name, price, category),
(1, 'Kabsa', '25.00', 'Main_Dish'),
(2, 'Samboosa', '10.00', 'Appetizer'),
(3, 'Basboosa', '15.00', 'Dessert'),
(4, 'Saudi Cocktail', '5.00', 'Drink');

describe dish;

INSERT INTO Orders VALUES 
(1, 1, 3, '2025-09-25 13:30:00', 'Dine_in', 60.00, 'Cash'),
(2, 2, 3, '2025-09-25 14:00:00', 'Takeaway', 35.00, 'card'),
(3, 3, 4, '2025-09-26 12:15:00', 'Dine_in', 25.00, 'Cash'),
(4, 4, 2, '2025-09-26 15:45:00', 'Takeaway', 0.00, 'Cash');

delete from orders;

insert into order_Details values
(1,1,2), 
(1,3,1),
(2,2,1),
(2,4,2),
(3,1,1),
(3,2,1),
(4,3,2);

SELECT* from customer;
SELECT* from staff;
SELECT* from dish;

SELECT Fname,Lname, Role
FROM Staff;

SELECT Dish_Name, Price FROM Dish 
WHERE price < 15;


UPDATE customer 
SET phoneNumber = '0500001111'
WHERE customer_ID = 3;

SELECT Fname, phoneNumber FROM customer 
WHERE customer_ID = 3;

DELETE FROM Staff
WHERE Staff_ID = 2;

SELECT* from staff;

DELETE FROM Dish;
SELECT* from dish;

-- lab6
Alter table customer
Add primary key (customer_ID);

describe customer;

Alter table orders
Add foreign key (customer_ID) references customer (customer_ID);

describe orders;

Alter table customer
modify column Fname varchar(100) not null,
modify column Lname varchar(100) not null,
modify column phoneNumber varchar(10) not null;

describe customer;

Alter table customer
add unique (phoneNumber);

describe customer;

alter table dish
add check (price >0);

insert into dish (dish_ID, dish_Name, category, price)
values (7, 'saleeq', 'main_dish', 0);

alter table orders
alter payment_method set default 'card';

describe orders;

-- lab7
SELECT MIN(Total_amount) 
FROM Orders WHERE Orders_Type = 'Dine_in';

SELECT MIN(Total_Amount) AS min_order
FROM Orders WHERE Orders_Type = 'Dine_in';

describe orders;

SELECT MAX(Total_Amount) AS max_order 
FROM Orders;

SELECT COUNT(*) AS total_orders 
FROM Orders;

SELECT COUNT(Orders_Type) AS takeaway_orders FROM Orders
WHERE Orders_Type = 'takeaway';

SELECT COUNT(DISTINCT Customer_ID) AS customers
FROM Orders;

SELECT SUM(Quantity) AS total_dishes_sold 
FROM Order_Details;

SELECT AVG(Total_Amount) AS avg_order_value 
FROM Orders;

delete from staff;

SELECT Role, COUNT(*) AS total_staff 
FROM Staff
GROUP BY Role;

select * from staff;
select * from orders;
select * from order_details;

delete from customer; 
delete from dish;

-- lab8
select orders.orders_ID, orders.Orders_date,customer.Fname AS Customer_FirstName,
customer.Lname AS Customer_LastName, Orders.Total_Amount From Orders
Inner join customer on Orders.customer_ID=customer.customer_ID;

select Orders.orders_ID, Orders.Orders_Date, Customer.Fname AS customer_FirstName,
Staff.FName AS Staff_FName, Orders.Total_Amount
from Orders
join Customer on Orders.customer_ID= Customer.customer_ID
join Staff on Orders.staff_Id=staff.staff_ID;

describe orders;
describe staff;

select d.dish_Name, od.orders_ID
from dish d left join order_details od on d.dish_ID= od.dish_ID;

select o.orders_ID, s.FName AS staff_firstName, s.Lname AS staff_LastName
from orders o right join staff s on o.staff_Id = s.staff_ID;

-- lab9
SELECT dish_Name,Price
From Dish
Where Price > (SELECT AVG(Price) From Dish);

SELECT Fname,Lname
From Customer 
WHERE Customer_ID IN (SELECT Customer_ID From Orders);

Create VIEW DineIn_Orders AS
SELECT Orders_ID, customer_ID, Total_Amount From Orders
Where Orders_Type='Dine_in';
SELECT * from DineIn_Orders;

Create Or Replace View DineIn_Orders AS
select Orders_ID, Customer_ID, Total_Amount,
payment_method From Orders
WHERE orders_Type = 'Dine_in';

SELECT * from DineIn_Orders;







