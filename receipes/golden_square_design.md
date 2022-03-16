# SOLO PROJECT RECEIPE

## 1. Describe the problem

> As a customer
> So that I can check if I want to order something
> I would like to see a list of dishes with prices.

> As a customer
> So that I can order the meal I want
> I would like to be able to select some number of several available dishes.

> As a customer
> So that I can verify that my order is correct
> I would like to see an itemised receipt with a grand total.

WITH TWILIO

> As a customer
> So that I am reassured that my order will be delivered on time
> I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.

## 2. Design the class system

┌─────────────────────┐
│ class Dishes        │ 
│ ---------------     │
│ -add(dish)          │
│ -all_dishes         │
│ -some_dishes        │
│ -receipt            │
└────┬─────────────┬──┘
     │             │
     ▼             │
┌──────────────────┴──┐
│ class Dish          │
│ -------------       │
│ -name               │
│ -price              │
└─────────┬───────────┘

┌──────────────────┴──┐
│ class Receipt       │
│ ------------        │
│ -ordered_dishes     │
│ -total_price        │
└─────────┬───────────┘
          │
          ▼
 ┌────────────────────────────┐
 │ class Delivery             │
 │ ----------------           │
 │ -order_confirmation_text   │
 └────────────────────────────┘

 ```ruby
  
  class Dishes
    def initialize
      # initialise empty dishes array
      # initialise empty order array
    end

    def add_dish(dish)
      # adds a dish to dishes array
    end

    def all_dishes
      # returns dishes array
    end
  end

  class Receipt
    def initialize
      # initialise empty order array
    end

    def add_order(dish, quantity)
      # add dish to the order array
    end


    def receipt(tip)
      # uses format method
      # returns the items ordered and grand total
    end

    private

    def format
      # formats the receipt
    end
  end

  class Dish
    def initialize(name, price)
      # initialise with a dish
      # saves name and price
    end

    def name
      # returns name of dish
    end

    def price
      # returns price of dish
    end
  end

  class Delivery
    def initialize
      # order status initialised as false
    end

    def place_order
      # marks order status as true
      # does not return
    end

    def ordered?
      # returns true if order status == true
      # returns false if order status == false
    end

    def order_confirmation_text
      # if ordered? true
      # sends text after ordered is placed
      # e.g. "Thank you! Your order was placed and will be delivered before XX:XX"
      # if false: "No orders to be delivered"
    end
  end

 ```
## 3. Create examples as integration tests

```ruby

# 1. Can add dishes
new_order = Dishes.new
vegan_pizza = Dish.new("Vegan Pizza", 9.99)
veggie_pizza = Dish.new("Veggie Pizza", 10.99)
meat_pizza = Dish.new("Meat pizza", 11.99)
new_order.add_dish(vegan_pizza)
new_order.add_dish(veggie_pizza)
new_order.add_dish(meat_pizza)
new_order.all_dishes # => [vegan_pizza, veggie_pizza, meat_pizza]


# 2. Can generate receipt of a single ordered dish
new_order = Dishes.new
vegan_biryani = Dish.new("Vegan biryani", 10.99)
new_receipt = Receipt.new
new_receipt.add_order(vegan_biryani, 1)
new_receipt.receipt(0) # => 
# " You have ordered: 
# ----------------------
# x1 'Vegan biryani' at (in £) 10.99, 
# -------------------------------------
# Total cost (in £) incl. tip of 0%: 10.99"

# 4. Can generate receipt of multiple ordered dishes
vegan_biryani = Dish.new("Vegan biryani", 10.99)
veggie_biryani = Dish.new("Veggie biryani", 11.99)
meat_biryani = Dish.new("Meat biryani", 12.99)
new_receipt = Receipt.new
new_receipt.add_order(vegan_biryani, 2)
new_receipt.add_order(veggie_biryani, 1)
new_receipt.add_order(meat_biryani, 1)
new_receipt.receipt(20) # => 
# " You have ordered: 
# ----------------------
# x2 'Vegan biryani' at (in £) 10.99, 
# x1 'Veggie biryani' at (in £) 11.99,
# x1 'Meat biryani' at (in £) 12.99 
# -------------------------------------
# Total cost (in £) incl. tip of 20%: 56.35"

# 5. Fails if the tip is less than 0
vegan_biryani = Dish.new("Vegan biryani", 10.99)
new_receipt = Receipt.new
new_receipt.add_order(vegan_biryani, 1)
new_receipt.receipt(-10) # => Error: Tip has to 0% or greater

# 6. Generate an empty receipt message when no order is made
vegan_biryani = Dish.new("Vegan biryani", 10.99)
new_receipt = Receipt.new
new_receipt.receipt(10) # => "You have not ordered anything!"



```
## 4. Create examples as unit tests

