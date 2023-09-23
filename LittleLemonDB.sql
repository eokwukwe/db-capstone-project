-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Roles` (
  `RoleID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`RoleID`),
  UNIQUE INDEX `RoleName_UNIQUE` (`Name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employees` (
  `EmployeeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `Salary` DECIMAL(10,2) UNSIGNED NULL,
  `ContactNumber` VARCHAR(20) NULL,
  `Address` VARCHAR(255) NULL,
  `RoleID` INT UNSIGNED NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  UNIQUE INDEX `ContactNumber_UNIQUE` (`ContactNumber` ASC) VISIBLE,
  INDEX `role_id_fk_idx` (`RoleID` ASC) VISIBLE,
  CONSTRAINT `role_id_fk`
    FOREIGN KEY (`RoleID`)
    REFERENCES `LittleLemonDB`.`Roles` (`RoleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(255) NULL,
  `ContactNumber` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Addresses` (
  `AddressID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Street` VARCHAR(255) NOT NULL,
  `City` VARCHAR(100) NOT NULL,
  `State` VARCHAR(100) NOT NULL,
  `Type` ENUM('Billing', 'Shipping', 'Work', 'Other') NOT NULL,
  `CustomerID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`AddressID`),
  INDEX `address_custome_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `address_custome_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `MenuID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Cuisine` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(200) NOT NULL,
  `Type` VARCHAR(100) NOT NULL,
  `Price` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems_Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems_Menus` (
  `MenuID` INT UNSIGNED NOT NULL,
  `MenuItemsID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`MenuID`, `MenuItemsID`),
  INDEX `menu_items_menu_items_id_fk_idx` (`MenuItemsID` ASC) VISIBLE,
  CONSTRAINT `menu_items_menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menus` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `menu_items_menu_items_id_fk`
    FOREIGN KEY (`MenuItemsID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `TableNumber` INT NOT NULL,
  `BookingDate` DATE NOT NULL,
  `BookingSlot` TIME NOT NULL,
  `CustomerID` INT UNSIGNED NOT NULL,
  `EmployeeID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `booking_customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `booking_employee_id_fk_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `booking_customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `booking_employee_id_fk`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDB`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NOT NULL,
  `TotalCost` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `CustomerID` INT UNSIGNED NULL COMMENT 'This can be NULL when the order is from a booking. If it is not NULL, then the order is from a walk-in customers. If it is NULL, the order originates from a booking.',
  `BookingID` INT UNSIGNED NULL COMMENT 'This can be NULL when the order is not from a booking. If it is not NULL, then the order originate from a customer with a booking. If it is NULL, the order originates from a walk-in customer that does not have a prior booking.\n\nThere will be a database-level check to ensure accurancy and interity:\nCHECK (BookingID IS NOT NULL OR CustomerID IS NOT NULL).\n\nThis CHECK constraint ensures that at least one of BookingID or CustomerID must be non-null. If both are null, the database will reject the insert or update operation.\n\nNote: The support for CHECK constraints was properly added in MySQL 8.0.16. So we must have to use this version',
  `EmployeeID` INT UNSIGNED NULL COMMENT 'EmployeeID can be NULL when the order is an online order',
  PRIMARY KEY (`OrderID`),
 CHECK (BookingID IS NOT NULL OR CustomerID IS NOT NULL),
  INDEX `order_customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `order_booking_id_fk_idx` (`BookingID` ASC) VISIBLE,
  INDEX `order_employee_id_fk_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `order_customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `order_booking_id_fk`
    FOREIGN KEY (`BookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `order_employee_id_fk`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDB`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDetails` (
  `OrderDetailID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `OrderID` INT UNSIGNED NOT NULL,
  `MenuItemID` INT UNSIGNED NOT NULL,
  `Quantity` INT NOT NULL,
  `Cost` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`OrderDetailID`),
  INDEX `order_detail_order_id_fk_idx` (`OrderID` ASC) VISIBLE,
  INDEX `order_detail_menu_item_id_fk_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `order_detail_order_id_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `order_detail_menu_item_id_fk`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Deliveries` (
  `DeliveryID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `DeliveryDate` DATE NOT NULL,
  `DeliveryStatus` ENUM('Pending', 'In Transit', 'Delivered') NOT NULL,
  `OrderID` INT UNSIGNED NOT NULL,
  `AddressID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `delivery_order_id_fk_idx` (`OrderID` ASC) VISIBLE,
  INDEX `delivery_address_id_fk_idx` (`AddressID` ASC) VISIBLE,
  UNIQUE INDEX `OrderID_UNIQUE` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `delivery_order_id_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `delivery_address_id_fk`
    FOREIGN KEY (`AddressID`)
    REFERENCES `LittleLemonDB`.`Addresses` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
