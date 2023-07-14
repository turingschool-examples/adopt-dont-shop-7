# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Shelter.destroy_all
Pet.destroy_all
VeterinaryOffice.destroy_all
Veterinarian.destroy_all
AdoptionApp.destroy_all

@shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

@pet_1 = @shelter_1.pets.create(name: "Wilmur", breed: "tuxedo shorthair", age: 5, adoptable: false)
@pet_2 = @shelter_1.pets.create(name: "Pillbus", breed: "shorthair", age: 3, adoptable: true)
@pet_3 = @shelter_3.pets.create(name: "Limb", breed: "sphynx", age: 8, adoptable: true)
@pet_4 = @shelter_1.pets.create(name: "Toulouse", breed: "ragdoll", age: 5, adoptable: true)

@vet_office_1 = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
@vet_office_2 = VeterinaryOffice.create(name: 'Vets R Us', boarding_services: true, max_patient_capacity: 20)

@not_on_call_vet = Veterinarian.create(name: 'Sam', review_rating: 10, on_call: false, veterinary_office_id: @vet_office_1.id)
@vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: @vet_office_1.id)
@vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: @vet_office_1.id)
@vet_3 = Veterinarian.create(name: 'Sarah', review_rating: 9, on_call: true, veterinary_office_id: @vet_office_2.id)

@adoption_app_1 = AdoptionApp.create!(name: "Suzie", street_address: "1234 Elmo Road", city: "Hoboken", state: "New Jersey", zip_code: "85790", description: "I will spoil all the pets", pet_names: "Wilmur", status: "Pending")
@adoption_app_2 = AdoptionApp.create!(name: "Fred", street_address: "4567 Grover Ave", city: "Tillamook", state: "Montana", zip_code: "45627", description: "I eat cats and honestly I am a terrible person", pet_names: "Pillbus", status: "Rejected")
@adoption_app_3 = AdoptionApp.create!(name: "Liam", street_address: "8910 Oscar Blvd", city: "Denver", state: "Colorado", zip_code: "80211", description: "Animals are awesome, adopt DONT shop!", pet_names: "Limb, Toulouse", status: "Approved")
