# {Model}.destroy_all
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
      shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      shelter = Shelter.create(name: "Whosville House", city: "Eureka CA", foster_program: false, rank: 11)
      scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      scooby = Pet.create(name: "Scooby", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
      application_1 = Application.create!(name: "Corey Chavez", street_address: "123 Happy Ln", city: "Eugene", state: "OR", zipcode: "12735", description: "Friendly", status: "In Progress")
      application_2 = Application.create!(name: "Borey Chavez", street_address: "1234 Happy Ln", city: "Parker", state: "CO", zipcode: "82735", description: "Nice", status: "Pending")