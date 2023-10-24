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

# @app1 = Application.create!({name: "Charles", address: "123 S Monroe", city: "Denver", state: "CO", zip: "80102",
#   description: "Good home for good boy", status: "In Progress"})
# @app2 = Application.create!({name: "TP", address: "1080 Pronghorn", city: "Del Norte", state: "CO", zip: "81132",
#   description: "Good home for good boy", status: "In Progress"})
# @s1 = Shelter.create!({foster_program: true, name: "Paw Patrol", city: "Denver", rank: 2})
# @p1 = Pet.create!({name: "Buster", adoptable: true, age: 7, breed: "mut", shelter_id: @s1.id})
# @p2 = Pet.create!({name: "Kyo", adoptable: false, age: 1, breed: "calico", shelter_id: @s1.id})
# PetApplication.create!(application: @app1, pet: @p2)
# PetApplication.create!(application: @app2, pet: @p1)

# Shelters
@shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
@shelter_4 = Shelter.create(name: "Small Paws Rescue", city: "Boulder, CO", foster_program: true, rank: 7)

# Pets
@s1_p1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
@s1_p2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
@s3_p1 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
@s4_p1 = @shelter_4.pets.create(name: "Whiskers", breed: "siamese", age: 2, adoptable: true)

# Applications
@app1 = Application.create!({name: "Charles", address: "123 S Monroe", city: "Denver", state: "CO", zip: "80102",
                          description: "Good home for good boy", status: "In Progress"})
@app2 = Application.create!({name: "TP", address: "1080 Pronghorn", city: "Del Norte", state: "CO", zip: "81132",
                          description: "Good home for good boy", status: "Pending"})
@app3 = Application.create!({name: "Alice", address: "456 N Lincoln", city: "Aurora", state: "CO", zip: "80203",
                          description: "I love cats", status: "Accepted"})
@app4 = Application.create!({name: "Bob", address: "789 W Colfax", city: "Denver", state: "CO", zip: "80204",
                          description: "Dogs are my favorite", status: "Pending"})
@app5 = Application.create!({name: "Eve", address: "111 E 3rd Ave", city: "Denver", state: "CO", zip: "80205",
                          description: "Looking for a buddy", status: "Pending"})

# Pet-Application links
PetApplication.create!(application: @app1, pet: @s1_p2)
PetApplication.create!(application: @app2, pet: @s1_p1)
PetApplication.create!(application: @app3, pet: @s3_p1)
PetApplication.create!(application: @app4, pet: @s4_p1)
PetApplication.create!(application: @app5, pet: @s1_p2)