# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Shelter.destroy_all
Pet.destroy_all
Application.destroy_all
PetApp.destroy_all
# Shelters
@puppy_hope = Shelter.create!(name: 'Puppy Hope', city: 'Palo Alto',foster_program: true, rank: 1 )
@the_farm = Shelter.create!(name: 'South Shannon Angus', city: 'Palo Alto',foster_program: true, rank: 1 )
@walrus_haven = Shelter.create!(name: "Cicero's Walrus Emporium", city: 'Palo Alto',foster_program: true, rank: 1 )
# Pets
@pet_1 = Pet.create!(name: 'Sparky', age: 4, breed: 'Chihuahua', adoptable: true, shelter_id: @puppy_hope.id )
@pet_2 = Pet.create!(name: 'Spot', age: 1, breed: 'Angus', adoptable: true, shelter_id: @puppy_hope.id )
@pet_3 = Pet.create!(name: 'Spotty', age: 10, breed: 'Walrus', adoptable: true, shelter_id: @puppy_hope.id )
# Applications 
@app_1 = Application.create!(name: 'Megan Samuels', street_address: '505 E. Happy Pl', city: "Austin", state: "MN", zip: "55912", description: 'I love dogs', status: 0)
# Pet Applications 
PetApp.create!(application_id: @app_1.id, pet_id: @pet_1.id)