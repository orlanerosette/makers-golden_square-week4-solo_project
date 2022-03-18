require 'dishes'

RSpec.describe Dishes do
  it "returns an empty array when no dishes are added" do
    available_dishes = Dishes.new
    expect(available_dishes.all).to eq []
  end
  
  it "can add dishes" do
    new_order = Dishes.new
    vegan_pizza = double :dish, name: "Vegan Pizza", price: 9.99
    veggie_pizza = double :dish, name: "Veggie Pizza", price: 10.99
    meat_pizza = double :dish, name: "Meat pizza", price: 11.99
    new_order.add(vegan_pizza)
    new_order.add(veggie_pizza)
    new_order.add(meat_pizza)
    expect(new_order.all).to eq [vegan_pizza, veggie_pizza, meat_pizza]
  end
end