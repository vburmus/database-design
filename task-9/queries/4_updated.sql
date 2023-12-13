-- Ilosc zrealizowanych recept wedlug apteki
SELECT 
    ph.id AS pharmacy_id,
    ph.name AS name,
    ph.address AS address,
    COUNT(p.medicine_id) AS realized_entries
FROM 
    pharmacy ph
JOIN 
    prescription p ON ph.id = p.pharmacy_id
WHERE 
    e.status = 'COMPLETED'
GROUP BY 
    pharmacy_id
ORDER BY 
    realized_entries DESC, name ASC;