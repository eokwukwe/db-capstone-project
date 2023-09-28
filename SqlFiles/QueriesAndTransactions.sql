USE littlelemondb;

-- Task 1
-- Little Lemon wants to populate the Bookings table of their database with some records of data. Your first task is to replicate the list of records in the following table by adding them to the Little Lemon booking table. 

INSERT INTO Bookings(BookingDate, TableNumber, BookingSlot, CustomerID, EmployeeID)
VALUES ('2022-10-10', 5, '22:20:00', 2, 3),
	('2022-11-12', 15, '08:20:00', 9, 4),
	('2022-10-11', 2, '12:30:00', 3, 3),
	('2022-10-13', 10, '14:00:00', 7, 2);

-- Task 2
-- For your second task, Little Lemon need you to create a stored procedure called CheckBooking to check whether a table in the restaurant is already booked. Creating this procedure helps to minimize the effort involved in repeatedly coding the same SQL statements.
-- The procedure should have two input parameters in the form of booking date and table number. You can also create a variable in the procedure to check the status of each table.
DROP PROCEDURE IF EXISTS CheckBooking;

DELIMITER //
CREATE PROCEDURE CheckBooking(IN bookDate DATE, IN tableNo INT)
BEGIN
  DECLARE status VARCHAR(255);
  SELECT 
      CASE WHEN EXISTS
		  (SELECT * FROM Bookings WHERE BookingDate = bookDate AND TableNumber = tableNo)
          THEN
              CONCAT('Table ', tableNo, ' is already booked')
          ELSE 'Available'
      END
  INTO status;
SELECT status AS 'Booking status';
END //
DELIMITER ;

CALL CheckBooking('2023-10-02', 2);

-- Task 3
-- For your third and final task, Little Lemon need to verify a booking, and decline any reservations for tables that are already booked under another name. 
-- Since integrity is not optional, Little Lemon need to ensure that every booking attempt includes these verification and decline steps. However, implementing these steps requires a stored procedure and a transaction. 
-- To implement these steps, you need to create a new procedure called AddValidBooking. This procedure must use a transaction statement to perform a rollback if a customer reserves a table that’s already booked under another name.  
-- Use the following guidelines to complete this task:
-- The procedure should include two input parameters in the form of booking date and table number.
-- It also requires at least one variable and should begin with a START TRANSACTION statement.
-- Your INSERT statement must add a new booking record using the input parameter's values.
-- Use an IF ELSE statement to check if a table is already booked on the given date. 
-- If the table is already booked, then rollback the transaction. If the table is available, then commit the transaction. 

DROP PROCEDURE IF EXISTS ManageBooking;

DELIMITER //
CREATE PROCEDURE ManageBooking(
  IN bookDate DATE, 
  IN tableNo INT, 
  IN bookSlot VARCHAR(10), 
  IN customerId INT, 
  IN employeeId INT
)
BEGIN
  DECLARE status VARCHAR(255);

  START TRANSACTION;

  -- Check if the booking already exists
  IF NOT EXISTS (SELECT * FROM Bookings WHERE BookingDate = bookDate AND TableNumber = tableNo) THEN
    -- If not exists, then insert the new booking
    INSERT INTO Bookings(BookingDate, TableNumber, BookingSlot, CustomerID, EmployeeID)
    VALUES (bookDate, tableNo, bookSlot, customerId, employeeId);
    
    SET status = CONCAT('Table ', tableNo, ' is successfully booked.');
    
    COMMIT;
  ELSE
    -- If exists, then set the status to booked
    SET status = CONCAT('Table ', tableNo, ' is already booked - booking cancelled.');
    
    ROLLBACK;
  END IF;
  
  SELECT status AS 'Booking status';
END //
DELIMITER ;

CALL ManageBooking('2023-11-10', 10, '02:20:00', 2, 3);
