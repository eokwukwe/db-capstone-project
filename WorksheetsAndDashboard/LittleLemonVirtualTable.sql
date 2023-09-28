USE littlelemondb;

-- Task 1
-- In the first task, Little Lemon need you to create a virtual table called OrdersView that focuses on OrderID, Quantity and Cost columns within the Orders table for all orders with a quantity greater than 2. 

CREATE VIEW OrdersView AS
    SELECT 
        OrderID, Quantity, TotalCost
    FROM
        Orders
	WHERE Quantity > 2;
    
-- SELECT * FROM OrdersView;

-- Task 2
-- For your second task, Little Lemon need information from four tables on all customers with orders that cost more than $150. Extract the required information from each of the following tables by using the relevant JOIN clause: 
-- Customers table: The customer id and full name.
-- Orders table: The order id and cost.
-- Menus table: The menus name.
-- MenusItems table: course name and starter name.
-- The result set should be sorted by the lowest cost amount.

SELECT 
    c.CustomerID,
    c.Name AS FullName,
    o.OrderID,
    o.TotalCost AS Cost,
    m.MenuName,
    mi.Name AS CourseName
FROM
    Customers c
        INNER JOIN
    Orders o USING (CustomerID)
        INNER JOIN
    Menus m USING (MenuID)
        INNER JOIN
    Menuitems_Menus mim USING (MenuID)
        INNER JOIN
    (SELECT MenuItemID, Name FROM Menuitems WHERE Type = 'Main Course') mi 
		ON mim.MenuItemID = mi.MenuItemID
WHERE
    o.TotalCost > 150
ORDER BY o.TotalCost;


-- Task 3
-- For the third and final task, Little Lemon need you to find all menu items for which more than 2 orders have been placed. You can carry out this task by creating a subquery that lists the menu names from the menus table for any order quantity with more than 2.
SELECT 
    m.MenuName
FROM
    Menus m
        INNER JOIN
    (SELECT * FROM Orders WHERE Quantity > 2) ord USING (MenuID);