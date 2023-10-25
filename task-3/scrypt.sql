CREATE SCHEMA IF NOT EXISTS `test` DEFAULT CHARACTER SET utf8 ;
USE `test` ;


CREATE TABLE IF NOT EXISTS `test`.`pharmaceutical_form` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CHECK (LENGTH(`name`) > 0))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `test`.`category` (
  `symbol` VARCHAR(1) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`symbol`),
  UNIQUE INDEX `name_UNIQUE` (`description` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`symbol` ASC) VISIBLE,
  CHECK (LENGTH(`description`) > 0))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `test`.`medicine` (
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
    REFERENCES `test`.`pharmaceutical_form` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_medicine_category1`
    FOREIGN KEY (`category_symbol`)
    REFERENCES `test`.`category` (`symbol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CHECK (LENGTH(`name`) > 0),
	CHECK (LENGTH(`permit_number`) > 0))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`user` (
  `id` INT NOT NULL,
  `phone_number` VARCHAR(15) NULL,
  `email` VARCHAR(255) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `is_admin` TINYINT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  CHECK (LENGTH(`email`) > 0),
	CHECK (LENGTH(`login`) > 0),
	CHECK (LENGTH(`password`) > 0))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`doctor` (
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
    REFERENCES `test`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CHECK (LENGTH(`first_name`) > 0),
	CHECK (LENGTH(`last_name`) > 0),
	CHECK (LENGTH(`pesel`) > 0),
	CHECK (LENGTH(`pwz_number`) > 0))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `test`.`specialization` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CHECK (LENGTH(`name`) > 0))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`substance` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `source` ENUM("NATURAL", "SYNTHETIC") NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CHECK (LENGTH(`name`) > 0))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`allergy` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CHECK (LENGTH(`name`) > 0))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`patient` (
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
    REFERENCES `test`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CHECK (LENGTH(`first_name`) > 0),
	CHECK (LENGTH(`last_name`) > 0),
	CHECK (LENGTH(`pesel`) > 0))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `test`.`prescription` (
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
    REFERENCES `test`.`patient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_recepta_lekarz1`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `test`.`doctor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`entry` (
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
    REFERENCES `test`.`medicine` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_entry_prescription`
    FOREIGN KEY (`prescription_id`)
    REFERENCES `test`.`prescription` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CHECK (`quantity` > 0), 
CHECK (LENGTH(`dosage`) > 0))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `test`.`medicine_substance` (
  `substance_id` INT NOT NULL,
  `medicine_id` INT NOT NULL,
  PRIMARY KEY (`substance_id`, `medicine_id`),
  INDEX `fk_medicine_substance_medicine_idx` (`medicine_id` ASC) INVISIBLE,
  INDEX `fk_medicine_substance_substance_idx` (`substance_id` ASC) VISIBLE,
  CONSTRAINT `fk_medicine_substance_substance`
    FOREIGN KEY (`substance_id`)
    REFERENCES `test`.`substance` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_medicine_substance_medicine`
    FOREIGN KEY (`medicine_id`)
    REFERENCES `test`.`medicine` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`substance_allergy` (
  `substance_id` INT NOT NULL,
  `allergy_id` INT NOT NULL,
  PRIMARY KEY (`substance_id`, `allergy_id`),
  INDEX `fk_substance_allergy_allergy_idx` (`allergy_id` ASC) VISIBLE,
  INDEX `fk_substance_allergy_substance_idx` (`substance_id` ASC) INVISIBLE,
  CONSTRAINT `fk_substance_allergy_substance`
    FOREIGN KEY (`substance_id`)
    REFERENCES `test`.`substance` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_substance_allergy_allergy`
    FOREIGN KEY (`allergy_id`)
    REFERENCES `test`.`allergy` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `test`.`doctor_specialization` (
  `doctor_id` INT NOT NULL,
  `specialization_id` INT NOT NULL,
  PRIMARY KEY (`doctor_id`, `specialization_id`),
  INDEX `fk_lekarz_has_specjalizacja_specjalizacja1_idx` (`specialization_id` ASC) VISIBLE,
  INDEX `fk_lekarz_has_specjalizacja_lekarz1_idx` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_specialization_doctor`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `test`.`doctor` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_doctor_specialization_specialization`
    FOREIGN KEY (`specialization_id`)
    REFERENCES `test`.`specialization` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`specialization_category` (
  `specialization_id` INT NOT NULL,
  `category_symbol` VARCHAR(1) NOT NULL,
  INDEX `fk_specjalizacja_has_kategoria_kategoria1_idx` (`category_symbol` ASC) VISIBLE,
  INDEX `fk_specjalizacja_has_kategoria_specjalizacja1_idx` (`specialization_id` ASC) VISIBLE,
  PRIMARY KEY (`specialization_id`, `category_symbol`),
  CONSTRAINT `fk_specialization_category_specialization`
    FOREIGN KEY (`specialization_id`)
    REFERENCES `test`.`specialization` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_specialization_category_categoty`
    FOREIGN KEY (`category_symbol`)
    REFERENCES `test`.`category` (`symbol`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`patient_allergy` (
  `patient_id` INT NOT NULL,
  `allergy_id` INT NOT NULL,
  PRIMARY KEY (`patient_id`, `allergy_id`),
  INDEX `fk_patient_allergy_allergy_idx` (`allergy_id` ASC) VISIBLE,
  INDEX `fk_patient_allergy_patient_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_patient_allergy_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `test`.`patient` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_patient_allergy_allergy`
    FOREIGN KEY (`allergy_id`)
    REFERENCES `test`.`allergy` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`pharmacy` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(15) NULL,
  `permit_number` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CHECK (LENGTH(`name`) > 0),
CHECK (LENGTH(`address`) > 0),
CHECK (LENGTH(`permit_number`) > 0))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`pharmacist` (
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
    REFERENCES `test`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    CHECK (LENGTH(`first_name`) > 0),
	CHECK (LENGTH(`last_name`) > 0),
	CHECK (LENGTH(`pesel`) > 0),
	CHECK (LENGTH(`pwzf_number`) > 0))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`pharmacy_pharmacist` (
  `pharmacy_id` INT NOT NULL,
  `pharmacist_id` INT NOT NULL,
  PRIMARY KEY (`pharmacy_id`, `pharmacist_id`),
  INDEX `fk_pharmacy_pharmacist_pharmacist_idx` (`pharmacist_id` ASC) VISIBLE,
  INDEX `fk_pharmacy_pharmacist_pharmacy_idx` (`pharmacy_id` ASC) VISIBLE,
  CONSTRAINT `fk_pharmacy_pharmacist_pharmacy`
    FOREIGN KEY (`pharmacy_id`)
    REFERENCES `test`.`pharmacy` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pharmacy_pharmacist_pharmacist`
    FOREIGN KEY (`pharmacist_id`)
    REFERENCES `test`.`pharmacist` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `test`.`prescription_realization` (
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
    REFERENCES `test`.`pharmacy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_prescription_realization_entry`
    FOREIGN KEY (`entry_id`)
    REFERENCES `test`.`entry` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_prescription_realization_pharmacist`
    FOREIGN KEY (`pharmacist_id`)
    REFERENCES `test`.`pharmacist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
    CHECK (`realized_quantity` >= 0))
ENGINE = InnoDB;