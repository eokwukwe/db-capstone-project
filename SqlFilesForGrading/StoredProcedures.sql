USE littlelemondb;

-- GetMaxQuantity procedure
DROP PROCEDURE IF EXISTS GetMaxQuantity;

CREATE PROCEDURE GetMaxQuantity()
	SELECT MAX(Quantity) AS 'Max Quantity in Order' FROM Orders;

-- ManageBooking procedure
DROP PROCEDURE IF EXISTS ManageBooking;

DELIMITER //
CREATE PROCEDURE ManageBooking(
  IN bookDate DATE, 
  IN tableNo INT
)
BEGIN
  DECLARE status VARCHAR(255);

  START TRANSACTION;

  -- Check if the booking already exists
  IF NOT EXISTS (SELECT * FROM Bookings WHERE BookingDate = bookDate AND TableNumber = tableNo) THEN
    -- If not exists, then insert the new booking
    INSERT INTO Bookings(BookingDate, TableNumber, BookingSlot, CustomerID, EmployeeID)
    VALUES (bookDate, tableNo, '18:25:00', 1, 2);
    
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

-- AddBooking procedure
DROP PROCEDURE IF EXISTS AddBooking;

DELIMITER //
CREATE PROCEDURE AddBooking(
    IN bookId INT,
    IN custId INT,
    IN tableNo INT,
    IN bookDate DATE
)
BEGIN
    
	INSERT INTO Bookings(BookingID, TableNumber, BookingDate, BookingSlot, CustomerID, EmployeeID)
		VALUES(bookId, tableNo, bookDate, '10:20:00', custId, 1);

END //
DELIMITER ;

-- UpdateBooking procedure
DROP PROCEDURE IF EXISTS UpdateBooking;

DELIMITER //
CREATE PROCEDURE UpdateBooking(
    IN bookId INT,
    IN bookDate DATE
)
BEGIN
    
  UPDATE Bookings
	SET BookingDate = bookDate
	WHERE BookingID = bookId;
END //
DELIMITER ;

-- CancelBooking procedure
DROP PROCEDURE IF EXISTS CancelBooking;

DELIMITER //
CREATE PROCEDURE CancelBooking(
    IN bookId INT
)
BEGIN    
  DELETE FROM Bookings WHERE BookingID = bookId;
END //
DELIMITER ;
