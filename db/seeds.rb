# {Model}.destroy_all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Applicants
@mr_ape = Application.create!(name: "Mr. Ape", street: "123 Turing Lane", city: "Boulder", state: "Colorado", zip: "80301", description: "I really want a dog because I love dogs", status: "In Progress")
@penny_lane = Application.create!(name: "Penny Lane", street: "555 McCartney", city: "Hollywood", state: "California", zip: "90210", description: "Strawberry Fields Forever", status: "In Progress")
@paul = Application.create!(name: "Paul", street: "1960 Penny Lane", city: "Bedfordshire", state: "England", zip: "48", description: "I still believe love is all you need.  I don't know a better message than that.", status: "In Progress")

# Pets
@pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
@pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
@pet_3 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

# Shelters
@shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
@shelter_2 = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)

# Vet Office
@vet_office_1 = VeterinaryOffice.create!(name: "Best Vets", boarding_services: true, max_patient_capacity: 20)
@vet_office_2 = VeterinaryOffice.create!(name: "Put a bird on it", boarding_services: true, max_patient_capacity: 5)

# Veterinarians
@vet_1 = Veterinarian.create!(name: "Taylor", review_rating: 10, on_call: true, veterinary_office_id: vet_office.id)
@vet_2 = Veterinarian.create!(name: "Jim", review_rating: 8, on_call: true, veterinary_office_id: vet_office.id)