require 'receipt'

RSpec.describe Receipt do
  it "can check order" do
    vegan_biryani = double :dish, name: "Vegan biryani", price: 10.99
    new_receipt = Receipt.new
    new_receipt.add_order(vegan_biryani, 1)
    expect(new_receipt.check_order).to eq "x1 Vegan biryani"
  end

  it "can generate a receipt, when a single dish is ordered" do
    vegan_biryani = double :dish, name: "Vegan biryani", price: 10.99
    new_receipt = Receipt.new
    new_receipt.add_order(vegan_biryani, 1)
    expect(new_receipt.receipt(0)).to eq "You have ordered: x1 'Vegan biryani' at (in £) 10.99 each, Total cost (in £) incl. tip of 0%: 10.99"
  end

  it "can generate a receipt, when a single dish is ordered" do
    vegan_biryani = double :dish, name: "Vegan biryani", price: 10.99
    new_receipt = Receipt.new
    new_receipt.add_order(vegan_biryani, 1)
    expect(new_receipt.receipt(10)).to eq "You have ordered: x1 'Vegan biryani' at (in £) 10.99 each, Total cost (in £) incl. tip of 10%: 12.09"
  end
  
  it "can generate a receipt, when multiple dishes are ordered" do
    vegan_biryani = double :dish, name: "Vegan biryani", price: 10.99
    veggie_biryani = double :dish, name: "Veggie biryani", price: 11.99
    meat_biryani = double :dish, name: "Meat biryani", price: 12.99
    new_receipt = Receipt.new
    new_receipt.add_order(vegan_biryani, 2)
    new_receipt.add_order(veggie_biryani, 1)
    new_receipt.add_order(meat_biryani, 1)
    expect(new_receipt.receipt(20)).to eq "You have ordered: x2 'Vegan biryani' at (in £) 10.99 each, x1 'Veggie biryani' at (in £) 11.99 each, x1 'Meat biryani' at (in £) 12.99 each, Total cost (in £) incl. tip of 20%: 56.35"
  end

  it "can generate a receipt, when multiple dishes are ordered" do
    vegan_biryani = double :dish, name: "Vegan biryani", price: 10.99
    meat_pizza = double :dish, name: "Meat pizza", price: 11.99
    new_receipt = Receipt.new
    new_receipt.add_order(vegan_biryani, 3)
    new_receipt.add_order(meat_pizza, 2)
    expect(new_receipt.receipt(25)).to eq "You have ordered: x3 'Vegan biryani' at (in £) 10.99 each, x2 'Meat pizza' at (in £) 11.99 each, Total cost (in £) incl. tip of 25%: 71.19"
  end

  it "fails if the tip is less than 0" do
    vegan_biryani = double :dish, name: "Vegan biryani", price: 10.99
    new_receipt = Receipt.new
    new_receipt.add_order(vegan_biryani, 1)
    expect {new_receipt.receipt(-10)}.to raise_error "Error: Tip has to 0% or greater"
  end

  it "generates an empty receipt message when no order is made" do
    vegan_biryani = double :dish, name: "Vegan biryani", price: 10.99
    new_receipt = Receipt.new
    expect(new_receipt.receipt(10)).to eq "You have not ordered anything!"
  end
end