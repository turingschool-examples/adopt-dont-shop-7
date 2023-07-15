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

  @shelter_1 = Shelter.create!(name: 'Denver Animal Shelter', city: 'Denver', foster_program: false, rank: 9)
  @shelter_2 = Shelter.create!(name: 'Boulder Animal Shelter', city: 'Boulder', foster_program: false, rank: 7)
  @shelter_3 = Shelter.create!(name: 'Dallas Animal Shelter', city: 'Dallas', foster_program: false, rank: 2)

  @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'Golden Retriever', name: 'Buddy')
  @pet_2 = @shelter_2.pets.create!(adoptable: true, age: 3, breed: 'American Bulldog', name: 'Rover')
  @pet_3 = @shelter_3.pets.create!(adoptable: true, age: 5, breed: 'Poodle', name: 'Max')
  @pet_4 = @shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Cunucu', name: 'Spud')
  @pet_5 = @shelter_1.pets.create!(adoptable: true, age: 2, breed: 'Cunucu', name: 'SpuddyBuddy')

