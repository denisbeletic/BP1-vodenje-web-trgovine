-- Top 10 najprodavanijih proizvoda u zadnjih 30 dana
CREATE OR REPLACE VIEW top10_najprodavanijih_proizvoda AS
SELECT 
    p.id, 
    p.naziv, 
    p.cijena, 
    SUM(np.kolicina) AS ukupna_kolicina
FROM proizvod p
JOIN narudzba_proizvod np ON p.id = np.proizvod_id
JOIN narudzba n ON np.narudzba_id = n.id
WHERE n.datum >= DATE_SUB('2025-05-26 00:00:00', INTERVAL 30 DAY) -- Fixed date for testing
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
    COALESCE(SUM(DISTINCT sp.kolicina), 0) AS ukupna_kolicina_na_skladistu,
    GROUP_CONCAT(DISTINCT CONCAT(r.ocjena, '::', r.komentar, '::', r.datum, '::', ku.ime, ' ', ku.prezime) SEPARATOR ' || ') AS recenzije
FROM proizvod p
LEFT JOIN proizvod_kategorija pk ON p.id = pk.proizvod_id
LEFT JOIN kategorija k ON pk.kategorija_id = k.id
LEFT JOIN slika_proizvod spv ON p.id = spv.proizvod_id
LEFT JOIN slika s ON spv.slika_id = s.id
LEFT JOIN skladiste_proizvod sp ON p.id = sp.proizvod_id
LEFT JOIN recenzija r ON p.id = r.proizvod_id
LEFT JOIN korisnik ku ON r.korisnik_id = ku.id
WHERE p.id = 11 
GROUP BY p.id;

-- Sve proizvode koji se najčešće prodaju zajedno s definiranim proizvodom
CREATE OR REPLACE VIEW najcesce_zajedno_proizvodi AS
SELECT
    p2.id AS proizvod_id,
    p2.naziv AS proizvod_naziv,
    COUNT(*) AS broj_zajednickih_kupovina
FROM
    narudzba_proizvod np1
JOIN
    narudzba_proizvod np2 ON np1.narudzba_id = np2.narudzba_id
JOIN
    proizvod p2 ON np2.proizvod_id = p2.id
WHERE
    np1.proizvod_id = 11
    AND np2.proizvod_id <> np1.proizvod_id
    AND np2.kolicina > 0
GROUP BY
    p2.id, p2.naziv
ORDER BY
    broj_zajednickih_kupovina DESC;

-- Sve proizvode koje treba naruciti na osnovu prodaje zadnjim 30 dana a kojih nema dovoljno na skladištu
CREATE OR REPLACE VIEW proizvodi_za_naruciti AS
SELECT
    p.id AS proizvod_id,
    p.naziv AS proizvod_naziv,
    COALESCE(SUM(np.kolicina), 0) AS ukupna_kolicina_prodanih_30_dana,
    COALESCE(skp.ukupna_kolicina_na_svim_skladistima, 0) AS kolicina_na_skladistu_ukupno,
    (COALESCE(SUM(np.kolicina), 0) - COALESCE(skp.ukupna_kolicina_na_svim_skladistima, 0)) AS kolicina_za_naruciti
FROM
    proizvod p
JOIN
    narudzba_proizvod np ON p.id = np.proizvod_id
JOIN
    narudzba n ON np.narudzba_id = n.id AND n.datum >= DATE_SUB('2025-05-26 00:00:00', INTERVAL 30 DAY) -- Fixed date for testing
LEFT JOIN 
    (SELECT proizvod_id, SUM(kolicina) AS ukupna_kolicina_na_svim_skladistima 
     FROM skladiste_proizvod 
     GROUP BY proizvod_id) skp ON p.id = skp.proizvod_id
GROUP BY
    p.id, p.naziv, skp.ukupna_kolicina_na_svim_skladistima
HAVING 
    (COALESCE(SUM(np.kolicina), 0) - COALESCE(skp.ukupna_kolicina_na_svim_skladistima, 0)) > 0
ORDER BY
    kolicina_za_naruciti DESC;
