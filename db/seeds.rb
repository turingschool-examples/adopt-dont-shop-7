# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PetApplication.destroy_all
Application.destroy_all
Shelter.destroy_all
Pet.destroy_all

application_1 = Application.create!(
  name: "Fredrich Longbottom",
  address: "1234 1st St",
  city: "Denver",
  state: "CO",
  zip: "80202",
  description_why: "I love creatures."
)
application_2 = Application.create!(
  name: "Mike Tyson",
  address: "5678 2nd St",
  city: "Los Angeles",
  state: "CA",
  zip: "90210",
  description_why: "I love animalths."
)

shelter_1 = Shelter.create!(
  foster_program: false,
  name: "Denver Animal Shelter",
  city: "Denver",
  rank: 1
)
shelter_2 = Shelter.create!(
  foster_program: true,
  name: "Seattle Animal Shelter",
  city: "Seattle",
  rank: 2
)
shelter_3 = Shelter.create!(
  foster_program: false,
  name: "Portland Animal Shelter",
  city: "Portland",
  rank: 3
)
shelter_4 = Shelter.create!(
  foster_program: true,
  name: "Dallas Animal Shelter",
  city: "Dallas",
  rank: 4
)

pet_1 = shelter_1.pets.create!(
  adoptable: true,
  age: 3,
  breed: "Jack Russell Terrier",
  name: "Alphonso"
)
pet_2 = shelter_1.pets.create!(
  adoptable: true,
  age: 4,
  breed: "Husky",
  name: "Bailey"
)
pet_3 = shelter_1.pets.create!(
  adoptable: true,
  age: 2,
  breed: "Great Dane",
  name: "Charlie"
)
pet_4 = shelter_4.pets.create!(
  adoptable: true,
  age: 5,
  breed: "Golden",
  name: "Doug"
)

pet_app_1 = PetApplication.create!(
  pet_id: pet_1.id,
  application_id: application_1.id
)
pet_app_2 = PetApplication.create!(
  pet_id: pet_4.id,
  application_id: application_2.id
)
pet_app_2.update(status: "Approved")
