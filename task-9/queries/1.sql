-- Pacjenty sortowane po ilosci allergii wraz z ich przeliczaniem
SELECT 
    p.id AS patient_id,
	p.last_name AS surname,
    p.first_name AS name,
    COUNT(pa.allergy_id) AS number_of_allergies,
    GROUP_CONCAT(a.name ORDER BY a.name ASC SEPARATOR ', ') AS allergies_list
FROM 
    patient p
JOIN 
    patient_allergy pa ON p.id = pa.patient_id
JOIN 
    allergy a ON pa.allergy_id = a.id
GROUP BY 
    p.id, p.first_name, p.last_name
ORDER BY number_of_allergies DESC, p.last_name ASC, p.first_name ASC
