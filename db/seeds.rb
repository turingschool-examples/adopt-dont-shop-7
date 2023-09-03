# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Application.destroy_all
PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all

shelter1 = Shelter.create!(foster_program: true, name: "Shelter 1", city: "Boulder", rank: 1, )
shelter2 = Shelter.create!(foster_program: true, name: "Shelter 2", city: "Cleveland", rank: 2, )

shelter1.pets.create!(adoptable: true, age: 2, breed: "Husky", name: "Spot")
shelter1.pets.create!(adoptable: true, age: 1, breed: "Chihuahua", name: "Skip")
shelter1.pets.create!(adoptable: true, age: 3, breed: "Golden Retriever", name: "Fluffy")

shelter2.pets.create!(adoptable: true, age: 5, breed: "Doberman", name: "Prince")
shelter2.pets.create!(adoptable: true, age: 6, breed: "Boxer", name: "Killer")
shelter2.pets.create!(adoptable: true, age: 7, breed: "Pug", name: "Adonis")