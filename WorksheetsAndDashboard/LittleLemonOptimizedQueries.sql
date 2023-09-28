USE littlelemondb;

-- Task 1
-- In this first task, Little Lemon need you to create a procedure that displays the maximum ordered quantity in the Orders table. 
-- Creating this procedure will allow Little Lemon to reuse the logic implemented in the procedure easily without retyping the same code over again and again to check the maximum quantity. 
-- You can call the procedure GetMaxQuantity.
DROP PROCEDURE IF EXISTS GetMaxQuantity;

CREATE PROCEDURE GetMaxQuantity()
	SELECT MAX(Quantity) AS 'Max Quantity in Order' FROM Orders;
    
CALL GetMaxQuantity();


-- Task 2
-- In the second task, Little Lemon need you to help them to create a prepared statement called GetOrderDetail. This prepared statement will help to reduce the parsing time of queries. It will also help to secure the database from SQL injections.
-- The prepared statement should accept one input argument, the CustomerID value, from a variable. 
-- The statement should return the order id, the quantity and the order cost from the Orders table. 
PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, TotalCost AS Cost FROM Orders WHERE OrderID = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

-- Task 3
-- Your third and final task is to create a stored procedure called CancelOrder. Little Lemon want to use this stored procedure to delete an order record based on the user input of the order id.
-- Creating this procedure will allow Little Lemon to cancel any order by specifying the order id value in the procedure parameter without typing the entire SQL delete statement.

DROP PROCEDURE IF EXISTS CancelOrder;
DELIMITER //
CREATE PROCEDURE CancelOrder(IN id INT)
BEGIN
	-- Declare a variable to hold the number of affected rows
    DECLARE affectedRow INT;
    
	DELETE FROM Orders WHERE OrderID = id;
    
	-- Get the number of affected rows
    SET affectedRow = ROW_COUNT();
    
	-- Check if the deletion was successful
    IF affectedRow = 1 THEN
        SELECT CONCAT('Order ', id, ' is cancelled.') AS Confirmation;
    ELSE
        SELECT CONCAT('No Order with ID ', id, ' was found.') AS Confirmation;
    END IF;
END //

DELIMITER ;

CALL CancelOrder(20);
