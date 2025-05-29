-- Korisnici koji su naručili više puta isti proizvod i koliko puta

SELECT 
    k.id AS korisnik_id,
    CONCAT(k.ime, ' ', k.prezime) AS ime_prezime,
    p.id AS proizvod_id,
    p.naziv AS naziv_proizvoda,
    COUNT(*) AS broj_ponovljenih_kupnji
FROM narudzba n
JOIN narudzba_proizvod np ON n.id = np.narudzba_id
JOIN korisnik k ON n.korisnik_id = k.id
JOIN proizvod p ON np.proizvod_id = p.id
GROUP BY k.id, p.id
HAVING broj_ponovljenih_kupnji > 1
ORDER BY broj_ponovljenih_kupnji DESC, ime_prezime;

-- Pregled proizvoda s ukupnom zaradom i brojem skladišta u kojima se nalaze

SELECT 
    p.id AS proizvod_id,
    p.naziv AS naziv_proizvoda,
    p.cijena,
    SUM(np.kolicina * np.cijena) AS ukupna_zarada,
    COUNT(DISTINCT sp.skladiste_id) AS broj_skladista
FROM proizvod p
LEFT JOIN narudzba_proizvod np ON p.id = np.proizvod_id
LEFT JOIN skladiste_proizvod sp ON p.id = sp.proizvod_id
GROUP BY p.id, p.naziv, p.cijena
ORDER BY ukupna_zarada DESC;

-- Korisnici koji su koristili više različitih kupona u narudžbama

SELECT 
    k.id AS korisnik_id,
    CONCAT(k.ime, ' ', k.prezime) AS ime_prezime,
    COUNT(DISTINCT kn.kupon_id) AS broj_razlicitih_kupona,
    GROUP_CONCAT(DISTINCT ku.naziv ORDER BY ku.naziv SEPARATOR ', ') AS kuponi
FROM korisnik k
JOIN narudzba n ON k.id = n.korisnik_id
JOIN kupon_narudzba kn ON n.id = kn.narudzba_id
JOIN kupon ku ON kn.kupon_id = ku.id
GROUP BY k.id
HAVING broj_razlicitih_kupona > 1
ORDER BY broj_razlicitih_kupona DESC;

-- Prosječan broj proizvoda po narudžbi po korisniku i njihova ukupna količina

SELECT 
    k.id AS korisnik_id,
    CONCAT(k.ime, ' ', k.prezime) AS ime_prezime,
    COUNT(DISTINCT n.id) AS broj_narudzbi,
    SUM(np.kolicina) AS ukupna_kolicina_proizvoda,
    SUM(np.kolicina) / COUNT(DISTINCT n.id) AS prosjecno_proizvoda_po_narudzbi
FROM korisnik k
JOIN narudzba n ON k.id = n.korisnik_id
JOIN narudzba_proizvod np ON n.id = np.narudzba_id
GROUP BY k.id
HAVING broj_narudzbi > 1
ORDER BY prosjecno_proizvoda_po_narudzbi DESC;