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

    item = items.find {|item| item.id == id}

    if item
      return item
    else
      raise ToyCityErrors::ProductNotFound, "No product with that id found."
    end
  end

  def self.destroy(id)
    deleted = Udacidata.find(id)

    unless deleted 
      raise ToyCityErrors::ProductNotFound, "No product with that id found."
    end 
    
    table = CSV.table(@@data_path)

    table.delete_if do |row|
      row[:id] == id
    end

    File.open(@@data_path, 'wb') do |f|
      f.write(table.to_csv)
    end

    return deleted
  end

  def self.where(hash = {})
    h = hash.first

    attribute = h[0]
    value = h[1]

    items = Udacidata.all

    return items.find_all {|item| item.send(attribute) == value}
  end

  def update(attributes = {})
    table = CSV.table(@@data_path)

    table.each do |row|
      if row[:id] == self.id
        attributes.each do |k, v|
          row[k] = v
        end    
      end
    end
    
    File.open(@@data_path, 'wb') do |f|
      f.write(table.to_csv)
    end

    return Udacidata.find(self.id)
  end
end
