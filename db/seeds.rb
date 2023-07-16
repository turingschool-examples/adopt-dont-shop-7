# {Model}.destroy_all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ApplicationPet.destroy_all
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

# Shelters
shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
shelter_3 = Shelter.create(name: "Dumb Friends League", city: "Denver CO", foster_program: true, rank: 10)

# Pets
lucille = shelter_1.pets.create(adoptable: true, age: 1, breed: "Sphynx", name: "Lucille Bald")
whiskers = shelter_1.pets.create(adoptable: true, age: 5, breed: "Kitty", name: "Whiskers")
cheeto = shelter_1.pets.create(adoptable: true, age: 2, breed: "Corgi", name: "Cheeto")

triumph = shelter_2.pets.create(adoptable: true, age: 3, breed: "Insult Dog", name: "Triumph")
clifford = shelter_2.pets.create(adoptable: true, age: 2, breed: "Big Red Dog", name: "Clifford")
scrappy = shelter_2.pets.create(adoptable: true, age: 5, breed: "Puntable", name: "Scrappy")

scooby = shelter_3.pets.create(adoptable: true, age: 2, breed: "Great Dane", name: "Scooby")
santas_lil_helper = shelter_3.pets.create(adoptable: true, age: 1, breed: "Mutt", name: "Santa's Little Helper")
brian = shelter_3.pets.create(adoptable: true, age: 7, breed: "TV Pooch", name: "Brian Griffin")

# Applications
mr_ape = Application.create(name: "Mr. Ape", street: "123 Turing Lane", city: "Boulder", state: "CO", zip: "80301", description: "I really want a dog because I love dogs", status: "In Progress")
penny_lane = Application.create(name: "Penny Lane", street: "555 McCartney", city: "Hollywood", state: "CA", zip: "90210", description: "Strawberry Fields Forever", status: "Pending")
paul = Application.create(name: "Paul", street: "1960 Penny Lane", city: "Bedfordshire", state: "UK", zip: "48J77", description: "I still believe love is all you need.  I don't know a better message than that.", status: "Accepted")
ringo = Application.create(name: "Ringo", street: "235 River Ferry", city: "Liverpool", state: "UK", zip: "45J83", description: "I get by with a little help from my friends", status: "Rejected")


# ApplicationPets

mr_ape.application_pets.create(pet_id: lucille.id)
mr_ape.application_pets.create(pet_id: scooby.id)
mr_ape.application_pets.create(pet_id: santas_lil_helper.id)

penny_lane.application_pets.create(pet_id: whiskers.id)
penny_lane.application_pets.create(pet_id: clifford.id)

paul.application_pets.create(pet_id: cheeto.id)

# Vet Office
vet_office_1 = VeterinaryOffice.create(name: "Best Vets", boarding_services: true, max_patient_capacity: 20)
vet_office_2 = VeterinaryOffice.create(name: "Put a bird on it", boarding_services: true, max_patient_capacity: 5)

# Veterinarians
vet_office_1.veterinarians.create(name: "Taylor", review_rating: 10, on_call: true)
vet_office_2.veterinarians.create(name: "Jim", review_rating: 8, on_call: true)
