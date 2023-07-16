# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
@shelter = Shelter.create!(name: "Heavenly pets", city: "Aurora, CO", foster_program: true, rank: 7)
@shelter_1 = Shelter.create!(foster_program: true, name: "County Pet Shelter", city: "Denver", rank: 1)
@pet = Pet.create!(adoptable: true, age: 3, breed: "GSD", name: "Charlie", shelter_id: @shelter.id)
@pet_1 = Pet.create!(adoptable: true, age: 2, breed: "Golden Retriever", name: "Rover", shelter_id: @shelter_1.id)
@pet_2 = Pet.create!(adoptable: true, age: 1, breed: "Maine Coon", name: "Kitty", shelter_id: @shelter_1.id)
@app_1 = Application.create!(name: "John Smith", address: "123 Main", city: "Anytown", state: "CO", zip_code: "80000", description: "Because I have a house", application_status: "In Progress")
@app_1_pet_1 = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @app_1.id)