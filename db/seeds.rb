# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because Scoob and I love Scooby Snacks")
    pet = applicant.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)