class Discount

  def initialize(value, quantity)
    @value = value
    @quantity = quantity
  end

  def calculate_for(quantity)
    (quantity / @quantity).floor * @value
  end

end

class PricePolicy

  def initialize(starts_at, if_discount, discount)
    @starts_at = starts_at
    @if_discount = if_discount

    if @if_discount
      @discount = discount
    end
  
  end

  def price_for(quantity)
    if @if_discount == false
      return quantity * @starts_at
    end

    return quantity * @starts_at - @discount.calculate_for(quantity)
  end

end

RULES = {
  'A' => PricePolicy.new(50, true, Discount.new(20, 3)),
  'B' => PricePolicy.new(30, true, Discount.new(15, 2)),
  'C' => PricePolicy.new(20, false, nil),
  'D' => PricePolicy.new(15, false, nil),
}

class CheckOut

    def initialize(rules)
      # Rules is a hash like object
      @rules = rules
      @items = {}
      # assign all the rules
      assign_rules()
    end


    def scan(item)
      if (@items.include?(item))
        @items[item] += 1
      else 
        @items[item] = 1
      end
    end


    def total()
      total_price = 0

      for (item, quantity) in @items
        total_price += get_price(item, quantity)
      end

      return total_price
    end 


    def get_price(item, quantity)
      return @rules[item].price_for(quantity)
    end


    def assign_rules()
      for item in @rules
        @rules[item]
      end 
    end
end


