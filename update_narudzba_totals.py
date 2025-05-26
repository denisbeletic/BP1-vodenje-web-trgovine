import csv
import os
import traceback

print("--- Python script to update narudzba totals started ---")

# Definicija putanja do datoteka
narudzba_proizvod_file_path = 'd:/Faks/baze podataka 1/BP1-vodenje-web-trgovine/data/narudzba_proizvod.csv'
narudzbe_file_path = 'd:/Faks/baze podataka 1/BP1-vodenje-web-trgovine/data/narudzba_sorted.csv'

print(f"Narudzba Proizvod file path: {narudzba_proizvod_file_path}")
print(f"Narudzbe (to be updated) file path: {narudzbe_file_path}")

# 1. Učitavanje podataka o stavkama narudžbi i izračun ukupnih iznosa po narudžbi
order_item_totals = {}
try:
    print(f"Attempting to read narudzba_proizvod_data from {narudzba_proizvod_file_path}")
    if not os.path.exists(narudzba_proizvod_file_path):
        print(f"Greška: Datoteka s stavkama narudžbi NIJE PRONAĐENA na {narudzba_proizvod_file_path}")
        exit()
    
    with open(narudzba_proizvod_file_path, mode='r', newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        if not all(col in reader.fieldnames for col in ['narudzba_id', 'kolicina', 'cijena']):
            print(f"Greška: Datoteka {narudzba_proizvod_file_path} mora sadržavati stupce 'narudzba_id', 'kolicina' i 'cijena'. Pronađeni stupci: {reader.fieldnames}")
            exit()
        
        for i, row in enumerate(reader):
            try:
                narudzba_id = int(row['narudzba_id'])
                kolicina = int(row['kolicina'])
                cijena_stavke = int(row['cijena'])
                item_total = kolicina * cijena_stavke
                
                order_item_totals[narudzba_id] = order_item_totals.get(narudzba_id, 0) + item_total
            except (ValueError, TypeError) as ve:
                print(f"Preskačem red {i+1} u {narudzba_proizvod_file_path} zbog neispravne vrijednosti: {row}. Greška: {ve}")
            except KeyError as ke:
                print(f"Preskačem red {i+1} u {narudzba_proizvod_file_path} zbog nedostatka ključa: {row}. Greška: {ke}")
    print(f"Successfully calculated totals for {len(order_item_totals)} orders from {narudzba_proizvod_file_path}.")

except Exception as e:
    print(f"Dogodila se opća greška prilikom čitanja {narudzba_proizvod_file_path}: {e}")
    print(traceback.format_exc())
    exit()

if not order_item_totals:
    print("Nisu izračunati ukupni iznosi stavki narudžbi. Moguće da je {narudzba_proizvod_file_path} prazna ili neispravna. Izlazim.")
    exit()

# 2. Učitavanje narudžbi, ažuriranje ukupnog iznosa i spremanje ažuriranih redaka
updated_narudzbe_data = []
original_header_narudzbe = []
try:
    print(f"Attempting to read and update narudzbe from {narudzbe_file_path}")
    if not os.path.exists(narudzbe_file_path):
        print(f"Greška: Datoteka s narudžbama NIJE PRONAĐENA na {narudzbe_file_path}")
        exit()

    with open(narudzbe_file_path, mode='r', newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        original_header_narudzbe = reader.fieldnames
        if 'id' not in original_header_narudzbe or 'ukupni_iznos' not in original_header_narudzbe:
            print(f"Greška: Datoteka {narudzbe_file_path} mora sadržavati stupce 'id' i 'ukupni_iznos'. Pronađeni stupci: {original_header_narudzbe}")
            exit()

        for i, row in enumerate(reader):
            try:
                narudzba_id = int(row['id'])
                new_ukupni_iznos = order_item_totals.get(narudzba_id, 0) # Ako narudžba nema stavki, ukupni iznos je 0
                
                # Ispis za provjeru prije ažuriranja
                if narudzba_id == 28: # Print for specific order ID
                    print(f"DEBUG: Narudžba ID: {narudzba_id}, Stari iznos: {row['ukupni_iznos']}, Izračunati novi iznos: {new_ukupni_iznos}, Tip novog iznosa: {type(new_ukupni_iznos)}")
                    print(f"DEBUG: Stavke za narudžbu 28 u order_item_totals: {order_item_totals.get(28)}")

                row['ukupni_iznos'] = str(new_ukupni_iznos)
                updated_narudzbe_data.append(row)
            except (ValueError, TypeError) as ve:
                print(f"Preskačem red {i+1} u {narudzbe_file_path} zbog neispravne vrijednosti: {row}. Greška: {ve}")
            except KeyError as ke:
                print(f"Preskačem red {i+1} u {narudzbe_file_path} zbog nedostatka ključa: {row}. Greška: {ke}")
    print(f"Successfully prepared {len(updated_narudzbe_data)} orders for update.")

except Exception as e:
    print(f"Dogodila se opća greška prilikom čitanja ili pripreme ažuriranja za {narudzbe_file_path}: {e}")
    print(traceback.format_exc())
    exit()

# 3. Pisanje ažuriranih podataka natrag u narudzbe_sorted.csv
if updated_narudzbe_data and original_header_narudzbe:
    try:
        print(f"Attempting to write updated data back to {narudzbe_file_path}")
        with open(narudzbe_file_path, mode='w', newline='', encoding='utf-8') as csvfile:
            writer = csv.DictWriter(csvfile, fieldnames=original_header_narudzbe)
            writer.writeheader()
            writer.writerows(updated_narudzbe_data)
            csvfile.flush()
        print(f"--- Uspješno ažurirana datoteka {narudzbe_file_path} s novim ukupnim iznosima. --- ")
    except IOError as ioe:
        print(f"Greška: Nije moguće pisati u izlaznu datoteku {narudzbe_file_path}. Greška: {ioe}")
        print(traceback.format_exc())
    except Exception as e:
        print(f"Dogodila se opća greška prilikom pisanja ažuriranih podataka u {narudzbe_file_path}: {e}")
        print(traceback.format_exc())
else:
    print("Nema podataka za ažuriranje ili originalni header nije pročitan. Preskačem pisanje.")

print("--- Python script to update narudzba totals finished ---")
