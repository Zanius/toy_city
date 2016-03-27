module Analyzable
  def average_price(items)
    sum = items.reduce(0) {|sum, item| sum += item.price.to_f}
    (sum / items.length).round(2)
  end

  def print_report(items)
    avg_price = average_price(items)
    brands = count_by_brand(items)
    names = count_by_name(items)

    string = ""

    string += "Average Price: #{avg_price}\n"
    string += "Inventory by Brand:\n"
    brands.each do |k,v|
      string += "  - #{k}: #{v}\n"
    end

    string += "Inventory by Name:\n" 
    names.each do |k,v|
      string += "  - #{k}: #{v}\n"
    end

    return string
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
