# Destroy all existing records
Message.destroy_all
Chat.destroy_all
OrderItem.destroy_all
Order.destroy_all
User.destroy_all
PackageProduct.destroy_all
Product.destroy_all
Package.destroy_all
Rating.destroy_all

# CREATE USERS
# 1. king user (admin)
admin = User.create!(
  username: "The Duke",
  address: "admin@goldcloud.com",
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

test_users = 5.times.map do |i|
  User.create!(
    email: "user#{i}@example.com",
    password: "password",
    username: "User#{i}"
  )
end

# 3. Create some drivers
driver1 = User.create!(
  username: "Driver 1",
  address: "99 Madeup Corner, Faketown, 3378",
  email: "fake@driver.com",
  password: "password",
  password_confirmation: "password",
  role: 1
)

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
package_names = ["Duke Pack", "Sample Pack", "Mix Pack", "Bargain Pack", "Primo Pack"]

package_names.each do |package_name|
  products = Product.all.sample(3)
  package = Package.create!(
    name: package_name,
    description: "Contains the strains: #{products[0].name}, #{products[1].name}, and #{products[2].name}.",
    price: ((products.sum(&:price) * 0.8) / 10).floor * 10,
    available: products.all?(&:available)
  )

  products.each do |product|
    PackageProduct.create!(
      package: package,
      product: product,
      quantity: 1
    )
  end
end

puts "Created #{Package.count} packages."

# Simulate shopping history
puts "Creating order history"

test_users.each do |user|
  rand(1..3).times do
    order = Order.create!(
      user: user,
      status: :delivered,
      total_price: 0,
      address: "#{rand(1..100)} Test Street"
    )
  end
end

# Add some items to their order
products.sample(rand(1..2)).each do |product|
  OrderItem.create!(
    order: order,
    itemable: product,
    quantity: rand(1..3)
  )
end

# Finally, simulate users leaving ratings
puts "Creating ratings..."
Order.delivered.each do |order|
  # Each delivered order's items get a rating from that user
  order.order_items.each do |order_item|
    Rating.create!(
      user: order.user,
      item: order_item.itemable.item,
      score: rand(3..5),
      comment: ["Great product!", "Would buy again!", "Excellent!"].sample
    )
  end
end