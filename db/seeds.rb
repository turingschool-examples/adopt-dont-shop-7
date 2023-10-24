# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# WHAT IS THIS?? RENDER SAID WE NEED? ASK INSTRUCTOR!! {Model}.destroy_all

@shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: "Littleton shelter", city: "Littleton, CO", foster_program: false, rank: 9)
@pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
@pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
@pet_3 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
@application = Application.create(name: "Jimmy", street_address: "1234 fake st", city: "littleton", state: "co", zip_code: 85313, description: "cute and lovable", application_status: "pending")
PetApplication.create(application: @application, pet: @pet_1)