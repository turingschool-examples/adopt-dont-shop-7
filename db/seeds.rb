# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
applicant_who_has_pets = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because")
applicant_who_has_no_pets = Application.create(name: "Daphne", street_address: "4 North Street", city: "Boulder", state: "CO", zip_code: "80209", description: "I want a pet")
pet = applicant_who_has_pets.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
cat = Pet.create(name: "Catdog", age: 4, breed: "Calico", adoptable: true, shelter_id: shelter.id)