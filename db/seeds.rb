# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Application.destroy_all

application = Application.create!(
  name: "Fredrich Longbottom",
  address: "1234 1st St",
  city: "Denver",
  state: "CO",
  zip: "80202",
  description_why: "I love creatures."
)
