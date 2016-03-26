class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |attribute|

      new_method = %Q{
        def self.find_by_#{attribute}(value)
          items = Udacidata.all

          return items.find {|item| item.#{attribute} == value} 
        end
      }
      self.class_eval(new_method)
      # note: you could leave out self, since self is implied
    end
  end
end
