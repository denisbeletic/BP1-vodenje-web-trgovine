import csv
from datetime import datetime

# File paths
proizvod_file_path = 'd:\\Faks\\baze podataka 1\\BP1-vodenje-web-trgovine\\data\\proizvod.csv'
povijest_cijena_file_path = 'd:\\Faks\\baze podataka 1\\BP1-vodenje-web-trgovine\\data\\povijest_cijena.csv'

# 1. Read proizvod.csv and store current prices
proizvod_cijene = {}
with open(proizvod_file_path, 'r', newline='', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    for row in reader:
        try:
            proizvod_cijene[row['id']] = int(row['cijena'])
        except ValueError:
            print(f"Skipping product {row['id']} due to invalid price: {row['cijena']}")

if not proizvod_cijene:
    print("No product prices found in proizvod.csv. Cannot verify.")
    exit()

# 2. Read povijest_cijena.csv and group by proizvod_id
povijest_grouped = {}
with open(povijest_cijena_file_path, 'r', newline='', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    for row in reader:
        try:
            proizvod_id = row['proizvod_id']
            cijena = int(row['cijena'])
            # Attempt to parse multiple known date formats
            datum_str = row['datum']
            datum = None
            for fmt in ('%Y-%m-%d %H:%M:%S', '%Y-%m-%d %H:%M:%S.%f'): # Add more formats if needed
                try:
                    datum = datetime.strptime(datum_str, fmt)
                    break
                except ValueError:
                    continue
            if datum is None:
                print(f"Could not parse date for entry: {row}. Skipping.")
                continue
                
            if proizvod_id not in povijest_grouped:
                povijest_grouped[proizvod_id] = []
            povijest_grouped[proizvod_id].append({'cijena': cijena, 'datum': datum, 'original_row': row})
        except ValueError as e:
            print(f"Skipping price history entry due to data error: {row} - {e}")
        except KeyError as e:
            print(f"Skipping price history entry due to missing key: {row} - {e}")

if not povijest_grouped:
    print("No price history found in povijest_cijena.csv. Cannot verify.")
    exit()

# 3. Verify last price entry
discrepancies = 0
verified_products = 0

print("\nVerification Results:")
print("=====================")

for proizvod_id, current_price in proizvod_cijene.items():
    if proizvod_id in povijest_grouped:
        history_entries = povijest_grouped[proizvod_id]
        # Sort by date descending to get the latest entry first
        history_entries.sort(key=lambda x: x['datum'], reverse=True)
        
        latest_history_entry = history_entries[0]
        latest_historical_price = latest_history_entry['cijena']
        latest_historical_date = latest_history_entry['datum']

        if current_price == latest_historical_price:
            # print(f"OK: Proizvod ID {proizvod_id} - Current price ({current_price}) matches latest history price ({latest_historical_price} on {latest_historical_date.strftime('%Y-%m-%d')}).")
            verified_products +=1
        else:
            print(f"MISMATCH: Proizvod ID {proizvod_id}")
            print(f"  Current price in proizvod.csv: {current_price}")
            print(f"  Latest price in povijest_cijena.csv: {latest_historical_price} (Datum: {latest_historical_date.strftime('%Y-%m-%d %H:%M:%S')})")
            print(f"  Full latest history entry: {latest_history_entry['original_row']}")
            discrepancies += 1
    else:
        print(f"WARNING: Proizvod ID {proizvod_id} found in proizvod.csv but has no entries in povijest_cijena.csv.")
        # This could be a discrepancy depending on requirements, but the script `generate_povijest_cijena_data.py` should create at least one entry.

print("\nSummary:")
print("========")
if discrepancies == 0:
    print(f"All {verified_products} checked products have their current price correctly reflected as the latest entry in povijest_cijena.csv.")
else:
    print(f"Found {discrepancies} discrepancies where the current price does not match the latest historical price.")
    print(f"{verified_products} products were checked successfully against their history.")

print(f"Total products in proizvod.csv: {len(proizvod_cijene)}")
print(f"Total products with price history: {len(povijest_grouped)}")

# Check for products in povijest_cijena.csv that are not in proizvod.csv (orphaned history)
orphaned_history_products = set(povijest_grouped.keys()) - set(proizvod_cijene.keys())
if orphaned_history_products:
    print(f"WARNING: Found {len(orphaned_history_products)} products with price history but not present in proizvod.csv: {orphaned_history_products}")

