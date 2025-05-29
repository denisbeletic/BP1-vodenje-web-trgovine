-- Top 10 najprodavanijih proizvoda u zadnjih 30 dana od odredenog datuma
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

-- Sve informacije o jednom proizvodu (detalji, slike, kategorije, recenzije, količina na skladištu)
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

-- Sve proizvode koji se najčešće prodaju zajedno s definiranim proizvodom
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


-- Proizvodi po kategoriji i rasponu cijena
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


-- Analiza prodaje po mjesecima
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