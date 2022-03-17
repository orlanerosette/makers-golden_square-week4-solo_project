class Receipt
  def initialize
    @order = Hash.new
    @total_cost_no_tip = 0.0
  end

  def add_order(dish, quantity)
    @order[dish] = quantity
  end

  def receipt(tip)
    fail "Error: Tip has to 0% or greater" if tip < 0
    return "You have not ordered anything!" if @order.empty?
    total_cost
    @total_cost = @total_cost_no_tip * (1+ (tip/100.0))
    receipt_format(tip)
  end

  def check_order
    current_order = ""
    @order.each do |dish, quantity|
      current_order += "x#{quantity} #{dish.name}"
    end
    return current_order
  end

  private

  def total_cost
    @order.each do |dish, quantity|
      @total_cost_no_tip += (dish.price * quantity)
    end
  end

  def receipt_format(tip)
    message1 = "You have ordered:"
    message2 = ""
    @order.each do |dish, quantity|
      message2 += " x#{quantity} '#{dish.name}' at (in £) #{dish.price} each,"
    end
    message3 = " Total cost (in £) incl. tip of #{tip}%: #{@total_cost.round(2)}"
    return message1 + message2 + message3
  end

end

