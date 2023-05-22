# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ApplicationPet.destroy_all
Application.destroy_all
Shelter.destroy_all
Pet.destroy_all
VeterinaryOffice.destroy_all
Veterinarian.destroy_all


@shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
@shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)

@pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
@pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
@pet_3 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
@pet_4 = @shelter_2.pets.create!(name: "Potatoe", breed: "Lab", age: 7, adoptable: true)
@pet_5 = @shelter_2.pets.create!(name: "Duncan", breed: "Golden Retriever", age: 1, adoptable: true)

@susie = Application.create!(
  name: 'Susie', 
  street_address: '5234 S Jamaica', 
  city: 'Fargo', 
  state: 'MI', 
  zip: '45896', 
  description: 'Loves alligators.', 
  status: 'Pending'
)

@tom = Application.create!(
  name: 'Thomas', 
  street_address: '5234 S Jefferson', 
  city: 'Julian', 
  state: 'AL', 
  zip: '43896', 
  description: 'Has owned a pet.', 
  status: 'In Progress'
)

@michael = Application.create!(
  name: 'Michael', 
  street_address: '111 S Dublin', 
  city: 'Eagan', 
  state: 'MN', 
  zip: '55123', 
  description: 'I like turtles', 
  status: 'In Progress'
)

ApplicationPet.create!(pet: @pet_1, application: @susie)
ApplicationPet.create!(pet: @pet_5, application: @susie)

ApplicationPet.create!(pet: @pet_1, application: @tom)
ApplicationPet.create!(pet: @pet_2, application: @tom)
ApplicationPet.create!(pet: @pet_4, application: @tom)

ApplicationPet.create!(pet: @pet_3, application: @michael)
ApplicationPet.create!(pet: @pet_5, application: @michael)