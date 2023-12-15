-- Spis lekow ze skladnikami
SELECT m.id AS medicine_id, m.name AS medicine_name,
       GROUP_CONCAT(s.name SEPARATOR ', ') AS substances_list
FROM medicine m
INNER JOIN medicine_substance ms ON m.id = ms.medicine_id
INNER JOIN substance s ON ms.substance_id = s.id
GROUP BY m.id