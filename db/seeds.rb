# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

@application_1 = Application.create(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love cats")
@application_2 = Application.create(name: "Jake", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love dogs", status: "Pending")
@application_3 = Application.create(name: "Jerry", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love hamsters", status: "Pending")
@application_4 = Application.create(name: "Jim", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals")

@shelter = Shelter.create(foster_program: true, name: "Turing", city: "Backend", rank: 3)
@fsa = Shelter.create(foster_program: true, name: "Fullstack Academy", city: "Backend", rank: 3)
@codesmith = Shelter.create(foster_program: true, name: "Codesmith", city: "Backend", rank: 3)
@rithm = Shelter.create(foster_program: true, name: "Rithm School", city: "Backend", rank: 3)
@hackreactor = Shelter.create(foster_program: true, name: "Hack Reactor", city: "Backend", rank: 3)
@shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

@dog = @shelter.pets.create(adoptable: true, age: 4, breed: "Golden Retriever", name: "Dog")
@cat = @shelter.pets.create(adoptable: true, age: 1, breed: "Tabby", name: "Cat")
@hamster = @shelter.pets.create(adoptable: true, age: 1, breed: "Tabby", name: "Hamster")
@pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
@pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
@pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
@pet_4 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)


@application_pet_1 = ApplicationPet.create(application_id: @application_1.id, pet_id: @dog.id)
@application_pet_2 = ApplicationPet.create(application_id: @application_1.id, pet_id: @cat.id)
@application_pet_3 = ApplicationPet.create(application_id: @application_3.id, pet_id: @dog.id)
@application_pet_4 = ApplicationPet.create(application_id: @application_2.id, pet_id: @dog.id)
@application_pet_5 = ApplicationPet.create(application_id: @application_3.id, pet_id: @hamster.id)
@application_pet_6 = ApplicationPet.create(application_id: @application_3.id, pet_id: @cat.id)
