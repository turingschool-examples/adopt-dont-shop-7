# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all
Application.destroy_all
ApplicationPet.destroy_all


shelter_1 = Shelter.create!(foster_program: true, name:"Soul Dog Rescue", city:"Ft Lupton", rank:1)
pet_1 = shelter_1.pets.create!(adoptable: true, age: 2, breed: "shepherd", name: "Frank")
pet_2 = shelter_1.pets.create!(adoptable: false, age: 7, breed: "lab", name: "Rex")
pet_3 = shelter_1.pets.create!(adoptable: true, age: 1, breed: "bulldog", name: "Daisy")

# :application_1) = Application.create!(name: "John Smith", street_address: "123 Elm", city: "Denver", state: "CO", zip_code: 80205, description: "Responsible pet owner, fenced yard", status: "pending"  )}

app_1 = Application.create!(name: "Max Power", street_address: "456 Main St", city: "Broomfield", state: "CO", zip_code: 80211, description: "Love animals", status: "in progress") 
app_2 = Application.create!(name: "Jane Doe", street_address: "444 8th St", city: "Wheatridge", state: "CO", zip_code: 80231, description: "Outdoorsy, responsible", status: "accepted") 
app_3 = Application.create!(name: "Clark Kent", street_address: "93428 Washington Ave", city: "Arvada", state: "CO", zip_code: 80411, description: "Family loves animals", status: "pending") 



application_pets_1 = ApplicationPet.create!(application_id: app_1.id, pet_id: pet_1.id) 