# TO DO
# USERS
# 1. Create a king user
# 2. create some customers
# 3. Create some drivers
#
# PRODUCTS
# 1. Create some products
# 2. Create some packages
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

puts "Created #{Product.count} products"
