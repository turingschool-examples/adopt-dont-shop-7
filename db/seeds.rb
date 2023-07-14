# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Applicant.destroy_all
ApplicantPet.destroy_all
Shelter.destroy_all
Pet.destroy_all
Shelter.destroy_all

shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
applicant_1 = Applicant.create(name: "Ian", street_address: "4130 cleveland ave", city: "New Orleans", state: "louisiana", zip_code: 70119, description: "I wanna have cat", status: "In Progress")
pet_1 = shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
pet_2 = shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
pet_3 = shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
applicant_pet = ApplicantPet.create(pet_id: pet_1.id, applicant_id: applicant_1.id)