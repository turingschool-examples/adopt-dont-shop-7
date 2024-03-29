# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Application.destroy_all

application = Application.create!(
  name: 'Lance Bass',
  description: 'I love animals.',
  status: 'Pending',
  street_address: '1234 Sesame Street',
  city: 'New York City',
  state: 'NY',
  zip_code: 10001
  )
