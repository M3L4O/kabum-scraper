require 'sqlite3'
require_relative '../app/model/product'

class ProductRepository
  def initialize
    @db = SQLite3::Database.new('db/products.sqlite3')

    @db.execute <<-SQL
        create table if not exists products (
            id VARCHAR(255) PRIMARY KEY,
            name VARCHAR(255),
            price FLOAT,
            link VARCHAR(255)
        );
    SQL
  end

  def add(product)
    @db.execute 'insert into products (id, name, price, link) values (?, ?, ?, ?)',
                [product.id, product.name, product.price, product.link]
  end

  def remove(product)
    @db.execute "delete from products where id = #{product.id}"
  end

  def update(product)
    @db.execute 'update products set name = ?, price = ?, link = ? where id = ?',
                [product.name, product.price, product.link, product.id]
  end

  def select_all
    @db.execute('select * from products').map do |id, name, price, link|
      Product.new(id, name, price, link)
    end
  end

  def select_by_id(product_id)
    @db.execute("select * from products where id = #{product_id}").map do |id, name, price, link|
      Product.new(id, name, price, link)
    end
  end

  def select_by_name(product_name)
    @db.execute("select * from products where name like '%#{product_name}%'").map do |id, name, price, link|
      Product.new(id, name, price, link)
    end
  end

  def filter_by_price(operator, value)
    @db.execute("select * from products where price #{operator} #{value}").map do |id, name, price, link|
      Product.new(id, name, price, link)
    end
  end
end
