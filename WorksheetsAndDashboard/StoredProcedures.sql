-- Get max quantity in an order
CREATE PROCEDURE GetMaxQuantity()
	SELECT MAX(Quantity) AS 'Max Quantity in Order' FROM Orders;

-- Manage a booking
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

-- Add a new booking
DELIMITER //
CREATE PROCEDURE AddBooking(
    IN customerId INT,
    IN bookingDate DATE,
    IN tableNo INT,
    IN employeeId INT,
    IN bookingSlot TIME
)
BEGIN
    
	INSERT INTO Bookings(TableNumber, BookingDate, BookingSlot, CustomerID, EmployeeID)
		VALUEs(tableNo, bookingDate, bookingSlot, customerId, employeeId);
        
	SELECT "New booking added" AS Confirmation;
END //
DELIMITER ;

-- Update a booking
DELIMITER //
CREATE PROCEDURE UpdateBooking(
    IN bookingId INT,
    IN bookingDate DATE
)
BEGIN
    
  UPDATE Bookings
	SET BookingDate = bookingDate
	WHERE BookingID = bookingId;
        
  SELECT CONCAT("Booking ", bookingId, " updated") AS Confirmation;
END //
DELIMITER ;


-- Cancel a booking
DELIMITER //
CREATE PROCEDURE CancelBooking(
    IN bookingId INT
)
BEGIN
    
  DELETE FROM Bookings WHERE BookingID = bookingId;
        
  SELECT CONCAT("Booking ", bookingId, " cancelled") AS Confirmation;
END //
DELIMITER ;