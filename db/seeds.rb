# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create an admin user with 'organizer' role
User.create!(
  email: 'admin@test.com',
  password: 'admin@123',
  password_confirmation: 'admin@123',
  role: :organizer
)

# Create a regular user with 'customer' role
User.create!(
  email: 'user@test.com',
  password: 'user@123',
  password_confirmation: 'user@123',
  role: :customer
)

puts "Users created successfully!"
