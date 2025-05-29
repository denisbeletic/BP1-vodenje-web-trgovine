-- Najaktivniji korisnici(30 dana)
CREATE OR REPLACE VIEW top_kupci_30_dana AS
SELECT 
    k.id AS korisnik_id,
    k.ime,
    k.prezime,
    k.email,
    COUNT(n.id) AS broj_narudzbi,
    SUM(n.ukupni_iznos) AS ukupna_potrosnja
FROM korisnik k
JOIN narudzba n ON k.id = n.korisnik_id
WHERE n.datum >= DATE_SUB('2025-05-26 00:00:00', INTERVAL 30 DAY)
GROUP BY k.id, k.ime, k.prezime, k.email
ORDER BY ukupna_potrosnja DESC
LIMIT 10;

-- Proizvodi bez narudžbi u zadnjih 60 dana
CREATE OR REPLACE VIEW proizvodi_bez_narudzbi_60_dana AS
SELECT 
    p.id,
    p.naziv,
    p.cijena,
    COALESCE(SUM(np.kolicina), 0) AS kolicina_prodanih
FROM proizvod p
LEFT JOIN narudzba_proizvod np ON p.id = np.proizvod_id
LEFT JOIN narudzba n ON np.narudzba_id = n.id AND n.datum >= DATE_SUB('2025-05-26 00:00:00', INTERVAL 60 DAY)
GROUP BY p.id, p.naziv, p.cijena
HAVING COALESCE(SUM(np.kolicina), 0) = 0;

-- Trenutni popusti po kuponima
CREATE OR REPLACE VIEW kupon_statistika AS
SELECT
    k.id AS kupon_id,
    k.naziv,
    k.tip,
    k.vrijednost,
    COUNT(kn.narudzba_id) AS broj_koristenja,
    MIN(k.datum_pocetka) AS od_kada,
    MAX(k.datum_isteka) AS do_kada
FROM kupon k
LEFT JOIN kupon_narudzba kn ON k.id = kn.kupon_id
WHERE k.status = 'aktivan'
GROUP BY k.id, k.naziv, k.tip, k.vrijednost;

-- Povijest zaliha za proizvod
CREATE OR REPLACE VIEW povijest_zaliha_proizvoda AS
SELECT
    pz.proizvod_id,
    p.naziv AS proizvod_naziv,
    s.naziv AS skladiste_naziv,
    pz.kolicina,
    pz.opis,
    pz.datum
FROM povijest_zaliha pz
JOIN proizvod p ON p.id = pz.proizvod_id
JOIN skladiste s ON s.id = pz.skladiste_id
WHERE pz.proizvod_id = 5 -- zamijeniti po potrebi
ORDER BY pz.datum DESC;
