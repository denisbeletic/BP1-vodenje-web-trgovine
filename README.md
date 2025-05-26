# BP1-vodenje-web-trgovine
Projekt napravljen u sklopu kolegija 'Baze podataka 1' - sustav za vođenje web trgovine - FIPU

Nakon init commita - files nazvani "model" su EER dijagrami

# Kako pokrenuti projekt

Ovaj vodič objašnjava kako postaviti i pokrenuti projekt baze podataka za web trgovinu. Projekt koristi MySQL i sastoji se od SQL skripti za definiranje sheme baze podataka i učitavanje podataka iz CSV datoteka.

Slijedite ove korake za postavljanje projekta:

1.  **Preuzimanje potrebnih datoteka:**
    *   Preuzmite sve SQL skriptne datoteke (`shema.sql`, `load_data.sql`, itd.).
    *   Preuzmite cijelu mapu `data` koja sadrži sve potrebne CSV datoteke.

2.  **Postavljanje CSV datoteka za MySQL:**
    *   MySQL zahtijeva da se CSV datoteke za `LOAD DATA INFILE` nalaze u sigurnosno odobrenom direktoriju. Da biste pronašli putanju ovog direktorija, izvršite sljedeći SQL upit u MySQL Workbenchu (ili drugom MySQL klijentu):
        ```sql
        SHOW VARIABLES LIKE "secure_file_priv";
        ```
    *   Kopirajte cijelu mapu `data` (sa svim CSV datotekama) u putanju koju ste dobili gornjim upitom. Česta zadana putanja je `C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\`. Ako je `secure_file_priv` prazan, trebate ga konfigurirati u `my.ini` (Windows) ili `my.cnf` (Linux/macOS) datoteci MySQL servera i zatim restartati MySQL server. Ako je `NULL`, `LOAD DATA INFILE` je onemogućen.

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
    *   Nakon uspješnog izvršavanja `shema.sql`, otvorite SQL skriptu `load_data.sql`.
    *   Izvršite cijelu skriptu `load_data.sql`. Ovo će popuniti tablice podacima iz CSV datoteka. **Napomena:** Provjerite jesu li putanje do CSV datoteka unutar `load_data.sql` ispravno postavljene na direktorij iz koraka 2 (npr. `C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/naziv_datoteke.csv`).


