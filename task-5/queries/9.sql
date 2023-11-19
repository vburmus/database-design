-- Zamienniki leku po substancji
SELECT m.id AS medicine_id, m.name AS medicine_name
FROM medicine m
INNER JOIN medicine_substance ms ON m.id = ms.medicine_id
INNER JOIN substance s ON ms.substance_id = s.id
WHERE s.name = 'fgWmKyRwdp1';