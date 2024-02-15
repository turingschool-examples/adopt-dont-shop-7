# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ApplicationPet.destroy_all
Shelter.destroy_all
VeterinaryOffice.destroy_all
Pet.destroy_all
Veterinarian.destroy_all
Application.destroy_all

shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: "Adopters Unite", city: "Minneapolis", foster_program: true, rank: 1 )

vet_office_1 = VeterinaryOffice.create!(name: "Best Vets", boarding_services: true, max_patient_capacity: 20)
vet_office_2 = VeterinaryOffice.create!(name: "Vets R Us", boarding_services: true, max_patient_capacity: 20)

vet_1 = vet_office_1.veterinarians.create!(name: "Taylor", review_rating: 10, on_call: true)
vet_2 = vet_office_2.veterinarians.create!(name: "Jim", review_rating: 8, on_call: true)

pet_1 = shelter_1.pets.create!(adoptable: true, age: 3, breed: "Doberman", name: "Rover")
pet_2 = shelter_2.pets.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Pongo")
pet_3 = shelter_1.pets.create!(adoptable: true, age: 9, breed: "American short hair cat", name: "Tom")
pet_4 = shelter_2.pets.create!(adoptable: true, age: 1, breed: "American short hair cat", name: "Nibble")
pet_5 = shelter_1.pets.create!(adoptable: true, age: 7, breed: "Orange tabby cat", name: "Jerry")
pet_6 = shelter_2.pets.create!(adoptable: true, age: 5, breed: "Golden Retriever", name: "Spike")

application_1 = Application.create!(name: "Sally", street_address: "112 W 9th St.", city: "Kansas City", state: "MO", zip_code: "64105", description: "I love animals. Please let me have one.", status: "pending")
application_2 = Application.create!(name: "Marcus", street_address: "100 Hennepin Ave.", city: "Minneapolis", state: "MN", zip_code: "55401", description: "Dogs are the best. Please let me have one.", status: "pending")
application_3 = Application.create!(name: "John", street_address: "123 Main St.", city: "Little Rock", state: "AR", zip_code: "72132", description: "Cats are the best. Please let me have one.", status: "pending")
application_4 = Application.create!(name: "Emma", street_address: "345 Broadway St.", city: "Fairfax", state: "VA", zip_code: "22030", description: "I love animals. Please let me have one.", status: "pending")

ApplicationPet.create!(pet: pet_1, application: application_1)
ApplicationPet.create!(pet: pet_2, application: application_1)

ApplicationPet.create!(pet: pet_1, application: application_2)
ApplicationPet.create!(pet: pet_2, application: application_2)

ApplicationPet.create!(pet: pet_3, application: application_3)
ApplicationPet.create!(pet: pet_4, application: application_3)
ApplicationPet.create!(pet: pet_5, application: application_3)

ApplicationPet.create!(pet: pet_6, application: application_4)
