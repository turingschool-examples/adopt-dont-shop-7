# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
 shelter.destroy_all
 pet.destroy_all
 app.destroy_all

  shelter1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
  shelter2 = Shelter.create(name: "Denver shelter", city: "Denver, CO", foster_program: true, rank: 10)
  shelter3 = Shelter.create(name: "Boulder shelter", city: "Boulder, CO", foster_program: false, rank: 8)

  pet1 = shelter1.pets.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
  pet2 = shelter1.pets.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster")
  pet3 = shelter2.pets.create(adoptable: true, age: 2, breed: "saint bernard", name: "Beethoven")
  pet4 = shelter2.pets.create(adoptable: true, age: 4, breed: "saint bernard", name: "Bernard")
  pet5 = shelter3.pets.create(adoptable: true, age: 5, breed: "saint bernard", name: "Saint")
  pet6 = shelter3.pets.create(adoptable: true, age: 6, breed: "saint bernard", name: "Bernie")

  app1 = App.create(name: "Timmy", address: "123 Main St", city: "Aurora, CO", zip: 80111, description: "I love dogs")
  app2 = App.create(name: "Jimmy", address: "123 Main St", city: "Aurora, CO", zip: 80111, description: "I love beavers")
  app3 = App.create(name: "Kimmy", address: "123 Main St", city: "Aurora, CO", zip: 80111, description: "I love cats")