# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# (1..10).each do |unit_num|
#   Unit.create(name: "Unit #{unit_num}")
# end


units = Unit.all
(1..100).each do |user_num|
  User.create(first_name: "First Name #{user_num}", last_name: "Last Name #{user_num}",
              email: "email_#{user_num}@domain.com", unit_id: units[user_num % units.size].id, is_available: true)
end