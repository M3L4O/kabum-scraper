require 'securerandom'

class Product
  attr_reader :name, :price, :id, :link

  def initialize(id, name, price, link)
    if id.nil?
      initialize_new_product(name, price, link)
    else
      initialize_existing_product(id, name, price, link)
    end
  end

  private

  def initialize_new_product(name, price, link)
    @id = SecureRandom.uuid
    @name = name.split(',')[0]
    @price = price.delete('.').sub(',', '.').delete('^0-9.').to_f
    @link = link
  end

  def initialize_existing_product(id, name, price, link)
    @id = id
    @name = name
    @price = price
    @link = link
  end
end