```ruby

# Dishes
# 1. with no dishes added
available_dishes = Dishes.new
available_dishes.all_dishes # => []


# 2. Can add dishes 
new_order = Dishes.new
vegan_pizza = double :dish, name: "Vegan Pizza", price: 9.99
veggie_pizza = double :dish, name: "Veggie Pizza", price: 10.99
meat_pizza = double :dish, name: "Meat pizza", price: 11.99
new_order.add_dish(vegan_pizza)
new_order.add_dish(veggie_pizza)
new_order.add_dish(meat_pizza)
new_order.all_dishes # => [vegan_pizza, veggie_pizza, meat_pizza]



# Receipt
# 1. with no dishes added
vegan_biryani = double :dish, name: "Vegan biryani", price: 10.99
new_receipt = Receipt.new
new_receipt.receipt(10) # => "You have not ordered anything!"


# 2. with dishes added and tip
vegan_biryani = double :dish, name: "Vegan biryani", price: 10.99
new_receipt = Receipt.new
new_receipt.add_order(vegan_biryani, 1)
new_receipt.receipt(10) # =>
# " You have ordered: 
# ----------------------
# x1 'Vegan biryani' at (in £) 10.99, 
# -------------------------------------
# Total cost (in £) incl. tip of 10%: 12.09"


# 3. Fails if the tip is less than 0
vegan_biryani = double :dish, name: "Vegan biryani", price: 10.99
new_receipt = Receipt.new
new_receipt.add_order(vegan_biryani, 1)
new_receipt.receipt(-10) # => Error: Tip has to 0% or greater


# 4. with multiple quantities of an order
vegan_biryani = double :dish, name: "Vegan biryani", price: 10.99
meat_pizza = double :dish, name: "Meat pizza", price: 11.99
new_receipt = Receipt.new
new_receipt.add_order(vegan_biryani, 3)
new_receipt.add_order(meat_pizza, 2)
new_receipt.receipt(25) # =>
# " You have ordered: 
# -------------------------------------
# x3 'Vegan biryani' at (in £) 32.97, 
# x2 'Meat pizza'    at (in £) 23.98, 
# -------------------------------------
# Total cost (in £) incl. tip of 25%: 71.19"


# Dish
# 1. returns the name 
veggie_taco = Dish.new("Veggie taco", 8.99)
veggie_taco.name # => "Veggie taco"

# 2. returns the price
veggie_taco = Dish.new("Veggie taco", 8.99)
veggie_taco.price # => 8.99

# Delivery
# 1. confirms order status is true
delivery = Delivery.new
delivery.place_order 
delivery.ordered? # => true

# 2. order confirmation text - false
delivery = Delivery.new
delivery.place_order
delivery.order_confirmation_text # => "Thank you! Your order was placed and will be delivered before XX:XX"

# 3. confirms order status is false
delivery = Delivery.new
delivery.ordered? # => false

# 4. order confirmation text - false
delivery = Delivery.new
delivery.order_confirmation_text # => "No orders to be delivered"




```