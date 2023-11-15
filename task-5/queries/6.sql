-- Pacjenci grupowani po ilosci otrzymanych recept
SELECT 
    p.id AS patient_id,
    p.last_name AS surname,
    p.first_name AS name,
    COUNT(pr.id) AS number_of_prescriptions
FROM 
    patient p
LEFT JOIN 
    prescription pr ON p.id = pr.patient_id
GROUP BY 
    p.id
ORDER BY 
    number_of_prescriptions DESC, surname ASC, name ASC;