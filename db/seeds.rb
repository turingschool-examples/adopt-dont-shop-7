# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
@shel_1 = Shelter.create(name: "C. Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
@shel_2 = Shelter.create(name: "B. RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
@shel_3 = Shelter.create(name: "A. Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
@pet_1 = @shel_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
@pet_2 = @shel_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
@pet_3 = @shel_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)

@app_1 = Application.create!(name: "Jack", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 0)
@app_2 = Application.create!(name: "Jim", street_address: "123", city: "Det", state: "MI", zip: "12345", description: "I love dogs", status: 1)

PetApp.create!(application_id: @app_1.id, pet_id: @pet_1.id)
PetApp.create!(application_id: @app_1.id, pet_id: @pet_2.id)
PetApp.create!(application_id: @app_1.id, pet_id: @pet_3.id)
PetApp.create!(application_id: @app_2.id, pet_id: @pet_1.id)
PetApp.create!(application_id: @app_2.id, pet_id: @pet_2.id)
PetApp.create!(application_id: @app_2.id, pet_id: @pet_3.id)
