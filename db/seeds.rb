# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Application.destroy_all
Pet.destroy_all
PetApplication.destroy_all
Shelter.destroy_all

@app1 = Application.create!(name: "Charles", address: "123 S Monroe", city: "Denver", state: "CO", zip: "80102",
  description: "Good home for good boy", status: "In Progress")
@app2 = Application.create!(name: "TP", address: "1080 Pronghorn", city: "Del Norte", state: "CO", zip: "81132",
  description: "Good home for good boy", status: "In Progress")
@s1 = Shelter.create!(foster_program: true, name: "Paw Patrol", city: "Denver", rank: 2)
@p1 = Pet.create!(name: "Buster", adoptable: true, age: 7, breed: "mut", shelter_id: @s1.id)
@p2 = Pet.create!(name: "Kyo", adoptable: false, age: 1, breed: "calico", shelter_id: @s1.id)
PetApplication.create!(application: @app1, pet: @p2)
PetApplication.create!(application: @app2, pet: @p1)
