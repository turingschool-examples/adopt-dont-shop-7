# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

@application_1 = Application.create(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals")

@shelter = Shelter.create(foster_program: true, name: "Turing", city: "Backend", rank: 3)

@dog = @shelter.pets.create(adoptable: true, age: 4, breed: "Golden Retriever", name: "Dog")
@cat = @shelter.pets.create(adoptable: true, age: 1, breed: "Tabby", name: "Cat")

@application_pet_1 = ApplicationPet.create(application_id: @application_1.id, pet_id: @dog.id)
@application_pet_2 = ApplicationPet.create(application_id: @application_1.id, pet_id: @cat.id)
