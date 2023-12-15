-- Lekarz który wydał najwięcej recept
SELECT 
    d.id AS doctor_id,
    d.last_name AS surname,
    d.first_name AS name,
    COUNT(p.id) AS number_of_prescriptions
FROM 
    doctor d
LEFT JOIN 
    prescription p ON d.id = p.doctor_id
GROUP BY 
    d.id
ORDER BY 
    number_of_prescriptions DESC, d.last_name ASC, d.first_name ASC
LIMIT 1;
