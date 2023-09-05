# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

happy = Shelter.create!({
  name: "Happy Cats and Dogs",
  foster_program: true,
  city: "Boulder",
  rank: 12
})

butler = happy.pets.create!({
  name: "Butler",
  adoptable: true,
  age: 9,
  breed: "Labradoodle"
})

porter = happy.pets.create!({
  name: "Porter",
  adoptable: false,
  age: 1,
  breed: "Pit Mix"
})

juniper = happy.pets.create!({
  name: "Juniper",
  adoptable: true,
  age: 3,
  breed: "American Shorthair"
})

tonic = happy.pets.create!({
  name: "Tonic",
  adoptable: true,
  age: 3,
  breed: "American Shorthair"
})

jericho = happy.pets.create!({
  name: "Jericho",
  adoptable: false,
  age: 5,
  breed: "Turtle"
})

billy = Application.create!({
  name: "Billy the Kid",
  street_address: "123 ABC St",
  city: "Boulder",
  state: "CO",
  zip_code: "12345",
  reason_for_adoption: "Bank robbing alert dog",
  status: "In Progress"
})

peggy = Application.create!({
  name: "Peggy Sue",
  street_address: "456 Main St",
  city: "Longmont",
  state: "CO",
  zip_code: "34567",
  reason_for_adoption: "I'm a lonely old lady",
  status: "In Progress"
})

balthazar = Application.create!({
  name: "Balthazar",
  street_address: "666 Demon Blvd",
  city: "Greely",
  state: "CO",
  zip_code: "66666",
  reason_for_adoption: "I've always wanted a turtle",
  status: "In Progress"
})


