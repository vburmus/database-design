# Analiza porównawcza z projektem relacyjnej bazy danych. 
### Jakie są główne różnice w projektach zrealizowanych za pomocą bazy relacyjnej i nierelacyjnej?
  - W bazie relacyjnej dane są przechowywane w tabelach, które są połączone relacjami. W bazie nierelacyjnej grafowej dane są przechowywane
w węzłach, które są połączone krawędziami.
  - W bazie grafowej (neo4j) zaletą jest bardzo intuicyjny język zapytań (Cypher), który jest bardzo czytelny i zrozumiały nawet w przypadku
złożonych zapytań. 
  - W bazie grafowej (neo4j) nie ma potrzeby definiowania schematu bazy danych, indeksów  oraz relacji między węzłami, ponieważ relacje są 
tworzone dynamicznie w momencie zapytania.
### Czy ich zastosowania są tożsame i można je traktować wymiennie? 
- Z jednej strony - tak, ponieważ obie bazy danych są wykorzystywane do przechowywania danych  oraz korzystają z ACID(w przypadku 
  nierelacyjnej grafowej). 
- Z drugiej strony - nie, ponieważ mamy różnicę w : 
  * schematach
  * skalowalności
  * językach zapytań
  * szybkości dostępu do danych
### W jakich zastosowaniach lepiej sprawdzają się bazy relacyjne, a w jakich Neo4j?
  - Relacyjne:
     * Systemy Transakcyjne, gdzie kluczowe są operacje związane z :
       + przetwarzaniem transakcji finansowych
       + zarządzaniem zamówieniami
     * POS (Point of Sale) - systemy sprzedaży, gdzie kluczowe są operacje związane z :
       + zarządzaniem magazynem
       + zarządzaniem zamówieniami
       + zarządzaniem klientami
     * Aplikacje, które wymagają znanej struktury danych
  - Neo4j 
    * Analiza relacji i grafów
      + silnie rozbudowane relacje między danymi
    * Rekomendacje i sieci społecznościowe
      + rekomendacje produktów
      + rekomendacje znajomych
    * Śledzenie związków miedzy węzłami
  #### Podsumowanie:  
Bazy relacyjne są lepsze w obszarach, gdzie ważna jest integralność danych a struktura danych jest stała. Natomiast bazy grafowe, takie 
jak Neo4j, sprawdzają się doskonale w przypadkach, gdzie analiza relacji między danymi jest kluczowa. Ostateczny wybór zależy od specyfiki 
projektu, a w niektórych sytuacjach może być korzystne skorzystanie z obu typów baz danych w ramach jednego systemu, wykorzystując mocne strony każdej z nich.

### Czy pojawiła się konieczność zmiany założeń lub wybrane wymagania były niemożliwe do zrealizowania?
### W jaki sposób wybrana baza NoSQL różni się od bazy relacyjnej pod względem definiowania zapytań?
 - Cypher
```
MATCH (p:Patient)-[:HAS_ALLERGY]->(a:Allergy)
WITH p, COUNT(a) AS number_of_allergies, COLLECT(a.name) AS allergies_list
RETURN p.id AS patient_id, p.last_name AS surname, p.first_name AS name,
       number_of_allergies, allergies_list
ORDER BY number_of_allergies DESC, surname ASC, name ASC;
```
___
 - SQL
```
SELECT 
    p.id AS patient_id,
	p.last_name AS surname,
    p.first_name AS name,
    COUNT(pa.allergy_id) AS number_of_allergies,
    GROUP_CONCAT(a.name ORDER BY a.name ASC SEPARATOR ', ') AS allergies_list
FROM 
    patient p
JOIN 
    patient_allergy pa ON p.id = pa.patient_id
JOIN 
    allergy a ON pa.allergy_id = a.id
GROUP BY 
    p.id, p.first_name, p.last_name
ORDER BY number_of_allergies DESC, p.last_name ASC, p.first_name ASC
```
Cypher jest bardziej zrozumiały i czytelny, ponieważ jest bardziej zbliżony do języka naturalnego oraz zapytania w Neo4j są zorientowane 
na relacje.
### Jakie są główne różnice w wydajności i jakie są ich przyczyny