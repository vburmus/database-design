# Zapytania

### 1. Pacjenty sortowane po ilosci allergii wraz z ich przeliczaniem:
```
MATCH (p:Patient)-[:HAVE]->(a:Allergy)
WITH p, COUNT(a) AS number_of_allergies, COLLECT(a.name) AS allergies_list
RETURN
    p.pesel AS patient_pesel,
    p.last_name AS surname,
    p.first_name AS name,
    number_of_allergies,
    REDUCE(s = "", x IN allergies_list | s + x + ', ') AS allergies_list
ORDER BY number_of_allergies DESC, surname ASC, name ASC;
```
![q1](https://github.com/vburmus/database-design/assets/118392004/466dfd6a-16dd-4b20-8d92-9a12021d3580)
---
### 2. Lekarz który wydał najwięcej recept
```
MATCH (p:Prescription)-[:ISSUED_BY]->(d:Doctor)
WITH d, COUNT(p) AS number_of_prescriptions
RETURN
    d.pesel AS doctor_pesel,
    d.last_name AS surname,
    d.first_name AS name,
    number_of_prescriptions
ORDER BY number_of_prescriptions DESC, surname ASC, name ASC
LIMIT 1;
```
![q2](https://github.com/vburmus/database-design/assets/118392004/eda41ed2-4b70-40c4-aadc-331a1f69b4a4)
---
### 3. Leki powodujące najwięcej allergii
```
MATCH (m:Medicine)-[:CONTAINS]->(ms:Substance)<-[:ALLERGY_TO]-(a:Allergy)
WITH m, COUNT(a) AS number_of_allergies
RETURN
    m.permit_number AS permit_number,
    m.name AS name,
    number_of_allergies
ORDER BY number_of_allergies DESC, name ASC;
```
![q3](https://github.com/vburmus/database-design/assets/118392004/4d042778-1199-4fd8-bb19-a0c709711039)
---
### 4. Ilosc zrealizowanych recept wedlug apteki
```
MATCH (ph:Pharmacy)-[:REALIZED]->(p: Prescription)
WHERE p.status = 'realized'
WITH ph, COUNT(p) AS realized_prescription
RETURN
    ph.permit_number AS permit_number,
    ph.name AS name,
    ph.address AS address,
    realized_prescription
ORDER BY realized_prescription DESC, name ASC;
```
![q4](https://github.com/vburmus/database-design/assets/118392004/c6cce5c2-920e-4bfc-9a02-f4ef4ba88f93)
---
### 5. Pacjenci grupowani po ilosci otrzymanych recept
```
MATCH (pr:Prescription)-[:FOR]->(p:Patient)
WITH p, COUNT(pr) AS number_of_prescriptions
RETURN
    p.pesel AS patient_pesel,
    p.last_name AS surname,
    p.first_name AS name,
    number_of_prescriptions
ORDER BY number_of_prescriptions DESC, surname ASC, name ASC;
```
![q5](https://github.com/vburmus/database-design/assets/118392004/9289f59e-d81a-4e81-84a0-450b04b7387a)
---
### 6. Jakie leki sa najczęsciej przypisywane do recepty
```
MATCH (m:Medicine)<-[:OF]-(pr: Prescription)
WITH m, COUNT(pr) AS prescription_count
RETURN
    m.permit_number AS permit_number,
    m.name AS name,
    prescription_count AS  count
ORDER BY prescription_count DESC, name ASC;
```
![q6](https://github.com/vburmus/database-design/assets/118392004/94b7edf3-d14b-4e3f-8417-c7835f11d6ad)
---
### 7. Zamienniki leku po substancji
```
MATCH (m:Medicine)-[:CONTAINS]->(:Substance {name: 'z powodu'})
RETURN
    m.permit_number AS permit_number,
    m.name AS medicine_name;
```
![q7](https://github.com/vburmus/database-design/assets/118392004/9126c51b-988e-4f9f-84ac-ac0caf2af935)
---
### 8. Niezrealizowane recepty
```
MATCH (pr:Prescription)-[:FOR]->(p:Patient)
WHERE pr.status = 'not_realized'
RETURN
    p.pesel AS patient_pesel,
    p.last_name AS patient_surname,
    p.first_name AS patient_name,
    pr.expiration_date
ORDER BY pr.issue_date DESC, patient_surname ASC, patient_name ASC;
```
![q8](https://github.com/vburmus/database-design/assets/118392004/61117339-3e87-41b4-86b3-971208b1e8e3)
---
### 9. Spis lekow ze skladnikami
```
MATCH (m:Medicine)-[:CONTAINS]->(s:Substance)
RETURN
    m.permit_number AS permit_number,
    m.name AS medicine_name,
    COLLECT(s.name) AS substances_list;
```
![q9](https://github.com/vburmus/database-design/assets/118392004/ec4d473e-3991-46ab-9eeb-109b4ee311e4)
---
### 10. Ilosc lekow w poszczegolnych formach farmaceutycznych
```
MATCH (pf:PharmaceuticalForm)<-[:IS]-(m:Medicine)
RETURN
    pf.name AS pharmaceutical_form,
    COUNT(m) AS number_of_medicines;
```
![q10](https://github.com/vburmus/database-design/assets/118392004/3c76fd44-b36a-413e-85b4-c92fae1778bd)

