# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

application1 = Application.create!(applicant_name: "Thomas Jefferson", street_address: "123 Main St.", city: "Boston", state: "MA", zip_code: "12345", description: "I'm on a fiver", status: "In Progress")
shelter1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
pet1 = shelter1.pets.create!(name: "Zeus", breed: "Great Dane", age: 3, adoptable: true)
pet2 = shelter1.pets.create!(name: "Demeter", breed: "Golden Retriever", age: 4, adoptable: true)
pet3 = shelter1.pets.create!(name: "Hades", breed: "Doberman", age: 3, adoptable: true)
pet4 = shelter1.pets.create!(name: "Apollo", breed: "German Shepherd", age: 2, adoptable: false)
pet5 = shelter1.pets.create!(name: "zeus2", breed: "German Shepherd", age: 2, adoptable: true)