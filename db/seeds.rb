# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
@shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

@pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
@pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true, shelter_id: @shelter_3.id)
@pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true, shelter_id: @shelter_2.id)
@pet_4 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true, shelter_id: @shelter_1.id)

@shaggy = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
@martin = Application.create!(name: "Martin", street_address: "134 Huski Lane", city: "Chicago", state: "Ilinois", zip_code: 60609, description: "I love dogs")
@odell = Application.create!(name: "Odell", street_address: "145 Dog Lane", city: "Denver", state: "CO", zip_code: 60655, description: "Hi!")

@pet_pirate = @shaggy.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false, shelter_id: @shelter_2.id)
@pet_clawdia = @martin.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true, shelter_id: @shelter_3.id)
@pet_lucille = @odell.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true, shelter_id: @shelter_2.id)
@pet_ann = Pet.create!(name: "Ann", breed: "ragdoll", age: 5, adoptable: true, shelter_id: @shelter_1.id)