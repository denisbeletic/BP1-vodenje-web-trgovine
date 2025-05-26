DROP DATABASE IF EXISTS vodenje_trgovine;
CREATE DATABASE vodenje_trgovine;
USE vodenje_trgovine; 

CREATE TABLE proizvod (
    id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(255) NOT NULL,
    opis VARCHAR(500),
    cijena INT NOT NULL, -- Cijena proizvoda u centima
	CHECK (cijena > 0) -- Cijena mora biti veća od 0
);

CREATE TABLE kategorija (
    id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(255) NOT NULL UNIQUE,
    opis VARCHAR(500)
);

CREATE TABLE proizvod_kategorija (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proizvod_id INT NOT NULL,
    kategorija_id INT NOT NULL,
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(id),
    FOREIGN KEY (kategorija_id) REFERENCES kategorija(id)
);

CREATE TABLE korisnik (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ime VARCHAR(255) NOT NULL,
    prezime VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    lozinka VARCHAR(255) NOT NULL,
    adresa VARCHAR(255),
    grad VARCHAR(255),
    drzava VARCHAR(255),
    telefon VARCHAR(20)
);

CREATE TABLE narudzba (
    id INT AUTO_INCREMENT PRIMARY KEY,
    korisnik_id INT NOT NULL,
    datum DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('na čekanju', 'otkazano', 'isporučeno') DEFAULT 'na čekanju',
    ukupni_iznos INT NOT NULL, -- Ukupna cijena narudžbe u centima
    nacin_placanja ENUM('kreditna kartica', 'pouzeće', 'bankovni transfer') NOT NULL,
    FOREIGN KEY (korisnik_id) REFERENCES korisnik(id),
    INDEX idx_narudzba_korisnik_id (korisnik_id)
);


CREATE TABLE narudzba_proizvod (
    id INT AUTO_INCREMENT PRIMARY KEY,
    narudzba_id INT NOT NULL,
    proizvod_id INT NOT NULL,
    kolicina INT NOT NULL,
    cijena INT NOT NULL, -- Cijena proizvoda u centima
    FOREIGN KEY (narudzba_id) REFERENCES narudzba(id),
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(id),
    UNIQUE (narudzba_id, proizvod_id)
);

CREATE TABLE uplata (
    id INT AUTO_INCREMENT PRIMARY KEY,
    narudzba_id INT NOT NULL,
    iznos INT NOT NULL, -- Iznos transakcije u centima
    datum DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('uspješna', 'neuspješna') DEFAULT 'uspješna',
    FOREIGN KEY (narudzba_id) REFERENCES narudzba(id)
);

CREATE TABLE recenzija (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proizvod_id INT NOT NULL,
    korisnik_id INT NOT NULL,
    ocjena INT CHECK (ocjena >= 1 AND ocjena <= 5), -- Ocjena između 1 i 5
    komentar VARCHAR(500),
    datum DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(id),
    FOREIGN KEY (korisnik_id) REFERENCES korisnik(id)
);

-- Kuponi mogu imati različite tipove (fiksni iznos, postotak popusta, besplatna dostava)
-- Fiksni iznos - određeni iznos koji se oduzima od ukupne cijene narudžbe
-- Postotak popusta - određeni postotak koji se oduzima od ukupne cijene narudžbe
-- Besplatna dostava - kupon koji omogućava besplatnu dostavu
-- Vrijednost kupona može biti 0 samo za besplatnu dostavu

CREATE TABLE kupon (
    id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(255) NOT NULL UNIQUE,
    tip ENUM('fiksni', 'postotak', 'besplatna dostava') NOT NULL,
    vrijednost INT NOT NULL,
    status ENUM('aktivan', 'neaktivan') DEFAULT 'aktivan',
    datum_pocetka DATETIME,
    datum_isteka DATETIME,
    CHECK (
        (tip = 'fiksni' AND vrijednost > 0) OR
        (tip = 'postotak' AND vrijednost BETWEEN 1 AND 100) OR
        (tip = 'besplatna dostava' AND vrijednost = 0)
    )
);

CREATE TABLE kupon_narudzba (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kupon_id INT NOT NULL,
    narudzba_id INT NOT NULL,
    FOREIGN KEY (kupon_id) REFERENCES kupon(id),
    FOREIGN KEY (narudzba_id) REFERENCES narudzba(id),
    UNIQUE (kupon_id, narudzba_id)
);

CREATE TABLE wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    korisnik_id INT NOT NULL UNIQUE,
    naziv VARCHAR(255) NOT NULL,
    datum DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (korisnik_id) REFERENCES korisnik(id)
);

CREATE TABLE wishlist_proizvod (
    id INT AUTO_INCREMENT PRIMARY KEY,
    wishlist_id INT NOT NULL,
    proizvod_id INT NOT NULL,
    FOREIGN KEY (wishlist_id) REFERENCES wishlist(id),
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(id),
    UNIQUE (wishlist_id, proizvod_id)
);

CREATE TABLE skladiste (
    id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(255) NOT NULL UNIQUE,
    adresa VARCHAR(255),
    grad VARCHAR(255),
    drzava VARCHAR(255)
);

CREATE TABLE skladiste_proizvod (
    id INT AUTO_INCREMENT PRIMARY KEY,
    skladiste_id INT NOT NULL,
    proizvod_id INT NOT NULL,
    kolicina INT NOT NULL,
    FOREIGN KEY (skladiste_id) REFERENCES skladiste(id),
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(id),
    UNIQUE (skladiste_id, proizvod_id)
);

CREATE TABLE povijest_cijena (
    id INT AUTO_INCREMENT PRIMARY KEY,
    proizvod_id INT NOT NULL,
    cijena INT NOT NULL, -- Cijena proizvoda u centima
    datum DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(id)
);

CREATE TABLE povijest_zaliha (
    id INT AUTO_INCREMENT PRIMARY KEY,
    skladiste_id INT NOT NULL,
    proizvod_id INT NOT NULL,
    kolicina INT NOT NULL,
    datum DATETIME DEFAULT CURRENT_TIMESTAMP,
    opis VARCHAR(255),
    FOREIGN KEY (skladiste_id) REFERENCES skladiste(id),
    FOREIGN KEY (proizvod_id) REFERENCES proizvod(id)
);

CREATE TABLE kurirska_sluzba (
    id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(255) NOT NULL UNIQUE,
    opis VARCHAR(500),
    kontakt VARCHAR(255)
);

CREATE TABLE dostava (
    id INT AUTO_INCREMENT PRIMARY KEY,
    naziv VARCHAR(255) NOT NULL UNIQUE,
    status ENUM('naručeno', 'u transportu', 'isporučeno') DEFAULT 'naručeno',
    narudzba_id INT NOT NULL,
    cijena INT NOT NULL, -- Cijena dostave u centima
    opis VARCHAR(500),
    datum_kreiranja DATETIME DEFAULT CURRENT_TIMESTAMP,
    datum_slanja DATETIME,
    datum_dostave DATETIME,
    kurirska_sluzba_id INT NOT NULL,
    vrijeme_dostave INT,
    FOREIGN KEY (narudzba_id) REFERENCES narudzba(id),
    FOREIGN KEY (kurirska_sluzba_id) REFERENCES kurirska_sluzba(id),
    CHECK (vrijeme_dostave > 0) -- Vrijeme dostave mora biti veće od 0
);