# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
VeterinaryOffice.destroy_all
Veterinarian.destroy_all

john = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: "Bruno", status: "In Progress")
regan = Application.create!(name: "Regan Ocean", street_address: "46 N. Old York Road", city: "Willoughby", state: "OH", zip_code: "44094", description: "I like cats.", pet_names: [], status: "In Progress")
zoe = Application.create!(name: "Zoe Ali", street_address: "376 Amherst Street", city: "Simpsonville", state: "SC", zip_code: "29680", description: "I like dogs.", pet_names: [], status: "In Progress")
lon = Application.create!(name: "Lon Sharise", street_address: "934 Wintergreen St.", city: "North Kingstown", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: [], status: "In Progress")

north_shelter = Shelter.create(name: "North Shelter", city: "Irvine CA", foster_program: false, rank: 9)
east_shelter = Shelter.create(name: "East shelter", city: "Aurora, CO", foster_program: false, rank: 9)
west_shelter = Shelter.create(name: "West shelter", city: "Irvine, CA", foster_program: false, rank: 7)
south_shelter = Shelter.create(name: "South shelter", city: "Aurora, CO", foster_program: true, rank: 7)

pet_lucille = Pet.create(name: "Lucille", adoptable: true, age: 1, breed: "Sphynx", shelter_id: north_shelter.id)
pet_lobster = Pet.create(name: "Lobster", adoptable: true, age: 3, breed: "Doberman", shelter_id: east_shelter.id)
pet_scooby = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: west_shelter.id)
pet_scrappy = Pet.create(name: "Scrappy", age: 1, breed: "Golden Retreiver", adoptable: true, shelter_id: south_shelter.id)

vet_office_1 = VeterinaryOffice.create(name: "Special Friends", boarding_services: true, max_patient_capacity: 100)
vet_office_2 = VeterinaryOffice.create(name: "Pet Emergency Room", boarding_services: true, max_patient_capacity: 50)
vet_office_3 = VeterinaryOffice.create(name: "The Country Vet", boarding_services: true, max_patient_capacity: 200)

vet_office_1.veterinarians.create(name: "Taylor", on_call: true, review_rating: 10)
vet_office_1.veterinarians.create(name: "Jim", on_call: true, review_rating: 9)
vet_office_3.veterinarians.create(name: "Alex", on_call: true, review_rating: 8)
