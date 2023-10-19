# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

application = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: "Bruno", status: "In Progress")