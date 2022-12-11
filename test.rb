require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'

URL = 'https://www.moyo.ua/ua/comp-and-periphery/notebooks/'
HTML = URI.open(URL)
DOC = Nokogiri::HTML(HTML)



parse_list=DOC.css("#main-wrap > main > div > div.catalog.seo-order > div.catalog_body > div.catalog_content > div.catalog_products.js-products-list")
.css(".product-item").slice(0,10)

output_json=[]
output_csv=[['id','name','price','brand','status']]

parse_list.each do |e| 
    id = e['data-id'].to_i
    name = e['data-name']
    price = e['data-price'].to_i
    brand = e['data-brand']
    status = e['data-status-product']
    output_json.push(
        id:id,
        name:name,
        price:price,
        brand:brand,
        status:status,
    )
    output_csv.push([
        id,name,price,brand,status,
    ])
end

File.write('laptops.csv',output_csv.map(&:to_csv).join)
File.write('laptops.json',JSON.dump(output_json))