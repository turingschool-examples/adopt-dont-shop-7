# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

# Shelters
shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: "Animal House", city: "Eugene, OR", foster_program: false, rank: 8)
shelter_3 = Shelter.create(name: "Dumb Friends League", city: "Denver CO", foster_program: true, rank: 10)

# Pets
lucille = shelter_1.pets.create(adoptable: true, age: 1, breed: "Bengal", name: "Baahubali")
whiskers = shelter_1.pets.create(adoptable: true, age: 5, breed: "Tabby", name: "Garfield")
cheeto = shelter_1.pets.create(adoptable: true, age: 2, breed: "Corgi", name: "Ein")

triumph = shelter_2.pets.create(adoptable: true, age: 3, breed: "Insult Dog", name: "Triumph")
clifford = shelter_2.pets.create(adoptable: true, age: 2, breed: "Big Red Dog", name: "Clifford")
scrappy = shelter_2.pets.create(adoptable: true, age: 5, breed: "Fluffadoodle", name: "Poof")

scooby = shelter_3.pets.create(adoptable: true, age: 2, breed: "Great Dane", name: "Scooby")
zula = shelter_3.pets.create(adoptable: true, age: 1, breed: "Serengeti", name: "Zula")
brian = shelter_3.pets.create(adoptable: true, age: 7, breed: "TV Pooch", name: "Brian Griffin")

# Applications
dargo = Application.create(name: "Kal Dargo", street: "123 Turing Lane", city: "Boulder", state: "CO", zip_code: "80301", description: "I really want a dog because I love dogs.", status: "In Progress")
aeryn = Application.create(name: "Aeryn Sun", street: "555 Peaceful Ave", city: "Hollywood", state: "CA", zip_code: "90210", description: "I need a companion on my long travels.", status: "In Progress")
chiana = Application.create(name: "Chiana", street: "235 River Ferry", city: "Nebari", state: "AU", zip_code: "45J83", description: "Oh come on, look how cute they are, just look!", status: "In Progress")
rygel = Application.create(name: "Dominar Rygel XVI", street: "101 Royal Palace Rd.", city: "Hyneria", state: "UK", zip_code: "48J77", description: "I promise I won't eat it... reall I won't.", status: "In Progress")


# PetApplications

aeryn.pet_applications.create(pet_id: lucille.id)
aeryn.pet_applications.create(pet_id: scooby.id)
aeryn.pet_applications.create(pet_id: brian.id)

dargo.pet_applications.create(pet_id: whiskers.id)
dargo.pet_applications.create(pet_id: clifford.id)

rygel.pet_applications.create(pet_id: cheeto.id)

# Vet Office
vet_office_1 = VeterinaryOffice.create(name: "Best Vets", boarding_services: true, max_patient_capacity: 20)
vet_office_2 = VeterinaryOffice.create(name: "Put a bird on it", boarding_services: true, max_patient_capacity: 5)

# Veterinarians
vet_office_1.veterinarians.create(name: "Taylor", review_rating: 10, on_call: true)
vet_office_2.veterinarians.create(name: "Jim", review_rating: 8, on_call: true)
