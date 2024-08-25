# Destroy all existing records
OrderItem.destroy_all
Order.destroy_all
User.destroy_all
Product.destroy_all
Package.destroy_all

# USERS
# 1. Create a king user (admin)
duke = User.create!(
  username: "The Duke",
  address: "123 Fake Street, Faketown, 1234",
  email: "test@test.com",
  password: "password",
  password_confirmation: "password",
  role: 0,
)

# 2. create some customers
stricko = User.create!(
  username: "Stricko",
  address: "456 False Road, Faketown, 5678",
  email: "fake@fake.com",
  password: "password",
  password_confirmation: "password",
  role: 2
)

# 3. Create some drivers
jeeves = User.create!(
  username: "Jeeves",
  address: "99 Madeup Corner, Faketown, 3378",
  email: "fake@driver.com",
  password: "password",
  password_confirmation: "password",
  role: 1
)

counter = 0

5.times do
  counter += 1
  User.create!(
    username: "User#{counter}",
    address: "#{counter} Fake Street, Faketown, #{counter}",
    email: "testuser#{counter}@mail.com",
    password: "password",
    password_confirmation: "password",
    role: 2
  )
end

# PRODUCTS
# 1. Create some products
product_names = [
  "White Widow", "OG Kush", "Sour Diesel", "Purple Haze", "Blue Dream",
  "Pineapple Express", "Gorilla Glue", "Girl Scout Cookies", "Lemon Haze", "AK-47",
  "Granddaddy Purple", "Amnesia Haze", "Northern Lights", "Bubble Gum", "Green Crack",
  "Jack Herer", "Trainwreck", "Durban Poison", "Maui Wowie", "Chemdawg"
]

# Description template
description_template = "This strain is a hybrid made from a genetic cross between a Brazilian
                        sativa landrace and a resin-heavy South Indian indica. It is known for
                        its potent effects, crystal resin, and unique flavors. Customers report
                        feeling energetic, talkative, and creative. This strain is often chosen
                        by medical marijuana patients for its ability to relieve symptoms associated
                        with stress, anxiety, and pain. The dominant terpenes are myrcene and caryophyllene.
                        It has a flowering time of 8-9 weeks and can be grown indoors
                        or outdoors in mild climates. The average price typically ranges from R120-R180 per gram."

# Seed 20 products
product_names.each do |product_name|
  Product.create!(
    name: product_name,
    description: description_template,
    price: rand(10..20) * 10,
    available: true
  )
end

puts "Created #{Product.count} products and #{User.count} users."

# PACKAGES
# 1. Create some packages
package_names = ["Package 1", "Package 2", "Package 3", "Package 4", "Package 5"]

package_names.each do |package_name|
  products = Product.all.sample(3)
  Package.create!(
    name: package_name,
    description: "Contains the strains: #{products[0].name}, #{products[1].name}, and #{products[2].name}.",
    price: products.sum(&:price) * 0.8,
    available: if products.all?(&:available) then true else false end
  )
end

puts "Created #{Package.count} packages."

stricko_order = Order.create!(
  user_id: stricko.id,
  status: 0
)

stricko_order.order_items.create!(
  product_id: Product.all.sample.id,
  order_id: stricko_order.id,
  quantity: 2
)

stricko_order.order_items.create!(
  package_id: Package.all.sample.id,
  order_id: stricko_order.id,
  quantity: 1
)

puts "Created #{Order.count} order(s)."
