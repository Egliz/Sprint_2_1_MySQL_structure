SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema glasses_store
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema glasses_store
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `glasses_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `glasses_store` ;

-- -----------------------------------------------------
-- Table `glasses_store`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_store`.`address` (
  `id_address` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `number` INT NOT NULL,
  `floor` INT NULL DEFAULT NULL,
  `door` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_address`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `glasses_store`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_store`.`supplier` (
  `id_supplier` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `id_address` INT NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `fax` VARCHAR(45) NULL DEFAULT NULL,
  `nif` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_supplier`),
  UNIQUE INDEX `id_address` (`id_address` ASC) VISIBLE,
  CONSTRAINT `supplier_ibfk_1`
    FOREIGN KEY (`id_address`)
    REFERENCES `glasses_store`.`address` (`id_address`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `glasses_store`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_store`.`brand` (
  `id_brand` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `id_supplier` INT NOT NULL,
  PRIMARY KEY (`id_brand`),
  INDEX `id_supplier` (`id_supplier` ASC) VISIBLE,
  CONSTRAINT `brand_ibfk_1`
    FOREIGN KEY (`id_supplier`)
    REFERENCES `glasses_store`.`supplier` (`id_supplier`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `glasses_store`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_store`.`customer` (
  `id_customer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `id_address` INT NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `registration_date` DATE NOT NULL,
  `id_customer_referrer` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_customer`),
  INDEX `id_address` (`id_address` ASC) VISIBLE,
  INDEX `id_customer_referrer` (`id_customer_referrer` ASC) VISIBLE,
  CONSTRAINT `customer_ibfk_1`
    FOREIGN KEY (`id_address`)
    REFERENCES `glasses_store`.`address` (`id_address`),
  CONSTRAINT `customer_ibfk_2`
    FOREIGN KEY (`id_customer_referrer`)
    REFERENCES `glasses_store`.`customer` (`id_customer`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `glasses_store`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_store`.`employee` (
  `id_employee` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_employee`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `glasses_store`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_store`.`glasses` (
  `id_glasses` INT NOT NULL AUTO_INCREMENT,
  `id_brand` INT NOT NULL,
  `right_prescription` DOUBLE NOT NULL,
  `left_prescription` DOUBLE NOT NULL,
  `frame_type` ENUM('floating', 'plastic', 'metal') NOT NULL,
  `frame_color` VARCHAR(45) NOT NULL,
  `right_lens_color` VARCHAR(45) NOT NULL,
  `left_lens_color` VARCHAR(45) NOT NULL,
  `price` DOUBLE NOT NULL,
  PRIMARY KEY (`id_glasses`),
  INDEX `id_brand` (`id_brand` ASC) VISIBLE,
  CONSTRAINT `glasses_ibfk_1`
    FOREIGN KEY (`id_brand`)
    REFERENCES `glasses_store`.`brand` (`id_brand`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `glasses_store`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `glasses_store`.`sale` (
  `id_sale` INT NOT NULL AUTO_INCREMENT,
  `id_customer` INT NOT NULL,
  `id_glasses` INT NOT NULL,
  `id_employee` INT NOT NULL,
  `sale_date` DATE NOT NULL,
  PRIMARY KEY (`id_sale`),
  INDEX `id_customer` (`id_customer` ASC) VISIBLE,
  INDEX `id_glasses` (`id_glasses` ASC) VISIBLE,
  INDEX `id_employee` (`id_employee` ASC) VISIBLE,
  CONSTRAINT `sale_ibfk_1`
    FOREIGN KEY (`id_customer`)
    REFERENCES `glasses_store`.`customer` (`id_customer`),
  CONSTRAINT `sale_ibfk_2`
    FOREIGN KEY (`id_glasses`)
    REFERENCES `glasses_store`.`glasses` (`id_glasses`),
  CONSTRAINT `sale_ibfk_3`
    FOREIGN KEY (`id_employee`)
    REFERENCES `glasses_store`.`employee` (`id_employee`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


    USE `glasses_store`;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------

INSERT INTO `address`
(`id_address`, `street`, `number`, `floor`, `door`, `city`, `postal_code`, `country`)
VALUES
    (1, 'Carrer Mallorca', 120, 2, '1A', 'Barcelona', '08036', 'Spain'),
    (2, 'Carrer Valencia', 45, 1, '2B', 'Barcelona', '08015', 'Spain'),
    (3, 'Carrer Arago', 78, NULL, NULL, 'Barcelona', '08015', 'Spain'),
    (4, 'Carrer Girona', 30, 3, '1A', 'Barcelona', '08009', 'Spain'),
    (5, 'Avinguda Diagonal', 250, 2, '2A', 'Barcelona', '08013', 'Spain'),
    (6, 'Carrer Marina', 90, 1, '1B', 'Barcelona', '08018', 'Spain');


-- -----------------------------------------------------
-- Data for table `supplier`
-- -----------------------------------------------------

INSERT INTO `supplier`
(`id_supplier`, `name`, `id_address`, `phone`, `fax`, `nif`)
VALUES
    (1, 'Vision Supplies', 1, '933001001', '933001002', 'B12345678'),
    (2, 'Optical World', 2, '933002001', '933002002', 'B87654321'),
    (3, 'Lens Distribution', 3, '933003001', NULL, 'B11223344');


-- -----------------------------------------------------
-- Data for table `brand`
-- -----------------------------------------------------

INSERT INTO `brand`
(`id_brand`, `name`, `id_supplier`)
VALUES
    (1, 'Ray-Ban', 1),
    (2, 'Oakley', 1),
    (3, 'Vogue', 2),
    (4, 'Gucci', 3);


-- -----------------------------------------------------
-- Data for table `customer`
-- -----------------------------------------------------

INSERT INTO `customer`
(`id_customer`, `name`, `id_address`, `phone`, `email`, `registration_date`, `id_customer_referrer`)
VALUES
    (1, 'Laura Garcia', 4, '600100001', 'laura@email.com', '2025-01-10', NULL),
    (2, 'Carlos Martinez', 5, '600100002', 'carlos@email.com', '2025-03-15', 1),
    (3, 'Ana Lopez', 6, '600100003', 'ana@email.com', '2025-06-20', 1);


-- -----------------------------------------------------
-- Data for table `employee`
-- -----------------------------------------------------

INSERT INTO `employee`
(`id_employee`, `name`)
VALUES
    (1, 'Maria Sanchez'),
    (2, 'David Perez'),
    (3, 'Laura Martin');


-- -----------------------------------------------------
-- Data for table `glasses`
-- -----------------------------------------------------

INSERT INTO `glasses`
(`id_glasses`, `id_brand`, `right_prescription`, `left_prescription`,
 `frame_type`, `frame_color`, `right_lens_color`, `left_lens_color`, `price`)
VALUES
    (1, 1, -1.50, -1.25, 'plastic', 'Black', 'Transparent', 'Transparent', 120),
    (2, 1, 2.00, 1.75, 'metal', 'Gold', 'Brown', 'Brown', 150),
    (3, 2, -2.00, -2.00, 'floating', 'Black', 'Grey', 'Grey', 180),
    (4, 3, 1.25, 1.00, 'plastic', 'Red', 'Transparent', 'Transparent', 110),
    (5, 4, -0.75, -1.00, 'metal', 'Gold', 'Green', 'Green', 250);


-- -----------------------------------------------------
-- Data for table `sale`
-- -----------------------------------------------------

INSERT INTO `sale`
(`id_sale`, `id_customer`, `id_glasses`, `id_employee`, `sale_date`)
VALUES
    (1, 1, 1, 1, '2025-02-10'),
    (2, 1, 3, 2, '2025-05-15'),
    (3, 2, 2, 1, '2025-06-20'),
    (4, 2, 4, 3, '2025-09-10'),
    (5, 3, 5, 1, '2025-11-05'),
    (6, 3, 1, 2, '2026-01-15');