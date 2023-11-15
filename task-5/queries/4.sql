-- Ilosc zrealizowanych wpisów wedlug apteki
SELECT 
    ph.id AS pharmacy_id,
    ph.name AS name,
    ph.address AS address,
    COUNT(e.medicine_id) AS realized_entries
FROM 
    pharmacy ph
JOIN 
    entry e ON ph.id = e.pharmacy_id
WHERE 
    e.status = 'COMPLETED'
GROUP BY 
    pharmacy_id
ORDER BY 
    realized_entries DESC, name ASC;