import requests
import json

URL = "https://dummyjson.com/products"
filtered_products = []

r = requests.get(URL)
j = r.json()
data = json.dumps(j)
with open('original_file.json', 'w') as original_file:
    original_file.write(data)


with open("original_file.json","r") as file:
          newfile = json.load(file)
          products = newfile['products']
          for product in products:
                  price = product.get('price')
                  if price >= 100:
                          filtered_products.append(product)

with open('filtered_list.json', 'w') as filtered_list:
    json.dump(filtered_products, filtered_list)



#3. upload to S3 bucket
#4. download the json via cloudfront and print if the json exist or not
