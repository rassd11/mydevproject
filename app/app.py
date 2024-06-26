import requests
import json
import os
import subprocess
import argparse


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


def upload_to_s3(cfDomain, filtered_list_path, s3_url):
    try:
        subprocess.run(f"curl -X PUT -T {filtered_list_path} {s3_url}", shell=True, check=True)
        print("File successfully uploaded.")
    except subprocess.CalledProcessError as e:
        print(f"Error uploading file: {e}")

def download_from_s3(cfDomain, s3_url):
    download_url = s3_url + '/filtered_list.json'
    try:
        subprocess.run(f"curl -o downloaded_filtered_list.json {download_url}", shell=True, check=True)
        print("File successfully downloaded.")
    except subprocess.CalledProcessError as e:
        print(f"Error downloading file: {e}")

def validateJSON(jsonData):
    try:
        json.loads(jsonData)
    except ValueError:
        return False
    return True

if __name__ == "__main__":
    abspath = os.path.abspath(__file__)
    dname = os.path.dirname(abspath)
    os.chdir(dname)
    script_dir = os.path.dirname(os.path.abspath(__file__))

    parser = argparse.ArgumentParser(description="json processing app that works with s3")
    parser.add_argument("--cfDomain", help="CloudFront domain output by Terragrunt")
    args = parser.parse_args()

    if args.cfDomain is None:
        print("CloudFront domain is not provided!")
        exit(1)

    cfDomain = args.cfDomain  # Assigning value to cfDomain from command line argument
    cfDomain = os.getenv("TERRAGRUNT_OUTPUT")
    s3_url = 'http://' + cfDomain

    write_output(URL)
    filter_objects(filtered_products)
    filtered_list_path = os.path.join(script_dir, 'filtered_list.json')
    upload_to_s3(cfDomain, filtered_list_path, s3_url)
    download_from_s3(cfDomain, s3_url)


    with open("downloaded_filtered_list.json", 'r') as test:
        json_data = test.read()
        if validateJSON(json_data):
            print("JSON is valid.")
        else:
            print("JSON is not valid.")
