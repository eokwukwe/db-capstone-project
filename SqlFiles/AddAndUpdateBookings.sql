USE littlelemondb;

-- Task 1
-- In this first task you need to create a new procedure called AddBooking to add a new table booking record.
-- The procedure should include four input parameters in the form of the following bookings parameters:
-- booking id, 
-- customer id, 
-- booking date,
-- and table number.

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

-- Task 2
-- For your second task, Little Lemon need you to create a new procedure called UpdateBooking that they can use to update existing bookings in the booking table.
-- The procedure should have two input parameters in the form of booking id and booking date. You must also include an UPDATE statement inside the procedure. 

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


-- Task 3
-- For the third and final task, Little Lemon need you to create a new procedure called CancelBooking that they can use to cancel or remove a booking.
-- The procedure should have one input parameter in the form of booking id. You must also write a DELETE statement inside the procedure.

DROP PROCEDURE IF EXISTS CancelBooking;

DELIMITER //
CREATE PROCEDURE CancelBooking(
    IN bookingId INT
)
BEGIN    
  DELETE FROM Bookings WHERE BookingID = bookingId;
          
  SELECT CONCAT("Booking ", bookingId, " cancelled") AS Confirmation;
END //
DELIMITER ;