# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
aurora = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
rgv = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
fancy = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

pirate = aurora.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
clawdia = aurora.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
lucille = fancy.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
ann = rgv.pets.create!(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

shaggy = Application.create!(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
martin = Application.create!(name: "Martin", street_address: "134 Huski Lane", city: "Chicago", state: "Ilinois", zip_code: 60609, description: "I love dogs")
odell = Application.create!(name: "Odell", street_address: "145 Dog Lane", city: "Denver", state: "CO", zip_code: 60655, description: "Hi!")

shaggy_pet = ApplicationPet.create!(pet_id: pirate.id, application_id: shaggy.id)
martin_pet = ApplicationPet.create!(pet_id: clawdia.id, application_id: martin.id)
odell_pet1 = ApplicationPet.create!(pet_id: lucille.id, application_id: odell.id)
odell_pet2 = ApplicationPet.create!(pet_id: ann.id, application_id: odell.id)