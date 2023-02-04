# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

unless Product.exists?
  5.times do|i|
    product = Product.new(
        title: "test_item#{i}",
        info: "test_item#{i} information: I am a very simple Item. I am good at containing small bits of information. I am convenient because I require little markup to use effectively.",
        value: 1000,
        img_path: "dummy#{i}.jpg"
    )
    product.save!
  end
end

#Create admin_user, show "admin/*"
unless User.exists?
  user = User.new(
      email: "admin@example.com",
      password: "adminadmin",
      role: "admin"
  )
  user.save!

  #Create user,
  user = User.new(
      email: "user@example.com",
      password: "useruser",
  )
  user.save!
end
