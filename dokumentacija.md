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

*[Ovdje napiši kratak opis projekta, svrhu baze podataka i razloge odabira teme.]*

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
DOSTAVA (id (PK), naziv, status, narudzba_id (FK), cijena, opis, datum_kreiranja, datum_slanja, datum_dostave, kurirska_sluzba_id (FK))
```

---

## 4. EER DIJAGRAM

![EER dijagram](./EER%20diagram.png)

---

## 5. TABLICE

Opis tablica korištenih u bazi podataka.

### 5.1. PROIZVOD
*[Opis tablice, primarni i strani ključevi, tipovi podataka, ograničenja itd.]*

### 5.2. SLIKA  
### 5.3. SLIKA_PROIZVOD  
### 5.4. KATEGORIJA  
### 5.5. PROIZVOD_KATEGORIJA  
### 5.6. KORISNIK  
### 5.7. NARUDZBA  
### 5.8. NARUDZBA_PROIZVOD  
### 5.9. UPLATA  
### 5.10. RECENZIJA  
### 5.11. KUPON  
### 5.12. KUPON_NARUDZBA  
### 5.13. WISHLIST    
### 5.14. WISHLIST_PROIZVOD    
### 5.15. SKLADISTE  
### 5.16. SKLADISTE_PROIZVOD  
### 5.17. POVIJEST_CIJENA  
### 5.18. POVIJEST_ZALIHA  
### 5.19. KURIRSKA_SLUZBA  
### 5.20. DOSTAVA  

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
