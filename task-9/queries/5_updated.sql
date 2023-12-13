-- Ilość zrealizowanych recept przez danego farmaceutę
SELECT 
    pr.pharmacist_id,
    p.last_name AS surname,
    p.first_name AS name,
    COUNT(e.pharmacist_id) AS realized_entries
FROM 
    prescription pr
JOIN 
    pharmacist p ON pr.pharmacist_id = p.id
WHERE 
    pr.status = 'COMPLETED' AND e.pharmacist_id = 1002
GROUP BY 
    pr.pharmacist_id