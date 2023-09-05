require 'securerandom'

class Product
  attr_reader :name, :price, :id, :link

  def initialize(name, price, link)
    @id = SecureRandom.uuid
    @name = name.split(',')[0]
    @price = price.delete('.').sub(',', '.').delete('^0-9.').to_f
    @link = link
  end
end
