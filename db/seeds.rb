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

@shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
@shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
@shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

@pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
@pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster")

@pet_3 = @shelter_2.pets.create!(adoptable: true, age: 2, breed: "saint bernard", name: "Beethoven")
@pet_4 = @shelter_2.pets.create!(adoptable: false, age: 8, breed: "border collie", name: "Marshall")
@pet_5 = @shelter_2.pets.create!(adoptable: true, age: 4, breed: "tabby", name: "Pepper")

@application_1 = Application.create!(name: "Bob", street_address: "1234 Southeast St",
  city: "San Francisco", state: "CA", zip_code: 12345,
  description: "Wants a dog", status: "Pending")
@application_2 = Application.create!(name: "Sally", street_address: "4321 Bridge Way",
  city: "San Francisco", state: "CA", zip_code: 54321,
  description: "Would like a siamese cat", status: "In Progress")

@application_3 = Application.create!(name: "Fred", street_address: "376 Monroe St",
  city: "Los Angeles", state: "CA", zip_code: 67890,
  description: "My wife really wants this cat", status: "In Progress")
@application_4 = Application.create!(name: "Toki", street_address: "8395 Other St",
  city: "Los Somewhere", state: "ZX", zip_code: 37163,
  description: "We want this cat more than Fred", status: "In Progress")
@application_5 = Application.create!(name: "Jimbo", street_address: "45865 Turnaround St",
  city: "NYC", state: "NY", zip_code: 84930,
  description: "I want a big ol dog", status: "In Progress")

@application_6 = Application.create!(name: "New Dude", street_address: "9375 Down Under St.",
  city: "Upper Jabib", state: "PA", zip_code: 74625,
  description: "Do you have any alligators?", status: "In Progress")

PetApplication.create!(pet: @pet_1, application: @application_2)
PetApplication.create!(pet: @pet_2, application: @application_1)

PetApplication.create!(pet: @pet_3, application: @application_5)
PetApplication.create!(pet: @pet_5, application: @application_3)
PetApplication.create!(pet: @pet_5, application: @application_4)