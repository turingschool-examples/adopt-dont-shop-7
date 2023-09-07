# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

application = Application.create!(
  name: "John Smith",
  street_address: "1234 Lane Street",
  city: "Happy City", 
  state: "CO", 
  zip_code: "80111",
  owner_description: "I want an animal",
  status: "Pending"
)

application_2 = Application.create!(
  name: "Holly Adams",
  street_address: "2345 Apple Street",
  city: "Happy City",
  state: "CO",
  zip_code: "80111",
  owner_description: "I have fostered before",
  status: "In Progress"
)
shelter = Shelter.create!(
  foster_program: true,
  name: "The Shelter",
  city: "Happy City",
  rank: 1
)

shelter_2 = Shelter.create!(
  foster_program: false,
  name: "Friends Shelter",
  city: "Friends City",
  rank: 2
)

pet_1 = shelter.pets.create!(
  adoptable: true,
  age: 3,
  breed: "orange cat",
  name: "Cheesecake"
)

fluffy = shelter.pets.create!(
  adoptable: true,
  age: 3,
  breed: "white cat",
  name: "Fluffy"
)

fluff = shelter.pets.create!(
  adoptable: true,
  age: 4,
  breed: "whiter cat",
  name: "FLUFF"
)

mrfluff = shelter.pets.create!(
  adoptable: true,
  age: 5,
  breed: "whitest cat",
  name: "Mr.FlUfF"
)

barey = shelter_2.pets.create!(
  adoptable: true,
  age: 7,
  breed: "sphynx",
  name: "Bare-y Manilow",
)

babe = shelter_2.pets.create!(
  adoptable: true,
  age: 3,
  breed: "domestic pig",
  name: "Babe",
)

elle = shelter_2.pets.create!(
  adoptable: true,
  age: 4,
  breed: "chihuahua",
  name: "Elle",
)


ApplicationPet.create!(pet: pet_1, application: application)