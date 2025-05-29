![Sveučičište Jurja Dobrile u Puli](./fipu.png)

# DOKUMENTACIJA PROJEKTNOG ZADATKA

**Naziv projekta**: *Vođenje web trgovine*  
**Tim**: *14*  
**Smjer**: *Informatika*  
**Kolegij**: *Baze podataka 1*  
**Mentor**: *doc. Dr. Sc. Goran Oreški*  
**Lokacija i datum**: *Pula, svibanj 2025.*

---

## SADRŽAJ

1. [UVOD](#1-uvod)  
2. [OPIS POSLOVNOG PROCESA](#2-opis-poslovnog-procesa)
3. [ER DIJAGRAM](#3-er-dijagram)  
4. [RELACIJSKI MODEL](#4-relacijski-model)  
5. [EER DIJAGRAM](#5-eer-dijagram)  
6. [TABLICE](#6-tablice)
7. [INICIJALIZACIJA](#7-inicijalizacija)  
8. [UPITI](#8-upiti)  
9. [ZAKLJUČAK](#9-zaključak)  

---

## 1. UVOD

Projekt *Vođenje web trgovine* osmišljen je s ciljem izrade baze podataka koja omogućuje učinkovito upravljanje online trgovinom. Baza podataka pruža podršku za ključne funkcionalnosti poput upravljanja proizvodima, narudžbama, korisnicima, skladištem, dostavom i promocijama. 

Svrha baze podataka je osigurati pouzdano i brzo upravljanje podacima, omogućiti jednostavno praćenje poslovnih procesa te podržati analizu i optimizaciju poslovanja. 

Razlog odabira ove teme je rastuća popularnost online trgovina i potreba za kvalitetnim sustavima koji omogućuju njihovo vođenje. Projekt pruža priliku za praktičnu primjenu znanja o dizajnu baza podataka, relacijskim modelima i SQL upitima, uz fokus na stvarne poslovne zahtjeve.

---

## 2. OPIS POSLOVNOG PROCESA


*----- Napisati malo bolje -----*

Poslovni proces kojeg smo ovdje modelirali, iako pojednostavljen i limitiran, vjerujemo da omogućuje učinkovito upravljanje ključnim entitetima i njihovim međusobnim odnosima.

Proizvod je glavni entitet na kojeg smo se fokusirali i dali najviše pažnje. Tablica `PROIZVOD` sadrži osnovne informacije o artiklima dostupnim u trgovini, uključujući naziv, opis i cijenu. Za svakog proizvoda možemo dodati više slika. Svaki proizvod može također pripadati u više kategorija, koja grupiraju proizvode radi lakšeg pretraživanja. Evidentira se povijest promjena cijena proizvoda i povijest zaliha kako bismo imali podatke za naknadne analize.

Korisnici sustava evidentirani su u tablici `KORISNIK`, koja pohranjuje njihove osobne podatke i kontakt informacije. Svaki korisnik može imati više lista želja koje omogućuju korisnicima spremanje željenih artikala za buduće narudžbe.

Narudžbe su strukturirane kroz tablicu `NARUDZBA`, koja uključuje podatke o korisniku, datumu narudžbe, statusu i načinu plaćanja. Povezana je s tablicom `NARUDZBA_PROIZVOD`, koja detaljno opisuje artikle unutar pojedine narudžbe, te tablicom `UPLATA`, koja evidentira transakcije vezane uz narudžbe.

Dostava narudžbi organizirana je kroz tablicu `DOSTAVA`, koja prati status dostave, troškove i vremenske podatke, te je povezana s tablicom `KURIRSKA_SLUZBA`, koja pohranjuje informacije o kurirskim službama. Promocije su implementirane kroz tablicu `KUPON`, koja omogućuje definiranje popusta, te tablicu `KUPON_NARUDZBA`, koja povezuje kupone s narudžbama.

Projekt se temelji na relacijskom modelu, pri čemu su svi entiteti povezani stranim ključevima kako bi se osigurala referencijalna integracija podataka. Dizajn tablica omogućuje učinkovito upravljanje podacima, praćenje povijesti promjena i generiranje analitičkih izvještaja, čime se podržava optimizacija poslovanja web trgovine.

---

## 3. ER DIJAGRAM

![ER dijagram](./ER%20diagram.png)

---

### 1. Korisnik i Narudžba
- Veza: ima
- Kardinalnost: 1:N
    
    Korisnik može imati više narudžbi.  
    Narudžba pripada jednom korisniku.

### 2. Korisnik i Recenzija
- Veza: ostavlja
- Kardinalnost: 1:N
    
    Korisnik može ostaviti više recenzija.  
    Recenzija pripada jednom korisniku.

### 3. Korisnik i Wishlist
- Veza: ima
- Kardinalnost: 1:N
    
    Korisnik može imati više wishlista.  
    Wishlist pripada jednom korisniku.

### 4. Wishlist i Proizvod
- Veza: sadrži
- Kardinalnost: M:N
    
    Wishlist može sadržavati više proizvoda.  
    Proizvod može biti u više wishlista.

### 5. Recenzija i Proizvod
- Veza: ocjenjuje
- Kardinalnost: N:1
    
    Recenzija je povezana s jednim proizvodom.  
    Proizvod može imati više recenzija.

### 6. Narudžba i Proizvod
- Veza: sadrži
- Kardinalnost: M:N
- Veza ima atribute: količina, cijena.
    
    Narudžba može sadržavati više proizvoda.  
    Proizvod može biti u više narudžbi.  

### 7. Narudžba i Uplata
- Veza: ima
- Kardinalnost: 1:N
    
    Jedna narudžba ima jednu uplatu.  
    Više uplata mogu biti vezane za različite narudžbe.

### 8. Narudžba i Dostava
- Veza: ima
- Kardinalnost: 1:1
    
    Jedna narudžba ima jednu dostavu.  
    Dostava pripada jednoj narudžbi.

### 9. Dostava i Kurirska služba
- Veza: dostavlja
- Kardinalnost: N:1
    
    Dostavu vrši jedna kurirska služba.  
    Kurirska služba može imati više dostava.

### 10. Narudžba i Kupon
- Veza: koristi
- Kardinalnost: M:N
    
    Narudžba može koristiti više kupona.  
    Kupon može biti korišten u više narudžbi.

### 11. Proizvod i Kategorija
- Veza: pripada
- Kardinalnost: M:N
    
    Proizvod može pripadati više kategorija.  
    Jedna kategorija može imati više proizvoda.

### 12. Proizvod i Povijest cijena
- Veza: ima
- Kardinalnost: 1:N
    
    Proizvod može imati više zapisa u povijesti cijena.  
    Jedan zapis pripada jednom proizvodu.

### 13. Proizvod i Slika
- Veza: ima
- Kardinalnost: M:N
    
    Proizvod može imati više slika.  
    Slika prikazuje više proizvoda.

### 14. Proizvod i Skladište
- Veza: nalazi se u
- Kardinalnost: M:N
- Atributi veze: količina.  
    
    Proizvod se može nalaziti u više skladišta.  
    Skladište može sadržavati više proizvoda.

### 15. Skladište i Povijest zaliha
- Veza: prati
- Kardinalnost: 1:N
    
    Skladište ima više zapisa u povijesti zaliha.  
    Svaki zapis se odnosi na jedno skladište.

### 16. Povijest zaliha i Proizvod
- Veza: ima
- Kardinalnost: N:1
    
    Više zapisa pripada jednom proizvodu.  
    Jedan zapis se odnosi na jedan proizvod.

---

## 4. RELACIJSKI MODEL

```sql
PROIZVOD (id (PK), naziv, opis, cijena)
```
```sql
SLIKA (id (PK), putanja, naziv, opis)
```
```sql
SLIKA_PROIZVOD (id (PK), proizvod_id (FK), slika_id (FK))
```
```sql
KATEGORIJA (id (PK), naziv, opis)
```
```sql
PROIZVOD_KATEGORIJA (id (PK), proizvod_id (FK), kategorija_id (FK))
```
```sql
KORISNIK (id (PK), ime, prezime, email, lozinka, adresa, grad, drzava, telefon)
```
```sql
NARUDZBA (id (PK), korisnik_id (FK), datum, status, ukupni_iznos, nacin_placanja)
```
```sql
NARUDZBA_PROIZVOD (id (PK), narudzba_id (FK), proizvod_id (FK), kolicina, cijena)
```
```sql
UPLATA (id (PK), id_narudzba (FK), iznos, datum, status)
```
```sql
RECENZIJA (id (PK), proizvod_id (FK), korisnik_id (FK), ocjena, komentar, datum)
```
```sql
KUPON (id (PK), naziv, tip, vrijednost, status, datum_pocetka, datum_isteka)
```
```sql
KUPON_NARUDZBA (id (PK), kupon_id (FK), narudzba_id (FK))
```
```sql
WISHLIST (id (PK), korisnik_id (FK), naziv, datum)
```
```sql
WISHLIST_PROIZVOD (id (PK), wishlist_id (FK), proizvod_id (FK))
```
```sql
SKLADISTE (id (PK), naziv, adresa, grad, drzava)
```
```sql
SKLADISTE_PROIZVOD (id (PK), skladiste_id (FK), proizvod_id (FK), kolicina)
```
```sql
POVIJEST_CIJENA (id (PK), proizvod_id (FK), cijena, datum)
```
```sql
POVIJEST_ZALIHA (id (PK), skladiste_id (FK), proizvod_id (FK), kolicina datum, opis)
```
```sql
KURIRSKA_SLUZBA (id (PK), naziv, opis, kontakt)
```
```sql
DOSTAVA (id (PK), status, narudzba_id (FK), cijena, opis, datum_kreiranja, datum_slanja, datum_dostave, kurirska_sluzba_id (FK))
```

---

## 5. EER DIJAGRAM

![EER dijagram](./EER%20diagram.png)

---

## 6. TABLICE

Opis tablica korištenih u bazi podataka.

### 6.1. PROIZVOD
### 6.1. PROIZVOD
Tablica `PROIZVOD` sadrži osnovne informacije o proizvodima dostupnim u web trgovini.
- **Primarni ključ:** `id` - Jedinstveni identifikator proizvoda.
- **Atributi:**
  - `naziv` - Naziv proizvoda, koji mora biti definiran.
  - `opis` - Detaljan opis proizvoda, opcionalan.
  - `cijena` - Cijena proizvoda izražena u centima, mora biti veća od 0.
- **Ograničenja:**
  - Provjera (`CHECK`) osigurava da cijena bude pozitivna vrijednost.

### 6.2. SLIKA
Tablica `SLIKA` sadrži informacije o slikama proizvoda.
- **Primarni ključ:** `id` - Jedinstveni identifikator slike.
- **Atributi:**
  - `putanja` - Putanja do slike na serveru, mora biti jedinstvena.
  - `naziv` - Naziv slike, opisuje sadržaj slike.
  - `opis` - Dodatni opis slike, opcionalan.

### 6.3. SLIKA_PROIZVOD
Tablica `SLIKA_PROIZVOD` povezuje slike s proizvodima.
- **Primarni ključ:** `id` - Jedinstveni identifikator veze između slike i proizvoda.
- **Strani ključevi:**
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
  - `slika_id` - Referenca na tablicu `SLIKA`.

### 6.4. KATEGORIJA
Tablica `KATEGORIJA` sadrži informacije o kategorijama proizvoda.
- **Primarni ključ:** `id` - Jedinstveni identifikator kategorije.
- **Atributi:**
  - `naziv` - Naziv kategorije, mora biti jedinstven.
  - `opis` - Detaljan opis kategorije, opcionalan.

### 6.5. PROIZVOD_KATEGORIJA
Tablica `PROIZVOD_KATEGORIJA` povezuje proizvode s kategorijama.
- **Primarni ključ:** `id` - Jedinstveni identifikator veze između proizvoda i kategorije.
- **Strani ključevi:**
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
  - `kategorija_id` - Referenca na tablicu `KATEGORIJA`.

### 6.6. KORISNIK
Tablica `KORISNIK` sadrži informacije o korisnicima web trgovine.
- **Primarni ključ:** `id` - Jedinstveni identifikator korisnika.
- **Atributi:**
  - `ime` - Ime korisnika.
  - `prezime` - Prezime korisnika.
  - `email` - Email korisnika, mora biti jedinstven.
  - `lozinka` - Lozinka korisnika.
  - `adresa`, `grad`, `drzava`, `telefon` - Kontakt podaci korisnika, opcionalni.

### 6.7. NARUDZBA
Tablica `NARUDZBA` sadrži informacije o narudžbama korisnika.
- **Primarni ključ:** `id` - Jedinstveni identifikator narudžbe.
- **Strani ključ:**
  - `korisnik_id` - Referenca na tablicu `KORISNIK`.
- **Atributi:**
  - `datum` - Datum kreiranja narudžbe.
  - `status` - Status narudžbe (`na čekanju`, `otkazano`, `isporučeno`).
  - `ukupni_iznos` - Ukupna cijena narudžbe izražena u centima.
  - `nacin_placanja` - Način plaćanja (`kreditna kartica`, `pouzeće`, `bankovni transfer`).

### 6.8. NARUDZBA_PROIZVOD
Tablica `NARUDZBA_PROIZVOD` povezuje narudžbe s proizvodima.
- **Primarni ključ:** `id` - Jedinstveni identifikator veze između narudžbe i proizvoda.
- **Strani ključevi:**
  - `narudzba_id` - Referenca na tablicu `NARUDZBA`.
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
- **Atributi:**
  - `kolicina` - Količina proizvoda u narudžbi.
  - `cijena` - Cijena proizvoda izražena u centima.

### 6.9. UPLATA
Tablica `UPLATA` sadrži informacije o transakcijama vezanim uz narudžbe.
- **Primarni ključ:** `id` - Jedinstveni identifikator uplate.
- **Strani ključ:**
  - `narudzba_id` - Referenca na tablicu `NARUDZBA`.
- **Atributi:**
  - `iznos` - Iznos transakcije izražen u centima.
  - `datum` - Datum transakcije.
  - `status` - Status transakcije (`uspješna`, `neuspješna`).

### 6.10. RECENZIJA
Tablica `RECENZIJA` sadrži ocjene i komentare korisnika o proizvodima.
- **Primarni ključ:** `id` - Jedinstveni identifikator recenzije.
- **Strani ključevi:**
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
  - `korisnik_id` - Referenca na tablicu `KORISNIK`.
- **Atributi:**
  - `ocjena` - Ocjena proizvoda (1-5).
  - `komentar` - Komentar korisnika.
  - `datum` - Datum recenzije.

### 6.11. KUPON
Tablica `KUPON` sadrži informacije o kuponima za popuste.
- **Primarni ključ:** `id` - Jedinstveni identifikator kupona.
- **Atributi:**
  - `naziv` - Naziv kupona, mora biti jedinstven.
  - `tip` - Tip kupona (`fiksni`, `postotak`, `besplatna dostava`).
  - `vrijednost` - Vrijednost kupona.
  - `status` - Status kupona (`aktivan`, `neaktivan`).
  - `datum_pocetka`, `datum_isteka` - Vrijeme trajanja kupona.
- **Ograničenja:**
  - Provjera (`CHECK`) osigurava ispravne vrijednosti za svaki tip kupona.

### 6.12. KUPON_NARUDZBA
Tablica `KUPON_NARUDZBA` povezuje kupone s narudžbama.
- **Primarni ključ:** `id` - Jedinstveni identifikator veze između kupona i narudžbe.
- **Strani ključevi:**
  - `kupon_id` - Referenca na tablicu `KUPON`.
  - `narudzba_id` - Referenca na tablicu `NARUDZBA`.

### 6.13. WISHLIST
Tablica `WISHLIST` sadrži liste želja korisnika.
- **Primarni ključ:** `id` - Jedinstveni identifikator liste želja.
- **Strani ključ:**
  - `korisnik_id` - Referenca na tablicu `KORISNIK`.
- **Atributi:**
  - `naziv` - Naziv liste želja.
  - `datum` - Datum kreiranja liste.

### 6.14. WISHLIST_PROIZVOD
Tablica `WISHLIST_PROIZVOD` povezuje proizvode s listama želja.
- **Primarni ključ:** `id` - Jedinstveni identifikator veze između liste želja i proizvoda.
- **Strani ključevi:**
  - `wishlist_id` - Referenca na tablicu `WISHLIST`.
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.

### 6.15. SKLADISTE
Tablica `SKLADISTE` sadrži informacije o skladištima.
- **Primarni ključ:** `id` - Jedinstveni identifikator skladišta.
- **Atributi:**
  - `naziv` - Naziv skladišta, mora biti jedinstven.
  - `adresa`, `grad`, `drzava` - Lokacija skladišta.

### 6.16. SKLADISTE_PROIZVOD
Tablica `SKLADISTE_PROIZVOD` povezuje proizvode sa skladištima.
- **Primarni ključ:** `id` - Jedinstveni identifikator veze između skladišta i proizvoda.
- **Strani ključevi:**
  - `skladiste_id` - Referenca na tablicu `SKLADISTE`.
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
- **Atributi:**
  - `kolicina` - Količina proizvoda u skladištu.

### 6.17. POVIJEST_CIJENA
Tablica `POVIJEST_CIJENA` sadrži povijest promjena cijena proizvoda.
- **Primarni ključ:** `id` - Jedinstveni identifikator promjene cijene.
- **Strani ključ:**
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
- **Atributi:**
  - `cijena` - Nova cijena proizvoda.
  - `datum` - Datum promjene cijene.

### 6.18. POVIJEST_ZALIHA
Tablica `POVIJEST_ZALIHA` sadrži povijest promjena zaliha proizvoda u skladištima.
- **Primarni ključ:** `id` - Jedinstveni identifikator promjene zaliha.
- **Strani ključevi:**
  - `skladiste_id` - Referenca na tablicu `SKLADISTE`.
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
- **Atributi:**
  - `kolicina` - Nova količina proizvoda.
  - `datum` - Datum promjene zaliha.
  - `opis` - Opis promjene.

### 6.19. KURIRSKA_SLUZBA
Tablica `KURIRSKA_SLUZBA` sadrži informacije o kurirskim službama.
- **Primarni ključ:** `id` - Jedinstveni identifikator kurirske službe.
- **Atributi:**
  - `naziv` - Naziv kurirske službe, mora biti jedinstven.
  - `opis` - Detaljan opis kurirske službe.
  - `kontakt` - Kontakt informacije.

### 6.20. DOSTAVA
Tablica `DOSTAVA` sadrži informacije o dostavama narudžbi.
- **Primarni ključ:** `id` - Jedinstveni identifikator dostave.
- **Strani ključevi:**
  - `narudzba_id` - Referenca na tablicu `NARUDZBA`.
  - `kurirska_sluzba_id` - Referenca na tablicu `KURIRSKA_SLUZBA`.
- **Atributi:**
  - `status` - Status dostave (`naručeno`, `u transportu`, `isporučeno`).
  - `cijena` - Cijena dostave izražena u centima.
  - `opis` - Dodatni opis dostave.
  - `datum_kreiranja`, `datum_slanja`, `datum_dostave` - Vremenski podaci vezani uz dostavu.

*(Za svaku tablicu kopiraj strukturu opisa kao za KLUB, prilagođeno tvojem projektu.)*

---

## 7. INICIJALIZACIJA

Ovaj vodič objašnjava kako postaviti i pokrenuti projekt baze podataka za web trgovinu. Projekt koristi MySQL i sastoji se od SQL skripti za definiranje sheme baze podataka i učitavanje podataka iz CSV datoteka ili manualno kroz INSERT-ove.

---

Slijedite ove korake za postavljanje projekta kroz **INSERT-ove**:

1.  **Preuzimanje potrebnih datoteka:**
    *   Preuzmite SQL skriptne datoteke (`shema.sql`, `insert_data.sql`).

2.  **Izvršavanje SQL skripti:**
    *   Spojite se na MySQL server koristeći konfiguriranu konekciju.
    *   Otvorite SQL skriptu `shema.sql`.
    *   Izvršite cijelu skriptu `shema.sql`. Ovo će stvoriti bazu podataka `web_trgovina_bp1` i sve potrebne tablice.
    *   Nakon uspješnog izvršavanja `shema.sql`, otvorite SQL skriptu `insert_data.sql`.
    *   Izvršite cijelu skriptu `insert_data.sql`. Ovo će popuniti tablice podacima s vrijednostima iz INSERT-ova.

---

Slijedite ove korake za postavljanje projekta kroz **CSV datoteke**:

1.  **Preuzimanje potrebnih datoteka:**
    *   Preuzmite SQL skriptne datoteke (`shema.sql`, `load_data_from_csv.sql`).
    *   Preuzmite cijelu mapu `data` koja sadrži sve potrebne CSV datoteke.

2.  **Postavljanje CSV datoteka za MySQL:**
    *   MySQL zahtijeva da se CSV datoteke za `LOAD DATA INFILE` nalaze u sigurnosno odobrenom direktoriju. Da biste pronašli putanju ovog direktorija, izvršite sljedeći SQL upit u MySQL Workbenchu (ili drugom MySQL klijentu):

        ```sql
        SHOW VARIABLES LIKE "secure_file_priv";
        ```
    *   Kopirajte cijelu mapu `data` (sa svim CSV datotekama) u putanju koju ste dobili gornjim upitom. Česta zadana putanja je `C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\`.

3.  **Konfiguracija MySQL Workbencha za `LOAD DATA LOCAL INFILE`:**
    *   Otvorite MySQL Workbench.
    *   Na početnom zaslonu, desnom tipkom miša kliknite na konekciju koju ćete koristiti za spajanje na bazu podataka.
    *   Odaberite `Edit Connection…`.
    *   Idite na karticu `Advanced`.
    *   U polje `Others` (ili slično, ovisno o verziji Workbencha) unesite: `OPT_LOCAL_INFILE=1`.
    *   Kliknite `Test Connection` (opcionalno) da provjerite radi li sve ispravno.
    *   Kliknite `Close`. Možda će biti potrebno ponovno pokrenuti MySQL Workbench kako bi promjena stupila na snagu.

4.  **Izvršavanje SQL skripti:**
    *   Spojite se na MySQL server koristeći konfiguriranu konekciju.
    *   Otvorite SQL skriptu `shema.sql`.
    *   Izvršite cijelu skriptu `shema.sql`. Ovo će stvoriti bazu podataka `web_trgovina_bp1` i sve potrebne tablice.
    *   Nakon uspješnog izvršavanja `shema.sql`, otvorite SQL skriptu `load_data_from_csv.sql`.
    *   Izvršite cijelu skriptu `load_data_from_csv.sql`. Ovo će popuniti tablice podacima iz CSV datoteka. **Napomena:** Provjerite jesu li putanje do CSV datoteka unutar `load_data_from_csv.sql` ispravno postavljene na direktorij iz koraka 2 (npr. `C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/naziv_datoteke.csv`).

---

## 8. UPITI

Napiši i objasni SQL upite koje si koristio u projektu, npr.:
#### Upit 1:  
Opis: *[Kratki opis što upit radi]*  
```sql
-- SQL kod upita
```

### Erik Fakin

#### Upit 1:  
Pogled nazvan "top10_najprodavanijih_proizvoda" kombinira podatke iz tablica "proizvod", "narudzba_proizvod" i "narudzba" kako bi prikazao deset najprodavanijih proizvoda u zadnjih 30 dana od određenog datuma.

Unutar pogleda koristi se SELECT naredba za dohvaćanje podataka. SELECT upit odabire stupce "id", "naziv" i "cijena" iz tablice "proizvod", te izračunava ukupnu količinu prodanih jedinica proizvoda koristeći funkciju SUM nad stupcem "kolicina" iz tablice "narudzba_proizvod".

Zatim se koristi INNER JOIN za spajanje tablica "proizvod", "narudzba_proizvod" i "narudzba" koristeći odgovarajuće ključeve. WHERE uvjet filtrira narudžbe koje su napravljene u zadnjih 30 dana od određenog datuma koristeći funkciju DATE_SUB. Rezultat se grupira po stupcima "id", "naziv" i "cijena", te se sortira prema ukupnoj količini prodanih jedinica u opadajućem redoslijedu. Konačno, LIMIT ograničava rezultat na prvih deset proizvoda. 
```sql
CREATE OR REPLACE VIEW top10_najprodavanijih_proizvoda AS
SELECT 
    p.id, 
    p.naziv, 
    p.cijena, 
    SUM(np.kolicina) AS ukupna_kolicina
FROM proizvod
INNER JOIN narudzba_proizvod np ON p.id = np.proizvod_id
INNER JOIN narudzba n ON np.narudzba_id = n.id
WHERE n.datum >= DATE_SUB('2025-05-26 00:00:00', INTERVAL 30 DAY)
GROUP BY p.id, p.naziv, p.cijena
ORDER BY ukupna_kolicina DESC
LIMIT 10;
```

#### Upit 2:
Pogled "info_proizvod" kombinira podatke iz više tablica kako bi prikazao sve informacije o jednom proizvodu, uključujući detalje, slike, kategorije, recenzije i količinu na skladištu.

Unutar pogleda koristi se SELECT naredba za dohvaćanje podataka. SELECT upit odabire stupce "id", "naziv", "opis" i "cijena" iz tablice "proizvod". Koristi se funkcija GROUP_CONCAT za dohvaćanje svih kategorija i slika povezanih s proizvodom i kombiniranje u jedan string, te CONCAT za formatiranje recenzija koje uključuju ocjenu, komentar, datum i ime korisnika. SUM funkcija se koristi za izračun ukupne količine proizvoda na skladištu.

LEFT JOIN se koristi za spajanje tablica "proizvod", "proizvod_kategorija", "kategorija", "slika_proizvod", "slika", "skladiste_proizvod", "recenzija" i "korisnik". WHERE uvjet filtrira podatke za određeni proizvod prema njegovom "id". Rezultat se grupira po stupcu "id".

```sql
CREATE OR REPLACE VIEW info_proizvod AS
SELECT
    p.id,
    p.naziv,
    p.opis,
    p.cijena,
    GROUP_CONCAT(DISTINCT k.naziv) AS kategorije,
    GROUP_CONCAT(DISTINCT s.putanja) AS slike,
    SUM(DISTINCT sp.kolicina) AS ukupna_kolicina_na_skladistu,
    GROUP_CONCAT(DISTINCT CONCAT(r.ocjena, '::', r.komentar, '::', r.datum, '::', ko.ime, ' ', ko.prezime) SEPARATOR ' || ') AS recenzije
FROM proizvod p
LEFT JOIN proizvod_kategorija pk ON p.id = pk.proizvod_id
LEFT JOIN kategorija k ON pk.kategorija_id = k.id
LEFT JOIN slika_proizvod spv ON p.id = spv.proizvod_id
LEFT JOIN slika s ON spv.slika_id = s.id
LEFT JOIN skladiste_proizvod sp ON p.id = sp.proizvod_id
LEFT JOIN recenzija r ON p.id = r.proizvod_id
LEFT JOIN korisnik ko ON r.korisnik_id = ku.id
WHERE p.id = 11 
GROUP BY p.id;
```
#### Upit 3:
Pogled "najcesce_kupljeno_zajedno" kombinira podatke iz tablica "narudzba_proizvod" i "proizvod" kako bi prikazao proizvode koji se najčešće prodaju zajedno s definiranim proizvodom.

Unutar pogleda koristi se SELECT naredba za dohvaćanje podataka. SELECT upit odabire stupce "id" i "naziv" iz tablice "proizvod", te izračunava broj zajedničkih kupovina koristeći funkciju COUNT.

INNER JOIN se koristi za spajanje tablica "narudzba_proizvod" i "proizvod" na temelju zajedničkih narudžbi. WHERE uvjet filtrira podatke za definirani proizvod prema njegovom "id" i isključuje sam proizvod iz rezultata. Rezultat se grupira po stupcu "id", te se sortira prema broju zajedničkih kupovina u opadajućem redoslijedu.

```sql
CREATE OR REPLACE VIEW najcesce_kupljeno_zajedno AS
SELECT
    p2.id AS proizvod_id,
    p2.naziv AS proizvod_naziv,
    COUNT(*) AS broj_zajednickih_kupovina
FROM
    narudzba_proizvod np1
INNER JOIN
    narudzba_proizvod np2 ON np1.narudzba_id = np2.narudzba_id
INNER JOIN
    proizvod p2 ON np2.proizvod_id = p2.id
WHERE
    np1.proizvod_id = 11
    AND np2.proizvod_id <> np1.proizvod_id
    AND np2.kolicina > 0
GROUP BY
    p2.id
ORDER BY
    broj_zajednickih_kupovina DESC;
```

#### Upit 4:
Pogled "proizvodi_po_kategoriji_i_cijeni" kombinira podatke iz tablica "proizvod", "proizvod_kategorija", "kategorija", "recenzija", "slika_proizvod", "slika" i "skladiste_proizvod" kako bi prikazao proizvode iz odabrane kategorije unutar definiranog raspona cijena.

Unutar pogleda koristi se SELECT naredba za dohvaćanje podataka. SELECT upit odabire stupce "naziv", "cijena" i "slike" iz tablice "proizvod", te izračunava prosječnu ocjenu proizvoda koristeći funkciju AVG i stanje na zalihi koristeći funkciju SUM.

LEFT JOIN se koristi za spajanje tablica na temelju odgovarajućih ključeva. WHERE uvjet filtrira proizvode prema id kategorije i rasponu cijena. Rezultat se grupira po stupcu "id", te se sortira prema cijeni u rastućem redoslijedu i prosječnoj ocjeni u opadajućem redoslijedu.

```sql
CREATE OR REPLACE VIEW proizvodi_po_kategoriji_i_cijeni AS
SELECT 
    p.naziv AS proizvod_naziv,
    GROUP_CONCAT(DISTINCT s.putanja) AS slike,
    p.cijena AS proizvod_cijena,
    AVG(r.ocjena) AS prosjecna_ocjena,
    SUM(sp.kolicina) AS stanje_na_zalihi
FROM proizvod p
LEFT JOIN proizvod_kategorija pk ON p.id = pk.proizvod_id
LEFT JOIN kategorija k ON pk.kategorija_id = k.id
LEFT JOIN recenzija r ON p.id = r.proizvod_id
LEFT JOIN slika_proizvod spv ON p.id = spv.proizvod_id
LEFT JOIN slika s ON spv.slika_id = s.id
LEFT JOIN skladiste_proizvod sp ON p.id = sp.proizvod_id
WHERE k.id = 1 AND p.cijena BETWEEN 100 AND 500
GROUP BY p.id
ORDER BY p.cijena ASC, prosjecna_ocjena DESC;
```

#### Upit 5:
Pogled "analiza_prodaje_po_mjesecima" kombinira podatke iz tablica "proizvod", "narudzba_proizvod" i "narudzba" kako bi prikazao analizu prodaje po mjesecima.

Unutar pogleda koristi se SELECT naredba za dohvaćanje podataka. SELECT upit odabire stupce "mjesec" koristeći funkciju MONTH i "naziv" iz tablice "proizvod", te izračunava ukupnu količinu prodanih jedinica i ukupni prihod koristeći funkcije SUM.

INNER JOIN se koristi za spajanje tablica na temelju odgovarajućih ključeva. Rezultat se grupira po stupcima "mjesec" i "id", te se sortira prema mjesecu u rastućem redoslijedu i ukupnom prihodu u opadajućem redoslijedu.

```sql
CREATE OR REPLACE VIEW analiza_prodaje_po_mjesecima AS
SELECT 
    MONTH(n.datum) AS mjesec,
    p.naziv AS proizvod_naziv,
    SUM(np.kolicina) AS ukupna_kolicina,
    SUM(np.kolicina * np.cijena) AS ukupni_prihod
FROM proizvod p
INNER JOIN narudzba_proizvod np ON p.id = np.proizvod_id
INNER JOIN narudzba n ON np.narudzba_id = n.id
GROUP BY mjesec, p.id
ORDER BY mjesec ASC, ukupni_prihod DESC;
```



---

## 9. ZAKLJUČAK

Projekt nam je poboljšao razumijevanje procesa izrade i implementacije baze podataka za web trgovinu. Kroz praktičan rad stekli smo uvid u sveukupni proces razvoja - od planiranja relacijskog modela do njegove implementacije u SQL-u.

Tijekom projekta morali smo riješiti određene probleme, kao npr. neispravno modeliranje relacijskog modela i nepravilno povezivanje entiteta. S vremenom smo kroz učenje i malo *trial and error*-a uspjeli razumjeti greške te ih ispravili tijekom razvoja baze.

Sustav nam olakšava rad s podacima, omogućuje pregled promjena kroz vrijeme i izradu analitičkih izvještaja. Ove funkcionalnosti omogućuju primjenu sustava u stvarnome svijetu, pa čak i na drugim područjima s nekoliko promjena.

Zaključno, projekt nam je dao skoro *first hand experience* u radu s bazama podataka - naučili smo puno više nego samo iz knjiga, što je i očekivano jer smo morali sami ispravljati greške i rješavati probleme. Takvo iskustvo sigurno će nam biti korisno ako budemo imali slične zadatke u budućnosti.

---