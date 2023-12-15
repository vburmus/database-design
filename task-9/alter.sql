CREATE TABLE new_prescription AS SELECT
    (@counter := @counter + 1) AS id,
    e.quantity,e.dosage, e.annotation,e.status,e.pharmacy_id,e.pharmacist_id,p.doctor_id,p.patient_id,p.issue_date, e.medicine_id
FROM
    (SELECT @counter := 0) AS init,
    online_prescription.entry AS e
JOIN
    online_prescription.prescription AS p ON e.prescription_id = p.id;
ALTER TABLE new_prescription
ADD PRIMARY KEY (id),

ADD CONSTRAINT `FK_pharmacy`
FOREIGN KEY (`pharmacy_id`)
REFERENCES `online_prescription`.`pharmacy` (`id`),

ADD CONSTRAINT `FK_pharmacist`
FOREIGN KEY (`pharmacist_id`)
REFERENCES `online_prescription`.`pharmacist` (`id`),

ADD CONSTRAINT `FK_medicines`
FOREIGN KEY (`medicine_id`)
REFERENCES `online_prescription`.`medicine` (`id`),

ADD CONSTRAINT `FK_doctor`
FOREIGN KEY (`doctor_id`)
REFERENCES `online_prescription`.`doctor` (`id`),

ADD CONSTRAINT `FK_patient`
FOREIGN KEY (`patient_id`)
REFERENCES `online_prescription`.`patient` (`id`);

DROP TABLE entry;
DROP TABLE prescription;
RENAME TABLE new_prescription TO prescription;
