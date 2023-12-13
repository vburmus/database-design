-- Średnia liczba leków na jedną receptę -- This query no more makes sense
SELECT 
    AVG(number_of_medicines) AS average_medicines_per_prescription
FROM 
    (SELECT 
        pr.id AS prescription_id,
        COUNT(e.medicine_id) AS number_of_medicines
    FROM 
        prescription pr
    LEFT JOIN 
        entry e ON pr.id = e.prescription_id
    GROUP BY 
        pr.id) AS prescription_medicines;