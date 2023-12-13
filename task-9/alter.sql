-- Tworzenie tabeli prescription_realization
CREATE TABLE IF NOT EXISTS `online_prescription`.`prescription_realization` (
`id` BIGINT NOT NULL AUTO_INCREMENT,
`pharmacy_id` BIGINT NOT NULL,
`pharmacist_id` BIGINT NOT NULL,
`realization_date` DATETIME(6) NOT NULL,
PRIMARY KEY (`id`),
INDEX `FK_pr_pharmacy_id` (`pharmacy_id` ASC) VISIBLE,
INDEX `FK_pr_pharmacist_id` (`pharmacist_id` ASC) VISIBLE,
CONSTRAINT `FK_pr_pharmacy_id`
FOREIGN KEY (`pharmacy_id`)
REFERENCES `online_prescription`.`pharmacy` (`id`),
CONSTRAINT `FK_pr_pharmacist_id`
FOREIGN KEY (`pharmacist_id`)
REFERENCES `online_prescription`.`pharmacist` (`id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb3;

-- Dodawanie kolumny prescription_realization_id do tabeli prescription
ALTER TABLE `online_prescription`.`prescription`
ADD COLUMN `prescription_realization_id` BIGINT NULL DEFAULT NULL,
ADD CONSTRAINT `FK_prescription_realization`
FOREIGN KEY (`prescription_realization_id`)
REFERENCES `online_prescription`.`prescription_realization` (`id`);

-- Dodawanie innych kolumn do tabeli prescription
ALTER TABLE `online_prescription`.`prescription`
ADD COLUMN `medicine_id` BIGINT NOT NULL,
ADD COLUMN `quantity` INT NOT NULL,
ADD COLUMN `dosage` VARCHAR(45) NOT NULL,
ADD COLUMN `annotation` VARCHAR(255) NULL DEFAULT NULL;

-- Przenoszenie danych do nowych kolumn tabeli prescription
UPDATE `online_prescription`.`prescription`
SET `medicine_id` = (SELECT `medicine_id` FROM `online_prescription`.`entry` WHERE `entry`.`prescription_id` = `prescription`.`id` LIMIT 1),
    `quantity` = (SELECT `quantity` FROM `online_prescription`.`entry` WHERE `entry`.`prescription_id` = `prescription`.`id` LIMIT 1),
    `dosage` = (SELECT `dosage` FROM `online_prescription`.`entry` WHERE `entry`.`prescription_id` = `prescription`.`id` LIMIT 1),
    `annotation` = (SELECT `annotation` FROM `online_prescription`.`entry` WHERE `entry`.`prescription_id` = `prescription`.`id` LIMIT 1),
    `status` = (SELECT `status` FROM `online_prescription`.`entry` WHERE `entry`.`prescription_id` = `prescription`.`id` LIMIT 1);
 
-- Przenoszenie danych do tabeli prescription_realization
  
-- Usuwanie tabeli entry
-- DROP TABLE IF EXISTS `online_prescription`.`entry`;