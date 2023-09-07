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

application_1 = Application.create!(name: "Tyler Blackmon", address: "1234 Test St, Colorado Springs, CO, 80922", description: "This is why I'd be a good home!", status: "In Progress")
application_2 = Application.create!(name: "Josh Blackmon", address: "4321 Another Test St, Colorado Springs, CO, 80922", description: "My description is too good", status: "In Progress")
shelter_1 = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
pet_1 = Pet.create!(name: "Scooby", age: 2, breed: "Greate Dane", adoptable: true, shelter_id: shelter_1.id)
pet_2 = Pet.create!(name: "Chicken", age: 6, breed: "Actually A Bird", adoptable: true, shelter_id: shelter_1.id)
pet_3 = application_2.pets.create!(name: "Kiwi", age: 5, breed: "Actually A Kiwi", adoptable: true, shelter_id: shelter_1.id)
pet_4 = Pet.create!(name: "Coco", age: 4, breed: "Just another bird", adoptable:true, shelter_id: shelter_1.id)
PetApplication.create!(pet_id: pet_4.id, application_id: application_1.id)
PetApplication.create!(pet_id: pet_4.id, application_id: application_2.id)
