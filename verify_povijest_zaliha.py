import csv

def verify_stock_history():
    skladiste_proizvod_path = 'd:\\Faks\\baze podataka 1\\BP1-vodenje-web-trgovine\\data\\skladiste_proizvod.csv'
    povijest_zaliha_path = 'd:\\Faks\\baze podataka 1\\BP1-vodenje-web-trgovine\\data\\povijest_zaliha.csv'

    current_stock = {}
    with open(skladiste_proizvod_path, mode='r', newline='', encoding='utf-8') as sp_file:
        reader = csv.DictReader(sp_file)
        for row in reader:
            key = (row['proizvod_id'], row['skladiste_id'])
            current_stock[key] = int(row['kolicina'])

    latest_historical_stock = {}
    with open(povijest_zaliha_path, mode='r', newline='', encoding='utf-8') as pz_file:
        reader = csv.DictReader(pz_file)
        for row in reader:
            key = (row['proizvod_id'], row['skladiste_id'])
            # No need to parse to datetime object if only comparing as strings, 
            # as long as format is consistent (YYYY-MM-DD HH:MM:SS)
            datum_promjene = row['datum_promjene'] 
            nova_kolicina = int(row['nova_kolicina'])

            if key not in latest_historical_stock or datum_promjene > latest_historical_stock[key]['datum_promjene']:
                latest_historical_stock[key] = {'datum_promjene': datum_promjene, 'nova_kolicina': nova_kolicina}

    mismatches = 0
    missing_in_history = 0
    for key, stock_val in current_stock.items():
        if key in latest_historical_stock:
            if latest_historical_stock[key]['nova_kolicina'] != stock_val:
                print(f"MISMATCH for {key}: skladiste_proizvod has {stock_val}, povijest_zaliha latest is {latest_historical_stock[key]['nova_kolicina']}")
                mismatches += 1
        else:
            # This case should ideally not happen if generate_povijest_zaliha ensures at least one entry for each current stock
            print(f"MISSING in povijest_zaliha for {key}: No historical entries found for a current stock item.")
            missing_in_history += 1
            
    extra_in_history = 0
    for key in latest_historical_stock:
        if key not in current_stock:
            # This case means an item was in stock historically but is no longer (e.g. kolicina = 0 and removed from skladiste_proizvod)
            # This is a valid scenario, so we might not want to flag it as an error, depending on requirements.
            # For now, let's count it to be aware.
            print(f"INFO: EXTRA in povijest_zaliha for {key}: Entry exists in history but not in current skladiste_proizvod.csv (possibly out of stock and removed). Latest historical stock was {latest_historical_stock[key]['nova_kolicina']}")
            extra_in_history +=1

    if mismatches == 0 and missing_in_history == 0:
        print(f"Verification successful: All current stock levels match the latest entries in povijest_zaliha.csv.")
        if extra_in_history > 0:
            print(f"Note: Found {extra_in_history} items in history not present in current skladiste_proizvod.csv (e.g. fully depleted stock). This may be expected.")
    else:
        print(f"Verification issues found: Mismatches: {mismatches}, Missing in history: {missing_in_history}.")
        if extra_in_history > 0:
             print(f"Additionally, found {extra_in_history} items in history not present in current skladiste_proizvod.csv.")

if __name__ == "__main__":
    verify_stock_history()
