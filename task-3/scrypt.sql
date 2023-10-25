-- MySQL Workbench Forward Engineering

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
-- Table `mydb`.`pharmaceutical_form`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pharmaceutical_form` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `symbol` VARCHAR(1) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`symbol`),
  UNIQUE INDEX `name_UNIQUE` (`description` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`symbol` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`medicine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`medicine` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `permit_number` VARCHAR(5) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `pharmaceutical_form_id` INT NOT NULL,
  `category_symbol` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`id`, `pharmaceutical_form_id`, `category_symbol`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_medicine_pharmaceutical_form_idx` (`pharmaceutical_form_id` ASC) INVISIBLE,
  INDEX `fk_medicine_category1_idx` (`category_symbol` ASC) INVISIBLE,
  CONSTRAINT `fk_medicine_pharmaceutical_form`
    FOREIGN KEY (`pharmaceutical_form_id`)
    REFERENCES `mydb`.`pharmaceutical_form` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_medicine_category1`
    FOREIGN KEY (`category_symbol`)
    REFERENCES `mydb`.`category` (`symbol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT NOT NULL,
  `phone_number` VARCHAR(15) NULL,
  `email` VARCHAR(255) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `is_admin` TINYINT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`doctor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `pesel` VARCHAR(11) NOT NULL,
  `pwz_number` VARCHAR(7) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `pwz_number_UNIQUE` (`pwz_number` ASC) VISIBLE,
  INDEX `fk_doctor_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`specialization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`specialization` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`substance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`substance` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `source` ENUM("NATURAL", "SYNTHETIC") NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`allergy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`allergy` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`patient` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `pesel` VARCHAR(11) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_patient_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_patient_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prescription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prescription` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `issue_date` DATETIME NOT NULL,
  `is_cancelled` TINYINT NULL,
  `patient_id` INT NOT NULL,
  `doctor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_recepta_pacjent1_idx` (`patient_id` ASC) VISIBLE,
  INDEX `fk_recepta_lekarz1_idx` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_recepta_pacjent1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `mydb`.`patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_recepta_lekarz1`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `mydb`.`doctor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`entry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`entry` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `medicine_id` INT NOT NULL,
  `prescription_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `dosage` VARCHAR(45) NOT NULL,
  `annotation` VARCHAR(255) NULL,
  PRIMARY KEY (`id`, `medicine_id`, `prescription_id`),
  INDEX `fk_entry_prescription_idx` (`prescription_id` ASC) INVISIBLE,
  INDEX `fk_entry_medicine_idx` (`medicine_id` ASC) INVISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `medicine_id_UNIQUE` (`medicine_id` ASC) VISIBLE,
  CONSTRAINT `fk_entry_medicine`
    FOREIGN KEY (`medicine_id`)
    REFERENCES `mydb`.`medicine` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_entry_prescription`
    FOREIGN KEY (`prescription_id`)
    REFERENCES `mydb`.`prescription` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`medicine_substance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`medicine_substance` (
  `substance_id` INT NOT NULL,
  `medicine_id` INT NOT NULL,
  PRIMARY KEY (`substance_id`, `medicine_id`),
  INDEX `fk_medicine_substance_medicine_idx` (`medicine_id` ASC) INVISIBLE,
  INDEX `fk_medicine_substance_substance_idx` (`substance_id` ASC) VISIBLE,
  CONSTRAINT `fk_medicine_substance_substance`
    FOREIGN KEY (`substance_id`)
    REFERENCES `mydb`.`substance` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_medicine_substance_medicine`
    FOREIGN KEY (`medicine_id`)
    REFERENCES `mydb`.`medicine` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`substance_allergy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`substance_allergy` (
  `substance_id` INT NOT NULL,
  `allergy_id` INT NOT NULL,
  PRIMARY KEY (`substance_id`, `allergy_id`),
  INDEX `fk_substance_allergy_allergy_idx` (`allergy_id` ASC) VISIBLE,
  INDEX `fk_substance_allergy_substance_idx` (`substance_id` ASC) INVISIBLE,
  CONSTRAINT `fk_substance_allergy_substance`
    FOREIGN KEY (`substance_id`)
    REFERENCES `mydb`.`substance` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_substance_allergy_allergy`
    FOREIGN KEY (`allergy_id`)
    REFERENCES `mydb`.`allergy` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`kategoria_leku`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`kategoria_leku` (
  `lek_id` INT NOT NULL,
  `kategoria_leku` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`lek_id`, `kategoria_leku`),
  INDEX `fk_lek_has_kategoria_leku_kategoria_leku1_idx` (`kategoria_leku` ASC) VISIBLE,
  INDEX `fk_lek_has_kategoria_leku_lek1_idx` (`lek_id` ASC) VISIBLE,
  CONSTRAINT `fk_lek_has_kategoria_leku_lek1`
    FOREIGN KEY (`lek_id`)
    REFERENCES `mydb`.`medicine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lek_has_kategoria_leku_kategoria_leku1`
    FOREIGN KEY (`kategoria_leku`)
    REFERENCES `mydb`.`category` (`symbol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`doctor_specialization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`doctor_specialization` (
  `doctor_id` INT NOT NULL,
  `specialization_id` INT NOT NULL,
  PRIMARY KEY (`doctor_id`, `specialization_id`),
  INDEX `fk_lekarz_has_specjalizacja_specjalizacja1_idx` (`specialization_id` ASC) VISIBLE,
  INDEX `fk_lekarz_has_specjalizacja_lekarz1_idx` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_specialization_doctor`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `mydb`.`doctor` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_doctor_specialization_specialization`
    FOREIGN KEY (`specialization_id`)
    REFERENCES `mydb`.`specialization` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`specialization_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`specialization_category` (
  `specialization_id` INT NOT NULL,
  `category_symbol` VARCHAR(1) NOT NULL,
  INDEX `fk_specjalizacja_has_kategoria_kategoria1_idx` (`category_symbol` ASC) VISIBLE,
  INDEX `fk_specjalizacja_has_kategoria_specjalizacja1_idx` (`specialization_id` ASC) VISIBLE,
  PRIMARY KEY (`specialization_id`, `category_symbol`),
  CONSTRAINT `fk_specialization_category_specialization`
    FOREIGN KEY (`specialization_id`)
    REFERENCES `mydb`.`specialization` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_specialization_category_categoty`
    FOREIGN KEY (`category_symbol`)
    REFERENCES `mydb`.`category` (`symbol`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patient_allergy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`patient_allergy` (
  `patient_id` INT NOT NULL,
  `allergy_id` INT NOT NULL,
  PRIMARY KEY (`patient_id`, `allergy_id`),
  INDEX `fk_patient_allergy_allergy_idx` (`allergy_id` ASC) VISIBLE,
  INDEX `fk_patient_allergy_patient_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_patient_allergy_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `mydb`.`patient` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_patient_allergy_allergy`
    FOREIGN KEY (`allergy_id`)
    REFERENCES `mydb`.`allergy` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pharmacy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pharmacy` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(15) NULL,
  `permit_number` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pharmacist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pharmacist` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `pesel` VARCHAR(11) NOT NULL,
  `pwzf_number` VARCHAR(8) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_pharmacist_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_pharmacist_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pharmacy_pharmacist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pharmacy_pharmacist` (
  `pharmacy_id` INT NOT NULL,
  `pharmacist_id` INT NOT NULL,
  PRIMARY KEY (`pharmacy_id`, `pharmacist_id`),
  INDEX `fk_pharmacy_pharmacist_pharmacist_idx` (`pharmacist_id` ASC) VISIBLE,
  INDEX `fk_pharmacy_pharmacist_pharmacy_idx` (`pharmacy_id` ASC) VISIBLE,
  CONSTRAINT `fk_pharmacy_pharmacist_pharmacy`
    FOREIGN KEY (`pharmacy_id`)
    REFERENCES `mydb`.`pharmacy` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pharmacy_pharmacist_pharmacist`
    FOREIGN KEY (`pharmacist_id`)
    REFERENCES `mydb`.`pharmacist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`prescription_realization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`prescription_realization` (
  `pharmacy_id` INT NOT NULL,
  `pharmacist_id` INT NOT NULL,
  `entry_id` INT NOT NULL,
  `status` ENUM("COMPLETED", "ORDERED", "CANCELLED") NOT NULL,
  `realized_quantity` INT NOT NULL,
  PRIMARY KEY (`pharmacy_id`, `pharmacist_id`, `entry_id`),
  INDEX `fk_prescription_realization_entry_idx` (`entry_id` ASC) VISIBLE,
  INDEX `fk_prescription_realization_pharmacy_idx` (`pharmacy_id` ASC) VISIBLE,
  INDEX `fk_prescription_realization_pharmacist_idx` (`pharmacist_id` ASC) VISIBLE,
  CONSTRAINT `fk_prescription_realization_pharmacy`
    FOREIGN KEY (`pharmacy_id`)
    REFERENCES `mydb`.`pharmacy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_prescription_realization_entry`
    FOREIGN KEY (`entry_id`)
    REFERENCES `mydb`.`entry` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_prescription_realization_pharmacist`
    FOREIGN KEY (`pharmacist_id`)
    REFERENCES `mydb`.`pharmacist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;