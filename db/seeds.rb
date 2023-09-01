# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

shelter = Shelter.create!(
  foster_program: true,
  name: "The Shelter",
  city: "Happy City",
  rank: 1
)

pet_1 = shelter.pets.create!(
  adoptable: true,
  age: 3,
  breed: "orange cat",
  name: "Cheesecake"
)

application = Application.create!(
  name: "John Smith",
  address: "1234 Lane Street, Happy City, CO, 80111",
  description: "I want an animal",
  pets: [pet_1],
  status: "Accepted"
)