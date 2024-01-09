# Zajęcia 11 - Faza konceptualna i fizyczna



### 2. Prezentacja przykładowych zapytań
- Wyszukiwanie wszystkich węzłów wraz z połączeniami w bazie danych:
```
MATCH (n) RETURN n
```
- Wyszukiwanie konkretnych węzłów:
  - pacjentów:
    ```
    MATCH (patient:Patient) RETURN patient
    ```
  - doktorów:
    ```
    MATCH (doc:Doctor) RETURN doc
    ```
- Limit wyszukiwania:
```
MATCH (patient:Patient) RETURN patient LIMIT 10
```
- Wyszukiwanie z filtrem:
  - pacjentów:
    ```
    MATCH (patient:Patient {firstName: "Helena"}) RETURN patient
    ```
  - recept:
    ```
    MATCH (pr:Prescription) WHERE pr.status = "COMPLETED" RETURN pr
    ```
  - doktorów:
    ```
    MATCH (doc:Doctor) WHERE doc.lastName = "Adamiec" RETURN doc
    ```
- Wyszukiwanie konkretnej właściwości:
  - pacjentów:
    ```
    MATCH (patient:Patient) RETURN patient.pesel AS PESEL
    ```
  - recept:
    ```
    MATCH (pr:Prescription) RETURN pr.annotation AS Annotation
    ```
- Wyszukiwanie weżłów wraz z połączeniami:
  - pacjenty wraz z receptami:
    ```
    MATCH  (pr:Prescription) -[]-> (patient:Patient) RETURN patient, pr
    ```
- Dodawanie węzłów/rekordów do bazy wraz z połączeniem:
```
MATCH (:Patient {firstName: "Adam", lastName:"Kowalski", pesel: "11111111111"})
-[:HAS_ACCOUNT] ->
(:User {email: "adamkw@yahoo.com", isAdmin: "False", password: "qwerty", phoneNumber: "79-494-96-03"})
```
- Dodawanie połączenia do istniejących węzłów:
```
MATCH (pat:Patient {pesel: "11111111111"}), (acc:User {email: "adamkw@yahoo.com"})
CREATE (pat) -[:HAS_ACCOUNT] -> acc
```
