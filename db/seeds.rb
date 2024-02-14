# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Pet.destroy_all
Veterinarian.destroy_all
Shelter.destroy_all
Application.destroy_all
ApplicationPet.destroy_all

application = Application.create!(name: "Test Name", street_address: "Test address", city: "Nowhereville", state: "Colorado", zip_code: "00000", endorsement: "I am the best pet owner")

shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

pet_1 = shelter_1.pets.create!(adoptable: true, age: 4, breed: "chihuahua", name: "Elle")
pet_2 = shelter_1.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster")
