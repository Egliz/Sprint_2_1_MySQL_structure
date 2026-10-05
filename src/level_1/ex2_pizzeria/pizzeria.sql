
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`province` (
  `id_province` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_province`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`locality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`locality` (
  `id_locality` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `id_province` INT NOT NULL,
  PRIMARY KEY (`id_locality`),
  INDEX `fk_locality_Province_idx` (`id_province` ASC) VISIBLE,
  CONSTRAINT `fk_locality_Province`
    FOREIGN KEY (`id_province`)
    REFERENCES `mydb`.`province` (`id_province`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `id_customer` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `id_locality` INT NOT NULL,
  PRIMARY KEY (`id_customer`),
  INDEX `fk_customer_locality1_idx` (`id_locality` ASC) VISIBLE,
  CONSTRAINT `fk_customer_locality1`
    FOREIGN KEY (`id_locality`)
    REFERENCES `mydb`.`locality` (`id_locality`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`restaurant` (
  `id_restaurant` INT NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `postcode` VARCHAR(45) NOT NULL,
  `id_locality` INT NOT NULL,
  PRIMARY KEY (`id_restaurant`),
  INDEX `fk_id_locality_idx` (`id_locality` ASC) VISIBLE,
  CONSTRAINT `fk_id_locality`
    FOREIGN KEY (`id_locality`)
    REFERENCES `mydb`.`locality` (`id_locality`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employee` (
  `id_employee` INT NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `workstation` ENUM('delivery_driver', 'cook') NOT NULL,
  `id_restaurant` INT NOT NULL,
  PRIMARY KEY (`id_employee`),
  INDEX `fk_employee_restaurant1_idx` (`id_restaurant` ASC) VISIBLE,
  CONSTRAINT `fk_employee_restaurant1`
    FOREIGN KEY (`id_restaurant`)
    REFERENCES `mydb`.`restaurant` (`id_restaurant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `id_order` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `price` DOUBLE NOT NULL,
  `home_delivery` ENUM('yes', 'no') NOT NULL,
  `delivery_date` DATETIME NULL,
  `id_customer` INT NOT NULL,
  `id_restaurant` INT NOT NULL,
  `id_delivery` INT NULL,
  PRIMARY KEY (`id_order`),
  INDEX `fk_order_customer1_idx` (`id_customer` ASC) VISIBLE,
  INDEX `fk_order_restaurant1_idx` (`id_restaurant` ASC) VISIBLE,
  INDEX `fk_order_id_delivery_idx` (`id_delivery` ASC) VISIBLE,
  CONSTRAINT `fk_order_customer1`
    FOREIGN KEY (`id_customer`)
    REFERENCES `mydb`.`customer` (`id_customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_restaurant1`
    FOREIGN KEY (`id_restaurant`)
    REFERENCES `mydb`.`restaurant` (`id_restaurant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_id_delivery`
    FOREIGN KEY (`id_delivery`)
    REFERENCES `mydb`.`employee` (`id_employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product_category` (
  `id_product_category` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_product_category`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`product` (
  `id_product` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `price` DOUBLE NOT NULL,
  `images` VARCHAR(255) NOT NULL,
  `id_product_category` INT NOT NULL,
  PRIMARY KEY (`id_product`),
  INDEX `fk_product_product_category1_idx` (`id_product_category` ASC) VISIBLE,
  CONSTRAINT `fk_product_product_category1`
    FOREIGN KEY (`id_product_category`)
    REFERENCES `mydb`.`product_category` (`id_product_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`quantity_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`quantity_product` (
  `quantity` INT NOT NULL,
  `id_order` INT NOT NULL,
  `id_product` INT NOT NULL,
  INDEX `fk_quantity_product_order1_idx` (`id_order` ASC) VISIBLE,
  INDEX `fk_quantity_product_product1_idx` (`id_product` ASC) VISIBLE,
  PRIMARY KEY (`id_product`, `id_order`),
  CONSTRAINT `fk_quantity_product_order1`
    FOREIGN KEY (`id_order`)
    REFERENCES `mydb`.`order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_quantity_product_product1`
    FOREIGN KEY (`id_product`)
    REFERENCES `mydb`.`product` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


    USE `mydb`;

-- -----------------------------------------------------
-- Data for table `province`
-- -----------------------------------------------------

INSERT INTO `province` (`id_province`, `name`)
VALUES
    (1, 'Barcelona'),
    (2, 'Girona');


-- -----------------------------------------------------
-- Data for table `locality`
-- -----------------------------------------------------

INSERT INTO `locality` (`id_locality`, `name`, `id_province`)
VALUES
    (1, 'Barcelona', 1),
    (2, 'Badalona', 1),
    (3, 'Girona', 2);


-- -----------------------------------------------------
-- Data for table `customer`
-- -----------------------------------------------------

INSERT INTO `customer` (`id_customer`, `name`, `email`, `id_locality`)
VALUES
    (1, 'Laura Garcia', 'laura@email.com', 1),
    (2, 'Carlos Martinez', 'carlos@email.com', 1),
    (3, 'Ana Lopez', 'ana@email.com', 2),
    (4, 'David Sanchez', 'david@email.com', 3);


-- -----------------------------------------------------
-- Data for table `restaurant`
-- -----------------------------------------------------

INSERT INTO `restaurant` (`id_restaurant`, `address`, `postcode`, `id_locality`)
VALUES
    (1, 'Carrer Mallorca 120', '08036', 1),
    (2, 'Carrer Major 45', '08901', 2);


-- -----------------------------------------------------
-- Data for table `employee`
-- -----------------------------------------------------

INSERT INTO `employee`
(`id_employee`, `nif`, `name`, `surname`, `phone`, `workstation`, `id_restaurant`)
VALUES
    (1, '12345678A', 'Maria', 'Sanchez', '600100001', 'cook', 1),
    (2, '23456789B', 'David', 'Perez', '600100002', 'delivery_driver', 1),
    (3, '34567890C', 'Laura', 'Martin', '600100003', 'delivery_driver', 2),
    (4, '45678901D', 'Carlos', 'Garcia', '600100004', 'cook', 2);


-- -----------------------------------------------------
-- Data for table `product_category`
-- -----------------------------------------------------

INSERT INTO `product_category` (`id_product_category`, `name`)
VALUES
    (1, 'Pizzes'),
    (2, 'Hamburgueses'),
    (3, 'Begudes');


-- -----------------------------------------------------
-- Data for table `product`
-- -----------------------------------------------------

INSERT INTO `product`
(`id_product`, `name`, `description`, `price`, `images`, `id_product_category`)
VALUES
    (1, 'Pizza Margherita', 'Tomato and cheese', 9.50, 'margherita.jpg', 1),
    (2, 'Pizza Carbonara', 'Cream and bacon', 11.50, 'carbonara.jpg', 1),
    (3, 'Hamburguesa Classic', 'Beef and cheese', 8.50, 'classic.jpg', 2),
    (4, 'Coca-Cola', 'Soft drink', 2.50, 'cocacola.jpg', 3),
    (5, 'Water', 'Mineral water', 1.50, 'water.jpg', 3),
    (6, 'Fanta', 'Orange soft drink', 2.50, 'fanta.jpg', 3);


-- -----------------------------------------------------
-- Data for table `order`
-- -----------------------------------------------------

INSERT INTO `order`
(`id_order`, `date`, `price`, `home_delivery`, `delivery_date`,
 `id_customer`, `id_restaurant`, `id_delivery`)
VALUES
    (1, '2026-09-20 13:30:00', 14.50, 'yes',
     '2026-09-20 14:00:00', 1, 1, 2),

    (2, '2026-09-21 20:00:00', 12.00, 'no',
     NULL, 2, 1, NULL),

    (3, '2026-09-22 13:00:00', 17.50, 'yes',
     '2026-09-22 13:40:00', 3, 2, 3),

    (4, '2026-09-23 21:00:00', 12.50, 'yes',
     '2026-09-23 22:00:00', 1, 1, 2),

    (5, '2026-09-24 14:00:00', 14.00, 'no',
     NULL, 4, 2, NULL);


-- -----------------------------------------------------
-- Data for table `quantity_product`
-- -----------------------------------------------------

INSERT INTO `quantity_product` (`quantity`, `id_order`, `id_product`)
VALUES
    (1, 1, 1),
    (2, 1, 4),

    (1, 2, 3),
    (1, 2, 5),

    (1, 3, 2),
    (2, 3, 4),

    (1, 4, 1),
    (1, 4, 6),

    (1, 5, 3),
    (1, 5, 5);