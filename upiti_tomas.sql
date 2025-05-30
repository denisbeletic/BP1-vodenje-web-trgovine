-- 1. Kupce koji su narucili robu ukupne vrijednosti vece od 50.000 i njihove podatke
SELECT 
    k.id AS korisnik_id,
    CONCAT(k.ime, ' ', k.prezime) AS ime_prezime,
    k.email,
    SUM(n.ukupni_iznos) AS ukupna_potrosnja
FROM 
    korisnik k
JOIN 
    narudzba n ON k.id = n.korisnik_id
GROUP BY 
    k.id
HAVING 
    ukupna_potrosnja > 50000
ORDER BY 
    ukupna_potrosnja DESC; 

-- 2. Povijest cijena proizvoda i izracun postotnu promjenu izmedu uzastopnih cijena

SELECT 
    pc.proizvod_id,
    p.naziv AS proizvod_naziv,
    pc.datum,
    pc.cijena AS cijena_u_centima,
    LAG(pc.cijena) OVER (PARTITION BY pc.proizvod_id ORDER BY pc.datum) AS prethodna_cijena,
    ROUND(
        ((pc.cijena - LAG(pc.cijena) OVER (PARTITION BY pc.proizvod_id ORDER BY pc.datum)) / 
        LAG(pc.cijena) OVER (PARTITION BY pc.proizvod_id ORDER BY pc.datum)) * 100, 2
    ) AS postotna_promjena
FROM 
    povijest_cijena pc
JOIN 
    proizvod p ON pc.proizvod_id = p.id
ORDER BY 
    pc.proizvod_id, pc.datum;

-- 3. Skladista s najvecim zalihama svakog proizvoda
SELECT 
    sp.proizvod_id,
    p.naziv AS proizvod_naziv,
    sp.skladiste_id,
    s.naziv AS skladiste_naziv,
    sp.kolicina
FROM 
    skladiste_proizvod sp
JOIN 
    proizvod p ON sp.proizvod_id = p.id
JOIN 
    skladiste s ON sp.skladiste_id = s.id
WHERE 
    (sp.proizvod_id, sp.kolicina) IN (
        SELECT 
            proizvod_id, MAX(kolicina)
        FROM 
            skladiste_proizvod
        GROUP BY 
            proizvod_id
    );

-- 4. Sve narudzbe s njihovom ukupnom cijenom, ukljucujuci primijenjene kupone i troskove dostave.
SELECT 
    n.id AS narudzba_id,
    n.datum AS datum_narudzbe,
    n.ukupni_iznos AS ukupni_iznos_proizvoda,
    IFNULL(k.vrijednost, 0) AS vrijednost_kupona,
    IFNULL(d.cijena, 0) AS cijena_dostave,
    (n.ukupni_iznos - IFNULL(k.vrijednost, 0) + IFNULL(d.cijena, 0)) AS ukupni_trosak
FROM 
    narudzba n
LEFT JOIN 
    kupon_narudzba kn ON n.id = kn.narudzba_id
LEFT JOIN 
    kupon k ON kn.kupon_id = k.id
LEFT JOIN 
    dostava d ON n.id = d.narudzba_id;
