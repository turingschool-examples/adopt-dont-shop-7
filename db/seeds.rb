# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ApplicationPet.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all


  @shelter_1 = Shelter.create!(name: 'Denver Animal Shelter', city: 'Denver', foster_program: false, rank: 2)
  @shelter_2 = Shelter.create!(name: 'Boulder Animal Shelter', city: 'Boulder', foster_program: false, rank: 3)
  @shelter_3 = Shelter.create!(name: 'Dallas Animal Shelter', city: 'Dallas', foster_program: false, rank: 2)

  @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'Golden Retriever', name: 'Buddy')
  @pet_2 = @shelter_2.pets.create!(adoptable: true, age: 3, breed: 'American Bulldog', name: 'Rover')
  @pet_3 = @shelter_3.pets.create!(adoptable: true, age: 5, breed: 'Poodle', name: 'Max')
  @pet_4 = @shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Cunucu', name: 'Spud')
  @pet_5 = @shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Cunucu', name: 'SpuddyBuddy')

  @application_1 = Application.create!(name: 'John Smith', street_address: '1234 Fake Street', city: 'Denver', state: 'CO', zip_code: 80202, description: 'Big Yak guy, but a dog will do', status: 'In Progress')
  @application_2 = Application.create!(name: 'Jane Doe', street_address: '5678 Wannabe Road', city: 'Boulder', state: 'CO', zip_code: 80301, description: 'I love cats!', status: 'In Progress')
  @application_3 = Application.create!(name: 'Joe Schmoe', street_address: '90210 Round Drive', city: 'Dallas', state: 'TX', zip_code: 75214, description: 'I like Turtles!', status: 'In Progress')