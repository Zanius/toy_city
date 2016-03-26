module Analyzable
  def average_price(items)
    sum = items.reduce(0) {|sum, item| sum += item.price.to_f}
    (sum / items.length).round(2)
  end

  def print_report(items)
    avg_price = average_price(items)
    brands = count_by_brand(items)
    names = count_by_name(items)

    puts "Average Price: #{avg_price}"
    puts "Inventory by Brand:"
    brands.each do |k,v|
      puts "  - #{k}: #{v}"
    end

    puts "Inventory by Name:" 
    names.each do |k,v|
      puts "  - #{k}: #{v}"
    end
  end

  def count_by_brand(items)
    hash = items.group_by {|i| i.brand}

    new_hash = {}

    hash.each do |k,v|
      new_hash[k] = v.length
    end

    new_hash
  end

  def count_by_name(items)
    hash = items.group_by {|i| i.name}

    new_hash = {}

    hash.each do |k,v|
      new_hash[k] = v.length
    end

    new_hash
  end
end
