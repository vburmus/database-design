-- Leki powodujące najwięcej allergii
SELECT 
    m.id AS medicine_id,
    m.name AS medicine_name,
    COUNT(sa.allergy_id) AS number_of_allergies
FROM 
    medicine m
JOIN 
    medicine_substance ms ON m.id = ms.medicine_id
JOIN 
    substance_allergy sa ON ms.substance_id = sa.substance_id
GROUP BY 
    medicine_id
ORDER BY 
    number_of_allergies DESC, medicine_name ASC;