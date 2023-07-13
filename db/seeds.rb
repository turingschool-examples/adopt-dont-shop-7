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

happy_tails = Shelter.create!(name: "Happy Tails", foster_program: true, city: "San Francisco", rank: 3)
sunnyside = Shelter.create!(name: "Sunnyside", foster_program: false, city: "Boulder", rank: 2)

sparky = happy_tails.pets.create!(name: "Sparky", adoptable: true, age: 2, breed: "Beagle")
mittens = happy_tails.pets.create!(name: "Mittens", adoptable: true, age: 4, breed: "Tuxedo")
rufus = happy_tails.pets.create!(name: "Rufus", adoptable: false, age: 7, breed: "Bloodhound")
fluffy = sunnyside.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "Sphynx")
copper = sunnyside.pets.create!(name: "Copper", adoptable: false, age: 5, breed: "German Shephard")
willow = sunnyside.pets.create!(name: "Willow", adoptable: true, age: 1, breed: "Labrador")
roxy = sunnyside.pets.create!(name: "Roxy", adoptable: true, age: 6, breed: "Labrador")

mountainside = VeterinaryOffice.create!(name: "Mountainside", bording_services: true, max_patient_capacity: 10)
pawhealth = VeterinaryOffice.create!(name: "Paw Health", bording_services: false, max_patient_capacity: 5)

kelly = mountainside.veterinarians.create!(name: "Kelly", on_call: false, review_rating: 1)
melissa = mountainside.veterinarians.create!(name: "Melissa", on_call: true, review_rating: 5)
jen = pawhealth.veterinarians.create!(name: "Jen", on_call: false, review_rating: 4)
moss = pawhealth.veterinarians.create!(name: "Moss", on_call: true, review_rating: 3)



