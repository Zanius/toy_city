module Analyzable
  def average_price(items)
    sum = items.reduce(0) {|sum, item| sum += item.price.to_f}
    (sum / items.length).round(2)
  end

  def print_report(items)
    return "string"
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
