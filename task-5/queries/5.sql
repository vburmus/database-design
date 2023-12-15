-- Ilość zrealizowanych wpisów przez danego farmaceutę
SELECT 
    e.pharmacist_id,
    p.last_name AS surname,
    p.first_name AS name,
    COUNT(e.pharmacist_id) AS realized_entries
FROM 
    entry e
JOIN 
    pharmacist p ON e.pharmacist_id = p.id
WHERE 
    e.status = 'COMPLETED' AND e.pharmacist_id = 1002
GROUP BY 
    e.pharmacist_id