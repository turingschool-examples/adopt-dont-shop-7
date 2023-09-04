# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Applicant.destroy_all
Pet.destroy_all
Shelter.destroy_all

bob = Applicant.create!(name: "Bob", street_address: "1234 Bob's Street", city: "Fudgeville", state: "AK", zip_code: 27772, description: "", application_status: "In Progress")

shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

lucille_bald = shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
lobster = shelter.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
rex = shelter.pets.create!(adoptable: true, age: 2, breed: "Dog", name: "Rex" )
floof = shelter.pets.create!(adoptable: true, age: 3, breed: "English Bulldog", name: "Floof")
fluffy = shelter.pets.create!(adoptable: true, age: 4, breed: "Three-Headed Dog", name: "FlUfFy")
fluff = shelter.pets.create!(adoptable: true, age: 5, breed: "Pomeranian", name: "FLUFF")
mr_fluff = shelter.pets.create!(adoptable: true, age: 3, breed: "Great Dane", name: "Mr. FluFF")