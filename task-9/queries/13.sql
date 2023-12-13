-- Doktory i pacjenci, ktorym byla przypisana recepta
SELECT d.id AS doctor_id, d.first_name, d.last_name, GROUP_CONCAT(p.first_name, ' ', p.last_name SEPARATOR ', ') AS patients
FROM doctor d
JOIN prescription pr ON d.id = pr.doctor_id
JOIN patient p ON pr.patient_id = p.id
GROUP BY d.id;