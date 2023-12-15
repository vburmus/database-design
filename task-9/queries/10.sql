-- Niezrealizowane recepty
SELECT 
    pr.id AS prescription_id,
    p.id AS patient_id,
    p.last_name AS patient_surname,
    p.first_name AS patient_name,
    pr.issue_date,
    pr.is_cancelled
FROM 
    prescription pr
JOIN 
    patient p ON pr.patient_id = p.id
JOIN 
    entry e ON pr.id = e.prescription_id
WHERE 
    e.status != 'COMPLETED'
ORDER BY issue_date DESC, patient_surname ASC, patient_name ASC, is_cancelled DESC;