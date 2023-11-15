-- Wszystkie leki z podanym składnikiem
SELECT 
    m.id AS medicine_id,
    m.name AS medicine_name,
    m.permit_number
FROM 
    medicine m
JOIN 
    medicine_substance ms ON m.id = ms.medicine_id
JOIN 
    substance s ON ms.substance_id = s.id
WHERE 
    s.id = 1100
ORDER BY medicine_name ASC;