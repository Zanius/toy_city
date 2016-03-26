require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  create_finder_methods("brand", "name")
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  def self.create(attributes = nil)
    product = Product.new(attributes)

  # If the object's data is not in the database
  # create the object
  # save the data in the database
  # return the object

    CSV.open(@@data_path, "ab") do |csv|
      csv << [product.id, product.brand, product.name, product.price]
      #csv << ['a', 'b', 'c', 'd']
    end

    product
  end 

  def self.all
    products_csv = CSV.read(@@data_path, :headers => true)
    products = []

    products_csv.each do |product|
      #p product
      atts = product.to_hash
      product_hash = {id: atts["id"].to_i, brand: atts["brand"],
        name: atts["product"], price: atts["price"]}


      products << Product.new(product_hash)
    end
    products
  end

  def self.first(n=1)
    if n == 1
      Udacidata.all.first
    else
      Udacidata.all.first(n)
    end
  end

  def self.last(n=1)
    if n == 1
      Udacidata.all.last
    else
      Udacidata.all.last(n)
    end
  end

  def self.find(id)
    items = Udacidata.all

    return items.find {|item| item.id == id}
  end

  def self.destroy(id)
    deleted = Udacidata.find(id)

    table = CSV.table(@@data_path)

    table.delete_if do |row|
      row[:id] == id
    end

    File.open(@@data_path, 'wb') do |f|
      f.write(table.to_csv)
    end

    return deleted
  end

  # def self.find_by_brand(brand)
  #   items = Udacidata.all

  #   return items.find {|item| item.brand == brand}
  # end

  # def self.find_by_name(name)
  #   items = Udacidata.all

  #   return items.find {|item| item.name == name}
  # end

end
