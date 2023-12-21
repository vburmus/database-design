# *Task 10 - Not Only SQL*
*Wybrana została technologia Graph NoSQL realizowana za pomocą Neo4j.*
## Dlaczego NoSQL Graph? Zalety. 
- Złożone relacji (Relacje są kluczowe w naszym systemie).
- Intuicyjne połączenia (bazy danych grafów wizualnie ilustrują połączenia między jednostkami za pomocą węzłów i relacji).
- Wydajne zapytania (Grafowe bazy danych specjalizują się w zapytaniach o relacje między jednostkami, umożliwiając szybszy dostęp do połączonych danych).
- Zdolność adaptacji do zmian (podczas gdy bazy danych zorientowane na dokumenty mają elastyczne schematy, a graf - strukturę).
- UK i US krajowe służby zdrowia są oparte na Graph noSQL.
- Możliwość tworzenia różnych rekomendacji za pomocą algorytmów na grafie.
## Dlaczego Neo4J? Zalety.
- Wysoka wydajność odczytu i zapisu.
- Jest często używana przez duże przedsiębiorstwa.
- Łączy w sobie natywne przechowywanie grafów, skalowalną zoptymalizowaną architekturę.
- Java ecosystem.
- Różne korzystne algorytmy na grafie.
---
## Wady wybranych technologii.
- Neo4j ma ustalone górne ograniczenie rozmiaru grafu.
- Audyt bezpieczeństwa nie jest dostępny w Neo4j.
- Skalowalność (trudno skalować na wielu serwerach).
- Grafowe bazy danych są słabe na działania w czasie rzeczywistym na danych.

## Relational Databases(R) vs Graph Databases(G)

### Model

R - tabele

G - węzły rerezentowane dokumentami JSON

### Operacje

R - CRUD

G - CRUD i matematyczne operacje na grafie

### Skalowalność

R - łatwe wertykalne skalowanie

G - łatwe horyzontalne skalowanie.  

### Wydajność

R - używa roznych podzapytan i dodatkowych kwerend przy zlozonych zapytaniach

G - doskonale sprawdza się w reprezentowaniu i odpytywaniu relacji między danymi.
