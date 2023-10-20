# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Shelters
@shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

# Pets
@pet_1 = @shelter_1.pets.create(name: "Auggie", breed: "tuxedo shorthair", age: 5, adoptable: true)
@pet_2 = @shelter_1.pets.create(name: "Rue", breed: "shorthair", age: 3, adoptable: true)
@pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)

# Applications
@application_1 = Application.create!(name: "Julie Johnson", address: "201 Main Street", city: "Seattle", state: "WA", zip_code: "75250", description: "I love dogs!", to_adopt: "Auggie", to_adopt: "Ann", status: "In Progress")
@application_2 = Application.create!(name: "Steve Smith", address: "705 Olive Lane", city: "Omaha", state: "NE", zip_code: "98253", description: "Emotional support animal.", to_adopt: "Rue", status: "Accepted")

# Applicants
@applicant_1 = PetApplication.create!(application_id: @application_1.id, pet_id: @pet_1.id)
@applicant_2 = PetApplication.create!(application_id: @application_1.id, pet_id: @pet_3.id)
@applicant_3 = PetApplication.create!(application_id: @application_2.id, pet_id: @pet_2.id)