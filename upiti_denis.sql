-- najbolje_ocijenjeni_proizvodi --

SELECT 
    p.id AS proizvod_id,
    p.naziv AS proizvod_naziv,
    p.cijena AS proizvod_cijena,
    AVG(r.ocjena) AS prosjecna_ocjena,
    COUNT(r.id) AS broj_recenzija,
    GROUP_CONCAT(DISTINCT CONCAT(k.ime, ' ', k.prezime) SEPARATOR ', ') AS korisnici
FROM proizvod AS p
LEFT JOIN recenzija AS r ON p.id = r.proizvod_id
LEFT JOIN korisnik AS k ON r.korisnik_id = k.id
GROUP BY p.id
HAVING AVG(r.ocjena) > 4
ORDER BY prosjecna_ocjena DESC;

-- analiza_najcesce_koristenih_kupona --

SELECT 
    k.id AS kupon_id,
    k.naziv AS naziv_kupona,
    COUNT(kn.narudzba_id) AS broj_koristenja,
    SUM(k.vrijednost) AS ukupna_vrijednost_popusta,
    AVG(k.vrijednost) AS prosjecna_vrijednost_popusta
FROM kupon AS k
INNER JOIN kupon_narudzba AS kn ON k.id = kn.kupon_id
INNER JOIN narudzba AS n ON kn.narudzba_id = n.id
GROUP BY k.id
HAVING broj_koristenja > 3
ORDER BY broj_koristenja DESC;

-- analiza_kupaca_po_potrosnji --

SELECT 
    k.id AS korisnik_id,
    CONCAT(k.ime, ' ', k.prezime) AS ime_prezime,
    COUNT(n.id) AS broj_narudzbi,
    SUM(n.ukupni_iznos) AS ukupna_potrosnja,
    AVG(n.ukupni_iznos) AS prosjecna_vrijednost_narudzbe
FROM korisnik AS k
LEFT JOIN narudzba AS n ON k.id = n.korisnik_id
GROUP BY k.id
ORDER BY ukupna_potrosnja DESC;

-- promjene_zaliha_po_skladistima --

SELECT 
    pz.skladiste_id,
    s.naziv AS skladiste_naziv,
    pz.proizvod_id,
    p.naziv AS proizvod_naziv,
    pz.kolicina,
    pz.opis,
    pz.datum
FROM povijest_zaliha AS pz
INNER JOIN proizvod p ON pz.proizvod_id = p.id
INNER JOIN skladiste s ON pz.skladiste_id = s.id
WHERE pz.proizvod_id = 11 -- zamijeniti po potrebi
ORDER BY pz.datum DESC;