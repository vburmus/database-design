# Zajęcia 11 - Faza konceptualna i fizyczna


### 1. W jaki sposób definiowane są możliwe związki pomiędzy przechowywanymi danymi? Jakie wykorzystane mechanizmy zapewnienia spójności (jeśli istnieją)?  Czym różni się paradygmat BASE od paradygmatu ACID ? 
 - Związki między przechowywanymi danymi definiowane są za pomocą grafu. Graf składa się z węzłów, które reprezentują encje lub obiekty, oraz z krawędzi, które reprezentują relacje lub połączenia między tymi encjami.
 - BASE:
     - Basically Available - Oznacza, że system jest zawsze dostępny, nawet w przypadku awarii częściowej. Nie zapewnia to jednak pełnej spójności danych w każdym przypadku.

     - Soft state - Oznacza, że stan danych może zmieniać się nawet bez wprowadzania zmian, ponieważ nie ma wymogu utrzymania spójności danych w czasie rzeczywistym.

     - Eventually Consistent - Oznacza, że po jakimś czasie, po wprowadzeniu zmian, system osiągnie spójność danych. Systemy baz danych oparte na tej filozofii nie gwarantują natychmiastowej spójności danych po każdej operacji, ale zapewniają, że po pewnym czasie dane będą spójne.
 - Wykorzystany jest mechanizm ACID.
  
- Różnice:
  - Skalowanie: Baza danych, korzystająca z ACID, jest trudniejsza w skalowaniu ponieważ opiera się na niesprzeczności(consistency). Jednocześnie tylko jedna transakcja dozwolona dla rekordu, co sprawia ciężkie horyzontalne skalowanie.
  - Elastyczność: Z powyższego wynika, że jeżeli dwie aplikacje jednocześnie będą chcieli korzystać z tego samego rekordu, wtedy druga musi zaczekać. W BASE natomiast operacje dozwolone odrazu.
  - Synchronizacja: ACID blokuje record pod czas transakcji i synchronizuje dane dopiero po akceptowaniu czy odrzucaniu poprzedniej. BASE natomiast pozwala na czasową niespójność, musimy być tego świadomi.
 ![image](https://github.com/vburmus/database-design/assets/99145798/d519e1ca-4e8a-467d-af08-0d60fbbcdd6d)

- BASE vs ACID
  BASE - dostępność, ACID - spójność
  ![image](https://github.com/vburmus/database-design/assets/99145798/3baf3f93-b65c-4179-9557-730e0c43a86e)

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
CREATE (:Patient {firstName: "Adam", lastName:"Kowalski", pesel: "11111111111"})
-[:HAS_ACCOUNT] ->
(:User {email: "adamkw@yahoo.com", isAdmin: "False", password: "qwerty", phoneNumber: "79-494-96-03"})
```
- Dodawanie połączenia do istniejących węzłów:
```
MATCH (pat:Patient {pesel: "11111111111"}), (acc:User {email: "adamkw@yahoo.com"})
CREATE (pat) -[:HAS_ACCOUNT] -> acc
```
- Przykładowa kwerenda obliczająca doktora, który wydał najwięcej recept:
```
MATCH (d:Doctor)
OPTIONAL MATCH (p:Prescription)-[:ASSIGNED_BY]->(d)
WITH
    d.id AS doctor_id,
    d.lastName AS surname,
    d.firstName AS name,
    COUNT(p) AS number_of_prescriptions
RETURN 
    doctor_id,
    surname,
    name,
    number_of_prescriptions
ORDER BY 
    number_of_prescriptions DESC, surname ASC, name ASC
LIMIT 1
```
