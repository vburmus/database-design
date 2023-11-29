# SWOT-Analysis | Online Prescription
---
## Strenghts:
System pozwala :
 - lekarzom łatwo wydawać recepty, uwzględniając alergie i tp.
 - monitorować wydane recepty
 - monitorować historię ich realizacji
 - wyszukiwać informacje na temat powiązanych z lekami alergii
 - wyszukiwać niezbędne informacje takie, jak skład leków, czy ich kategoria 
 - sprawdzać wystawienie recept przez poszczególnych lekarzy
 - wyszukiwać zamienniki, jeżeli pacjent ma alergie
 - wyszukiwać apteki wedlug adresu oraz zapewnia lattwy kontakt z nimi
---
## Weaknesses
#### Tabela realizacji recepty:
 - Jest zbędna z powodu podobieństwa odpowiedzialności do wpisu.
 - Struktura relacji z wpisem jest zbyt skomplikowana.
 - Może spowolnić działanie systemu.
---
## Opportunities
 -  Istnieje możliwość rozbudowy projektu o dodatkowe funkcje, uwzględnienie pominiętych obszarów oraz dalsze testowanie i ulepszanie aplikacji.
 - Projektowanie tej aplikacji pozwoliło na zdobycie praktycznego doświadczenia w tworzeniu aplikacji opartych na bazach danych, co może być wykorzystane w przyszłych projektach.
---
## Threats
1. Potencjalne problemy z akceptacją użytkowników: Brak pełnej funkcjonalności aplikacji, np. brak obsługi strefy magazynowej, może wpłynąć na akceptację i użyteczność aplikacji w realnym środowisku medycznym.
2. Wyszukiwanie wpisów z recept może być trudne, ponieważ nie dodaliśmy indeksów z powodu częstej edycji tablicy. 3. System potrzebuje w tej sprawie obsługę planownych updateów
---
## Analiza faz
1. W pierwszej fazie planowania naszego projektu obraliśmy kierunek, który prowadziliśmy do końca.
Jedynie jedna rzecz została w zły sposób sformułowana.
Były to stany magazynowe. Głównym błędem było najpierw wykluczeniem tego z zakresu projektu lecz wpisaniem go do wymagania funkcjonalnego aptekarza.
Zgodnie z pierwszą fazą planowania naszego projektu system pozwala w całości wyszukiwać i wystawiać przez lekarzy recepty.
2. W drugiej fazie stworzyliśmy definicje schematów relacji. Zaprojektowaliśmy schematy "Recepta",
"Wpis" oraz "Realizacja recepty". Był to błąd ponieważ taka realizacja okazała się problematyczna. Musieliśmy przenieść kluczowe atrybuty z "Realizacja recept" do "Wpis". Takim sposobem otrzymaliśmy prostszy i logiczniejszy schemat w którym wpis określał zarówno jaki lek zawiera oraz czy został już zrealizowany.
3. W trzeciej fazie (faza fizyczna) dzięki temu, że schemat został utworzony w MySQL Workbench to mogliśmy wygenerować skrypt. Następnie musieliśmy poprawić ten skrypt, określić w odpowiedni sposób typy każdych zmiennych oraz dodać w niektórych miejscach instrukcję CHECK aby weryfikować wprowadzane dane.
4. Kolejnym etapem było napisanie skryptu, który wypełniam nasza bazę losowymi danymi. Mogliśmy dzięki temu sprawdzić poprawność naszej bazy i zobrazować sobie mniej więcej jak wyglądałaby ona po wypełnieniu.
5.  Po tym etapie mogliśmy zaprojektować kilka zapytań SQL, które weryfikowały czy dzięki naszej bazie danych można obsłużyć wszystkie funkcjonalności, które założyliśmy w etapie pierwszym. Napisanie wszystkich zapytań nie sprawiało większych problemów, więc ustaliliśmy, że nasza baza dostarcza wszystkie wymagane informacje. Ostatnim krokiem była weryfikazcja poprzednio napisanych zapytań. Tutaj odkryliśmy potencjalne błędy, które sprawiają, że nasza baza może być potencjalnie mało wydajna. Głównym problemem była encja "Wpis" która będzie wyszukiwana, edytowana oraz dodawana bardzo często. Przez to nie możemy dodać indeksów co znacząco spowalnia działanie niektórych zapytań. Naszym głównym pomysłem na naprawienie wydajności naszego systemu jest wprowadzenie okresowych integracji recept, dzięki czemu moglibyśmy mimo częstych aktualizacji stworzyć odpowienie indeksy aby przyspieszyć działanie.
6. W fazie szóstej sprawdziliśmy działanie funkcji EXPLAIN dla utworzonych kwerend oraz zauważyliśmy potrzebę dodania indeksów do systemu. Po dyskusji zdecydowaliśmy dodać indeksy do następujących tablic: allergy, pharmacy, substance, doctor, patient, pharmacist, medicine po czym sprawdziliśmy jeszcze raz wynik działania funkcji EXPLAIN i zauważyliśmy optymalizację za pomocą wprowadzonych indeksów.

---

## Kierunki rozwoju opracowanej bazy:
1. Rozwinięcie realizacji recept: implementacja bardziej zaawansowanych procedur weryfikacyjnych w celu eliminacji ryzyka błędów.
2. Wprowadzenie systemu wspierającego planowane update'y bazy.
3. Realizacja interfejsu dla łatwego zarządzania i przeglądania bazy.
4. Realizacja podsystemu dla generowania raportów statystycznych.