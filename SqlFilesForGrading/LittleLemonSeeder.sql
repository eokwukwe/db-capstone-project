USE littlelemondb;

-- Insert Roles
INSERT INTO Roles (Name) VALUES ('Manager'), ('Head Chef'), ('Assistant Chef'), ('Assistant Manager'), ('Head Waiter'), ('Receptionist');

-- Insert Employees
INSERT INTO Employees (Name, Email, Salary, ContactNumber, Address, RoleID) VALUES
('John Doe', 'john.doe@example.com', 50000.00, 3125557891, '123 Main St, Chicago, IL', 1),
('Jane Smith', 'jane.smith@example.com', 45000.00, 3125552468, '456 Elm St, Chicago, IL', 2),
('Emily Johnson', 'emily.johnson@example.com', 60000.00, 3125551357, '789 Oak St, Chicago, IL', 3),
('William Brown', 'william.brown@example.com', 55000.00, 3125558642, '101 Maple St, Chicago, IL', 4),
('Sophia Davis', 'sophia.davis@example.com', 52000.00, 3125559753, '202 Cedar St, Chicago, IL', 5);


-- Insert Customers
INSERT INTO Customers (CustomerID, Name, Email, ContactNumber) VALUES 
(1, 'John Mane', 'john@email.com', 1234567890),
(2, 'Jane Chukk', 'jane@email.com', 1234567891),
(3, 'Sam Francis', 'sam@email.com', 1234567892),
(4, 'Sara Chills', 'sara@email.com', 1234567893),
(5, 'Tom Hanks', 'tom@email.com', 1234567894),
(6, 'Tina Toddle', 'tina@email.com', 1234567895),
(7, 'Mike Pence', 'mike@email.com', 1234567896),
(8, 'Mila Jones', 'mila@email.com', 1234567897),
(9, 'Jack Withman', 'jack@email.com', 1234567898),
(99, 'Jill Klanm', 'jill@email.com', 1234567899);

-- Insert Addresses
INSERT INTO Addresses (Street, City, State, Type, CustomerID) VALUES 
('123 Wacker Dr', 'Chicago', 'IL', 'Shipping', 1),
('456 Michigan Ave', 'Chicago', 'IL', 'Shipping', 2),
('789 State St', 'Chicago', 'IL', 'Shipping', 3),
('101 Adams St', 'Chicago', 'IL', 'Shipping', 4),
('102 Monroe St', 'Chicago', 'IL', 'Shipping', 5),
('103 Madison St', 'Chicago', 'IL', 'Shipping', 6),
('104 Jackson Blvd', 'Chicago', 'IL', 'Shipping', 7),
('105 Van Buren St', 'Chicago', 'IL', 'Shipping', 8),
('106 Harrison St', 'Chicago', 'IL', 'Shipping', 9),
('107 Congress Pkwy', 'Chicago', 'IL', 'Shipping', 99);

-- Insert Menus
INSERT INTO Menus (MenuName) VALUES ('Italian'), ('Chinese'), ('Mexican'), ('Indian'), ('American'), ('Japanese'), ('Thai'), ('French'), ('Greek'), ('Spanish');

-- Insert MenuItems
INSERT INTO MenuItems (Name, Type, Price) VALUES
('Bruschetta', 'Starter', 5.99),
('Caesar Salad', 'Starter', 6.49),
('Garlic Bread', 'Starter', 6.99),
('Mozzarella Sticks', 'Starter', 7.49),
('French Onion Soup', 'Starter', 7.99),
('Shrimp Cocktail', 'Starter', 8.49),
('Stuffed Mushrooms', 'Starter', 8.99),
('Chicken Wings', 'Starter', 9.49),
('Nachos', 'Starter', 9.99),
('Spring Rolls', 'Starter', 10.49),
('Spaghetti Carbonara', 'Main Course', 12.99),
('Chicken Parmesan', 'Main Course', 13.49),
('Beef Steak', 'Main Course', 15.99),
('Grilled Salmon', 'Main Course', 16.49),
('Vegetable Stir Fry', 'Main Course', 11.99),
('Lamb Chops', 'Main Course', 17.99),
('Pork Ribs', 'Main Course', 18.49),
('Duck Confit', 'Main Course', 19.99),
('Lobster Tail', 'Main Course', 24.99),
('Vegan Burger', 'Main Course', 12.49),
('Chocolate Mousse', 'Dessert', 4.99),
('Cheesecake', 'Dessert', 5.49),
('Tiramisu', 'Dessert', 5.99),
('Apple Pie', 'Dessert', 6.49),
('Creme Brulee', 'Dessert', 6.99),
('Mojito', 'Drink', 7.99),
('Margarita', 'Drink', 8.49),
('Bloody Mary', 'Drink', 8.99),
('Pina Colada', 'Drink', 9.49),
('Whiskey Sour', 'Drink', 9.99);

