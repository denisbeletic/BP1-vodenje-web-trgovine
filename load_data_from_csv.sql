USE web_trgovina_bp1;

-- Make sure the MySQL server has permissions to read from the specified path.
-- You might need to adjust the 'secure_file_priv' MySQL variable.
-- Assumes CSV files have a header row, hence IGNORE 1 ROWS.
-- Assumes CSV files are comma-delimited and fields are optionally enclosed in double quotes.
-- Assumes line endings are \r\n (Windows default). Change to \n if needed.

-- Load data for tables without or with fewer dependencies first

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/kategorija.csv'
INTO TABLE kategorija
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, naziv, opis);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/korisnik.csv'
INTO TABLE korisnik
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, ime, prezime, email, lozinka, adresa, grad, drzava, telefon);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/proizvod.csv'
INTO TABLE proizvod
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, naziv, opis, cijena);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/slika.csv'
INTO TABLE slika
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, putanja, naziv, opis);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/skladiste.csv'
INTO TABLE skladiste
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, naziv, adresa, grad, drzava);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/kurirska_sluzba.csv'
INTO TABLE kurirska_sluzba
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, naziv, opis, kontakt);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/kupon.csv'
INTO TABLE kupon
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, naziv, tip, vrijednost, status, datum_pocetka, datum_isteka);

-- Load data for tables with dependencies

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/proizvod_kategorija.csv'
INTO TABLE proizvod_kategorija
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, proizvod_id, kategorija_id);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/slika_proizvod.csv'
INTO TABLE slika_proizvod
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, proizvod_id, slika_id);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/narudzba.csv'
INTO TABLE narudzba
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, korisnik_id, datum, status, ukupni_iznos, nacin_placanja);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/wishlist.csv'
INTO TABLE wishlist
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, korisnik_id, naziv, datum);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/skladiste_proizvod.csv'
INTO TABLE skladiste_proizvod
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, skladiste_id, proizvod_id, kolicina);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/povijest_cijena.csv'
INTO TABLE povijest_cijena
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, proizvod_id, cijena, datum);

-- Load data for tables with further dependencies

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/narudzba_proizvod.csv'
INTO TABLE narudzba_proizvod
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, narudzba_id, proizvod_id, kolicina, cijena);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/uplata.csv'
INTO TABLE uplata
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, narudzba_id, iznos, datum, status);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/recenzija.csv'
INTO TABLE recenzija
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, proizvod_id, korisnik_id, ocjena, komentar, datum);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/kupon_narudzba.csv'
INTO TABLE kupon_narudzba
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, kupon_id, narudzba_id);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/wishlist_proizvod.csv'
INTO TABLE wishlist_proizvod
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, wishlist_id, proizvod_id);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/povijest_zaliha.csv'
INTO TABLE povijest_zaliha
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, proizvod_id, skladiste_id, datum, kolicina, opis);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/data/dostava.csv'
INTO TABLE dostava
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, status, narudzba_id, cijena, opis, datum_kreiranja, datum_slanja, datum_dostave, kurirska_sluzba_id);

SELECT 'Data loading complete.' AS status;
