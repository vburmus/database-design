-- Ilosc lekow w poszczegolnych formach farmaceutycznych
SELECT pf.name AS pharmaceutical_form, COUNT(m.id) AS number_of_medicines
FROM pharmaceutical_form pf
LEFT JOIN medicine m ON pf.id = m.pharmaceutical_form_id
GROUP BY pf.name;