-- Associating MenuItems with Menus
INSERT INTO MenuItems_Menus (MenuID, MenuItemID) VALUES
(1, 1), (1, 11), (1, 21), (1, 26),
(2, 2), (2, 12), (2, 22), (2, 27),
(3, 3), (3, 13), (3, 23), (3, 28),
(4, 4), (4, 14), (4, 24), (4, 29),
(5, 5), (5, 15), (5, 25), (5, 30),
(6, 6), (6, 16), (6, 21), (6, 26),
(7, 7), (7, 17), (7, 22), (7, 27),
(8, 8), (8, 18), (8, 23), (8, 28),
(9, 9), (9, 19), (9, 24), (9, 29),
(10, 10), (10, 20), (10, 25), (10, 30);


-- Insert Bookings
INSERT INTO Bookings (TableNumber, BookingDate, BookingSlot, CustomerID, EmployeeID) VALUES 
(1, '2023-10-01', '18:00:00', 1, 1),
(2, '2023-10-02', '19:00:00', 2, 2),
(3, '2023-10-03', '20:00:00', 3, 3),
(4, '2023-10-04', '18:30:00', 4, 4),
(5, '2023-10-05', '19:30:00', 5, 5),
(6, '2023-10-06', '20:30:00', 6, 1),
(7, '2023-10-07', '18:00:00', 4, 2),
(8, '2023-10-08', '19:00:00', 6, 3),
(9, '2023-10-09', '20:00:00', 2, 4),
(10, '2023-10-10', '18:30:00', 3, 5),
(11, '2023-10-11', '19:30:00', 1, 1),
(12, '2023-10-12', '20:30:00', 2, 2),
(13, '2023-10-13', '18:00:00', 3, 3),
(14, '2023-10-14', '19:00:00', 4, 4),
(15, '2023-10-15', '20:00:00', 5, 5);

-- Insert Orders
INSERT INTO Orders (OrderDate, Quantity, TotalCost, MenuID, CustomerID, BookingID, EmployeeID) VALUES 
('2023-10-01', 3, 200.00, 1, 1, 1, 1),
('2023-10-02', 2, 180.00, 2, 2, 2, 2),
('2023-10-03', 5, 250.00, 3, 3, 3, 3),
('2023-10-04', 2, 190.00, 4, 4, 4, 4),
('2023-10-05', 3, 210.00, 5, 5, 5, 5),
('2023-10-06', 2, 175.00, 6, 6, 6, 1),
('2023-10-07', 3, 230.00, 7, 4, 7, 2),
('2023-10-08', 2, 180.00, 8, 6, 8, 3),
('2023-10-09', 4, 260.00, 9, 2, 9, 4),
('2023-10-10', 1, 90.00, 10, 3, 10, 5),
('2023-10-11', 2, 185.00, 1, 1, 11, 1),
('2023-10-12', 3, 220.00, 2, 2, 12, 2),
('2023-10-13', 2, 170.00, 3, 3, 13, 3),
('2023-10-14', 1, 95.00, 4, 4, 14, 4),
('2023-10-15', 3, 240.00, 5, 5, 15, 5),
('2023-10-16', 2, 185.00, 6, 7, NULL, 1),
('2023-10-17', 4, 255.00, 7, 8, NULL, 2),
('2023-10-18', 1, 85.00, 8, 9, NULL, 3),
('2023-10-19', 2, 190.00, 9, 99, NULL, 4),
('2023-10-20', 3, 225.00, 10, 7, NULL, 5);

-- Insert Deliveries
INSERT INTO Deliveries (DeliveryDate, DeliveryStatus, OrderID, AddressID) VALUES 
('2023-10-02', 'Delivered', 1, 1),
('2023-10-03', 'Delivered', 2, 2),
('2023-10-04', 'Delivered', 3, 3),
('2023-10-05', 'In Transit', 4, 4),
('2023-10-06', 'Delivered', 5, 5),
('2023-10-07', 'Delivered', 6, 6),
('2023-10-08', 'In Transit', 7, 4),
('2023-10-09', 'Delivered', 8, 6),
('2023-10-10', 'Delivered', 9, 2),
('2023-10-11', 'In Transit', 10, 3),
('2023-10-12', 'Delivered', 11, 1),
('2023-10-13', 'Delivered', 12, 2),
('2023-10-14', 'In Transit', 13, 3),
('2023-10-15', 'Delivered', 14, 4),
('2023-10-16', 'Delivered', 15, 5),
('2023-10-17', 'Delivered', 16, 7),
('2023-10-18', 'In Transit', 17, 8),
('2023-10-19', 'Delivered', 18, 9),
('2023-10-20', 'Delivered', 19, 10),
('2023-10-21', 'In Transit', 20, 7);



