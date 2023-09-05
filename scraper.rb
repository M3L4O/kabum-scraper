require 'nokogiri'
require 'open-uri'

require_relative 'app/model/product'
require_relative 'repository/product_repository'

base_url = 'https://www.kabum.com.br'
processors_url = '/hardware/processadores?page_number=%d&page_size=100'

initial_page = base_url + (processors_url % 1)
doc = Nokogiri::HTML(URI.open(initial_page))
last_page = doc.css('.page')[-1].content.to_i
i = 1

repository = ProductRepository.new

while i <= last_page
  if i != 1
    page = base_url + (processors_url % i)
    doc = Nokogiri::HTML(URI.open(page))
  end
  (doc.css('.nameCard').zip(doc.css('.priceCard'), doc.css('.productLink')).map do |name, price, link|
    repository.add(Product.new(nil, name.content, price.text, base_url + link['href']))
  end)
  i += 1
end

repository.select_all.each do |product|
  p product
end
