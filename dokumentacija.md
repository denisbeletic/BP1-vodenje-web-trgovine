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
2. [ER DIJAGRAM](#2-er-dijagram)  
3. [RELACIJSKI MODEL](#3-relacijski-model)  
4. [EER DIJAGRAM](#4-eer-dijagram)  
5. [TABLICE](#5-tabl-ice)
6. [INICIJALIZACIJA](#6-inicijalizacija)  
7. [UPITI](#7-upiti)  
8. [ZAKLJUČAK](#8-zaključak)

---

## 1. UVOD

Projekt *Vođenje web trgovine* osmišljen je s ciljem izrade baze podataka koja omogućuje učinkovito upravljanje online trgovinom. Baza podataka pruža podršku za ključne funkcionalnosti poput upravljanja proizvodima, narudžbama, korisnicima, skladištem, dostavom i promocijama. 

Svrha baze podataka je osigurati pouzdano i brzo upravljanje podacima, omogućiti jednostavno praćenje poslovnih procesa te podržati analizu i optimizaciju poslovanja. 

Razlog odabira ove teme je rastuća popularnost online trgovina i potreba za kvalitetnim sustavima koji omogućuju njihovo vođenje. Projekt pruža priliku za praktičnu primjenu znanja o dizajnu baza podataka, relacijskim modelima i SQL upitima, uz fokus na stvarne poslovne zahtjeve.

---

## 2. ER DIJAGRAM

*[Umetni ER dijagram ili opiši veze između entiteta.]*

---

## 3. RELACIJSKI MODEL

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

## 4. EER DIJAGRAM

![EER dijagram](./EER%20diagram.png)

---

## 5. TABLICE

Opis tablica korištenih u bazi podataka.

### 5.1. PROIZVOD
Tablica `PROIZVOD` sadrži osnovne informacije o proizvodima dostupnim u web trgovini.
- **Primarni ključ:** `id` - Jedinstveni identifikator proizvoda.
- **Atributi:**
  - `naziv` - Naziv proizvoda, koji mora biti definiran.
  - `opis` - Detaljan opis proizvoda, opcionalan.
  - `cijena` - Cijena proizvoda izražena u centima, mora biti veća od 0.
- **Ograničenja:**
  - Provjera (`CHECK`) osigurava da cijena bude pozitivna vrijednost.

### 5.2. SLIKA
Tablica `SLIKA` sadrži informacije o slikama proizvoda.
- **Primarni ključ:** `id` - Jedinstveni identifikator slike.
- **Atributi:**
  - `putanja` - Putanja do slike na serveru, mora biti jedinstvena.
  - `naziv` - Naziv slike, opisuje sadržaj slike.
  - `opis` - Dodatni opis slike, opcionalan.

### 5.3. SLIKA_PROIZVOD
Tablica `SLIKA_PROIZVOD` povezuje slike s proizvodima.
- **Primarni ključ:** `id` - Jedinstveni identifikator veze između slike i proizvoda.
- **Strani ključevi:**
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
  - `slika_id` - Referenca na tablicu `SLIKA`.

### 5.4. KATEGORIJA
Tablica `KATEGORIJA` sadrži informacije o kategorijama proizvoda.
- **Primarni ključ:** `id` - Jedinstveni identifikator kategorije.
- **Atributi:**
  - `naziv` - Naziv kategorije, mora biti jedinstven.
  - `opis` - Detaljan opis kategorije, opcionalan.

### 5.5. PROIZVOD_KATEGORIJA
Tablica `PROIZVOD_KATEGORIJA` povezuje proizvode s kategorijama.
- **Primarni ključ:** `id` - Jedinstveni identifikator veze između proizvoda i kategorije.
- **Strani ključevi:**
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
  - `kategorija_id` - Referenca na tablicu `KATEGORIJA`.

### 5.6. KORISNIK
Tablica `KORISNIK` sadrži informacije o korisnicima web trgovine.
- **Primarni ključ:** `id` - Jedinstveni identifikator korisnika.
- **Atributi:**
  - `ime` - Ime korisnika.
  - `prezime` - Prezime korisnika.
  - `email` - Email korisnika, mora biti jedinstven.
  - `lozinka` - Lozinka korisnika.
  - `adresa`, `grad`, `drzava`, `telefon` - Kontakt podaci korisnika, opcionalni.

### 5.7. NARUDZBA
Tablica `NARUDZBA` sadrži informacije o narudžbama korisnika.
- **Primarni ključ:** `id` - Jedinstveni identifikator narudžbe.
- **Strani ključ:**
  - `korisnik_id` - Referenca na tablicu `KORISNIK`.
- **Atributi:**
  - `datum` - Datum kreiranja narudžbe.
  - `status` - Status narudžbe (`na čekanju`, `otkazano`, `isporučeno`).
  - `ukupni_iznos` - Ukupna cijena narudžbe izražena u centima.
  - `nacin_placanja` - Način plaćanja (`kreditna kartica`, `pouzeće`, `bankovni transfer`).

### 5.8. NARUDZBA_PROIZVOD
Tablica `NARUDZBA_PROIZVOD` povezuje narudžbe s proizvodima.
- **Primarni ključ:** `id` - Jedinstveni identifikator veze između narudžbe i proizvoda.
- **Strani ključevi:**
  - `narudzba_id` - Referenca na tablicu `NARUDZBA`.
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
- **Atributi:**
  - `kolicina` - Količina proizvoda u narudžbi.
  - `cijena` - Cijena proizvoda izražena u centima.

### 5.9. UPLATA
Tablica `UPLATA` sadrži informacije o transakcijama vezanim uz narudžbe.
- **Primarni ključ:** `id` - Jedinstveni identifikator uplate.
- **Strani ključ:**
  - `narudzba_id` - Referenca na tablicu `NARUDZBA`.
- **Atributi:**
  - `iznos` - Iznos transakcije izražen u centima.
  - `datum` - Datum transakcije.
  - `status` - Status transakcije (`uspješna`, `neuspješna`).

### 5.10. RECENZIJA
Tablica `RECENZIJA` sadrži ocjene i komentare korisnika o proizvodima.
- **Primarni ključ:** `id` - Jedinstveni identifikator recenzije.
- **Strani ključevi:**
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
  - `korisnik_id` - Referenca na tablicu `KORISNIK`.
- **Atributi:**
  - `ocjena` - Ocjena proizvoda (1-5).
  - `komentar` - Komentar korisnika.
  - `datum` - Datum recenzije.

### 5.11. KUPON
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

### 5.12. KUPON_NARUDZBA
Tablica `KUPON_NARUDZBA` povezuje kupone s narudžbama.
- **Primarni ključ:** `id` - Jedinstveni identifikator veze između kupona i narudžbe.
- **Strani ključevi:**
  - `kupon_id` - Referenca na tablicu `KUPON`.
  - `narudzba_id` - Referenca na tablicu `NARUDZBA`.

### 5.13. WISHLIST
Tablica `WISHLIST` sadrži liste želja korisnika.
- **Primarni ključ:** `id` - Jedinstveni identifikator liste želja.
- **Strani ključ:**
  - `korisnik_id` - Referenca na tablicu `KORISNIK`.
- **Atributi:**
  - `naziv` - Naziv liste želja.
  - `datum` - Datum kreiranja liste.

### 5.14. WISHLIST_PROIZVOD
Tablica `WISHLIST_PROIZVOD` povezuje proizvode s listama želja.
- **Primarni ključ:** `id` - Jedinstveni identifikator veze između liste želja i proizvoda.
- **Strani ključevi:**
  - `wishlist_id` - Referenca na tablicu `WISHLIST`.
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.

### 5.15. SKLADISTE
Tablica `SKLADISTE` sadrži informacije o skladištima.
- **Primarni ključ:** `id` - Jedinstveni identifikator skladišta.
- **Atributi:**
  - `naziv` - Naziv skladišta, mora biti jedinstven.
  - `adresa`, `grad`, `drzava` - Lokacija skladišta.

### 5.16. SKLADISTE_PROIZVOD
Tablica `SKLADISTE_PROIZVOD` povezuje proizvode sa skladištima.
- **Primarni ključ:** `id` - Jedinstveni identifikator veze između skladišta i proizvoda.
- **Strani ključevi:**
  - `skladiste_id` - Referenca na tablicu `SKLADISTE`.
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
- **Atributi:**
  - `kolicina` - Količina proizvoda u skladištu.

### 5.17. POVIJEST_CIJENA
Tablica `POVIJEST_CIJENA` sadrži povijest promjena cijena proizvoda.
- **Primarni ključ:** `id` - Jedinstveni identifikator promjene cijene.
- **Strani ključ:**
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
- **Atributi:**
  - `cijena` - Nova cijena proizvoda.
  - `datum` - Datum promjene cijene.

### 5.18. POVIJEST_ZALIHA
Tablica `POVIJEST_ZALIHA` sadrži povijest promjena zaliha proizvoda u skladištima.
- **Primarni ključ:** `id` - Jedinstveni identifikator promjene zaliha.
- **Strani ključevi:**
  - `skladiste_id` - Referenca na tablicu `SKLADISTE`.
  - `proizvod_id` - Referenca na tablicu `PROIZVOD`.
- **Atributi:**
  - `kolicina` - Nova količina proizvoda.
  - `datum` - Datum promjene zaliha.
  - `opis` - Opis promjene.

### 5.19. KURIRSKA_SLUZBA
Tablica `KURIRSKA_SLUZBA` sadrži informacije o kurirskim službama.
- **Primarni ključ:** `id` - Jedinstveni identifikator kurirske službe.
- **Atributi:**
  - `naziv` - Naziv kurirske službe, mora biti jedinstven.
  - `opis` - Detaljan opis kurirske službe.
  - `kontakt` - Kontakt informacije.

### 5.20. DOSTAVA
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

## 6. INICIJALIZACIJA

Ovaj vodič objašnjava kako postaviti i pokrenuti projekt baze podataka za web trgovinu. Projekt koristi MySQL i sastoji se od SQL skripti za definiranje sheme baze podataka i učitavanje podataka iz CSV datoteka ili manualno kroz INSERT-ove.


Slijedite ove korake za postavljanje projekta kroz **INSERT-ove**:

1.  **Preuzimanje potrebnih datoteka:**
    *   Preuzmite SQL skriptne datoteke (`shema.sql`, `insert_data.sql`).

2.  **Izvršavanje SQL skripti:**
    *   Spojite se na MySQL server koristeći konfiguriranu konekciju.
    *   Otvorite SQL skriptu `shema.sql`.
    *   Izvršite cijelu skriptu `shema.sql`. Ovo će stvoriti bazu podataka `web_trgovina_bp1` i sve potrebne tablice.
    *   Nakon uspješnog izvršavanja `shema.sql`, otvorite SQL skriptu `insert_data.sql`.
    *   Izvršite cijelu skriptu `insert_data.sql`. Ovo će popuniti tablice podacima s vrijednostima iz INSERT-ova.

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

## 7. UPITI

Napiši i objasni SQL upite koje si koristio u projektu, npr.:

### Upit 1:  
Opis: *[Kratki opis što upit radi]*  
```sql
-- SQL kod upita
```

*(Dodaj više upita s opisima i SQL kodom prema potrebi.)*

---

## 8. ZAKLJUČAK

*[Zaključi dokumentaciju s razmatranjem naučenih lekcija, izazova, prednosti baze, mogućnosti primjene itd.]*

---
