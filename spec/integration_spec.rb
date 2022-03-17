require 'dishes'
require 'dish'
require 'receipt'

RSpec.describe "integration" do
  it "can add dishes" do
    vegan_pizza = Dish.new("Vegan Pizza", 9.99)
    new_order = Dishes.new
    veggie_pizza = Dish.new("Veggie Pizza", 10.99)
    meat_pizza = Dish.new("Meat pizza", 11.99)
    new_order.add(vegan_pizza)
    new_order.add(veggie_pizza)
    new_order.add(meat_pizza)
    expect(new_order.all).to eq [vegan_pizza, veggie_pizza, meat_pizza]
  end

  it "can generate a receipt, when a single dish is ordered" do
    vegan_biryani = Dish.new("Vegan biryani", 10.99)
    new_receipt = Receipt.new
    new_receipt.add_order(vegan_biryani, 1)
    expect(new_receipt.receipt(0)).to eq "You have ordered: x1 'Vegan biryani' at (in £) 10.99 each, Total cost (in £) incl. tip of 0%: 10.99"
  end

  it "can generate a receipt, when multiple dishes are ordered" do
    vegan_biryani = Dish.new("Vegan biryani", 10.99)
    veggie_biryani = Dish.new("Veggie biryani", 11.99)
    meat_biryani = Dish.new("Meat biryani", 12.99)
    new_receipt = Receipt.new
    new_receipt.add_order(vegan_biryani, 2)
    new_receipt.add_order(veggie_biryani, 1)
    new_receipt.add_order(meat_biryani, 1)
    expect(new_receipt.receipt(20)).to eq "You have ordered: x2 'Vegan biryani' at (in £) 10.99 each, x1 'Veggie biryani' at (in £) 11.99 each, x1 'Meat biryani' at (in £) 12.99 each, Total cost (in £) incl. tip of 20%: 56.35"
  end

  it "fails if the tip is less than 0" do
    vegan_biryani = Dish.new("Vegan biryani", 10.99)
    new_receipt = Receipt.new
    new_receipt.add_order(vegan_biryani, 1)
    expect {new_receipt.receipt(-10)}.to raise_error "Error: Tip has to 0% or greater"
  end

  it "generates an empty receipt message when no order is made" do
    vegan_biryani = Dish.new("Vegan biryani", 10.99)
    new_receipt = Receipt.new
    expect(new_receipt.receipt(10)).to eq "You have not ordered anything!"
  end
end