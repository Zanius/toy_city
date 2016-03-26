require 'faker'

# This file contains code that populates the database with
# fake data for testing purposes



def db_seed
  product_names = []
  brands = []
  10.times do
    product_names << Faker::Commerce.product_name
    brands << Faker::Commerce.department
  end



  prices = ["2.01", "14.51", "2.11", "99.99", "19.99"] 

  10.times do
    # you will write the "create" method as part of your project
    Product.create( brand: brands.sample, 
                    name: product_names.sample, 
                    price: prices.sample )
  end
end
