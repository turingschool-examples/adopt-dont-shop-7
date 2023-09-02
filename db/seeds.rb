# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Veterinarian.destroy_all
Pet.destroy_all
Shelter.destroy_all


shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: "Boulder shelter", city: "Boulder, CO", foster_program: false, rank: 9)

pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow", shelter_id: "#{shelter.id}")
pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: "#{shelter.id}")
pet_3 = Pet.create(adoptable: true, age: 1, breed: "domestic shorthair", name: "Sylvester", shelter_id: "#{shelter_2.id}")
pet_4 = Pet.create(adoptable: true, age: 1, breed: "orange tabby shorthair", name: "Lasagna", shelter_id: "#{shelter_2.id}")

vet_office = VeterinaryOffice.create(name: "Best Vets", boarding_services: true, max_patient_capacity: 20)


vet_1 = Veterinarian.create(name: "Taylor", review_rating: 10, on_call: true, veterinary_office_id: "#{vet_office.id}")
vet_2 = Veterinarian.create(name: "Jim", review_rating: 8, on_call: true, veterinary_office_id: "#{vet_office.id}")

dude = Applicant.create(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
state: "Texas", zip_code: "75248", description: "I love animals!")

PetsApplication.create!(applicant: dude, pet: pet_2)
