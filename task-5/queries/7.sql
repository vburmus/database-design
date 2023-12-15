-- Jakie leki sa najczęsciej przypisywane do recepty 
SELECT 
    m.id AS medicine_id,
    m.name AS name,
    m.permit_number,
    COUNT(e.medicine_id) AS prescription_count
FROM 
    medicine m
JOIN 
    entry e ON m.id = e.medicine_id
GROUP BY 
    m.id
ORDER BY 
    prescription_count DESC, name ASC;