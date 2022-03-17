require 'dish'

RSpec.describe Dish do
  it "constructs" do
    veggie_taco = Dish.new("Veggie taco", 8.99)
    expect(veggie_taco.name).to eq "Veggie taco"
    expect(veggie_taco.price).to eq 8.99
  end

end