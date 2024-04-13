import requests
import json
import os
import subprocess


URL = "https://dummyjson.com/products"
filtered_products = []


def write_output(URL):
    r = requests.get(URL)
    j = r.json()
    data = json.dumps(j)
    original_file_path = os.path.join(script_dir, 'original_file.json')
    if not os.path.exists(original_file_path):
        with open(original_file_path, 'w') as original_file:
            original_file.write(data)
    else:
        print("original_file.json already exists. Skipping writing.")


def filter_objects(filtered_products):
    with open("original_file.json", "r") as file:
        newfile = json.load(file)
        products = newfile['products']
        for product in products:
            price = product.get('price')
            if price >= 100:
                filtered_products.append(product)

    filtered_list_path = 'filtered_list.json'
    with open(filtered_list_path, 'w') as filtered_list:
        json.dump(filtered_products, filtered_list)


def upload_to_s3(cfDomain, filtered_list_path):
    try:
        subprocess.run(["curl", "-X", "PUT", "-T", filtered_list_path, f"{cfDomain}/filtered_list.json"], check=True)
        print("File successfully uploaded.")
    except subprocess.CalledProcessError as e:
        print(f"Error uploading file: {e}")

def download_from_s3(cfDomain):
    try:
        subprocess.run(["curl", "-o", "downloaded_filtered_list.json", f"{cfDomain}/filtered_list.json"], check=True)
        print("File successfully downloaded.")
    except subprocess.CalledProcessError as e:
        print(f"Error downloading file: {e}")

if __name__ == "__main__":
    abspath = os.path.abspath(__file__)
    dname = os.path.dirname(abspath)
    os.chdir(dname)

    script_dir = os.path.dirname(os.path.abspath(__file__))

    cfDomain = os.environ.get("TERRAGRUNT_OUTPUT")
    print(cfDomain)

    #CHANGE LATER TO /tmp for linux support!!
    # output_file_path = os.path.join('C:\\Temp', 'output.txt')
    # with open(output_file_path, 'r') as tf_output:
    #     cfDomain = tf_output.read().replace('\\"', '').strip()
    #     cfDomain = f'http://{cfDomain}'

    write_output(URL)
    filter_objects(filtered_products)
    filtered_list_path = os.path.join(script_dir, 'filtered_list.json')
    upload_to_s3(cfDomain, filtered_list_path)
    download_from_s3(cfDomain)