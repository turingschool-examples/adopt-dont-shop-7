# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all

@shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

@pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
@pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
@pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
@pet_4 = @shelter_2.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)
@pet_5 = @shelter_3.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster")
@pet_6 = @shelter_3.pets.create!(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven")
@pet_7 = @shelter_1.pets.create!(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true)
@pet_8 = @shelter_1.pets.create!(name: "Scooby", age: 3, breed: "Great Dane", adoptable: true)

@application_1 = Application.create!(
  name: 'Lance Bass',
  description: 'I love animals.',
  street_address: '1234 Back Street',
  city: 'New York City',
  state: 'NY',
  zip_code: 10001,
  status: "Pending",
  pets: [@pet_1, @pet_2]
  )
@application_2 = Application.create!(
  name: 'Aurora Sanderson',
  description: 'Animals are pawsome.',
  street_address: '54321 Example Street',
  city: 'Denver',
  state: 'CO',
  zip_code: 80219,
  status: "Pending",
  pets: [@pet_2, @pet_3]
  )
@application_3 = Application.create!(
  name: 'Shaggy',
  description: 'Scooby Dooby Doo',
  street_address: '333 Mystery Street',
  city: 'Coolsville',
  state: 'CA',
  zip_code: 98765,
  status: "Pending",
  pets: [@pet_7, @pet_8]
  )
