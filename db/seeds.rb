# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ApplicantsPet.destroy_all
Applicant.destroy_all
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

# Create shelters
shelters = Shelter.create([
                            {
                              name: "Aurora shelter",
                              city: "Aurora, CO",
                              foster_program: false,
                              rank: 9
                            },
                            {
                              name: 'We got that Dog',
                              city: 'H Town',
                              foster_program: true,
                              rank: 2
                            },
                            {
                              name: 'Barking Lot',
                              city: 'Red Rock',
                              foster_program: true,
                              rank: 3
                            }
                          ])

# Create veterinary offices
veterinary_offices = VeterinaryOffice.create([
                                              {
                                               name: 'Vet Office 1',
                                               boarding_services: true,
                                               max_patient_capacity: 50
                                               },
                                               {
                                                 name: 'Vet Office 2',
                                                 boarding_services: false,
                                                 max_patient_capacity: 30
                                               },
                                               {
                                                 name: 'Vet Office 3',
                                                 boarding_services: true,
                                                 max_patient_capacity: 40
                                               }
                                             ])

# Create veterinarians
veterinarians = Veterinarian.create([
                                      {
                                        name: 'Vet 1',
                                        veterinary_office: veterinary_offices.first,
                                        on_call: true,
                                        review_rating: 4
                                      },
                                      {
                                        name: 'Vet 2',
                                        veterinary_office: veterinary_offices.first,
                                        on_call: false,
                                        review_rating: 5
                                      },
                                      {
                                        name: 'Vet 3',
                                        veterinary_office: veterinary_offices.second,
                                        on_call: true,
                                        review_rating: 3
                                      }
                                    ])

# Create pets
pets = Pet.create([
                    {
                      name: "Lucille Bald",
                      age: 1,
                      breed: "sphynx",
                      shelter: shelters.first,
                      adoptable: true
                    },
                    {
                      name: 'Lobster',
                      age: 3,
                      breed: 'doberman',
                      shelter: shelters.second,
                      adoptable: true
                    },
                    {
                      name: 'Fluffy',
                      age: 4,
                      breed: "Pit",
                      shelter: shelters.third,
                      adoptable: false
                    }
                  ])

# Create applicants
applicants = Applicant.create([
                                {
                                  name: "Bob",
                                  street_address: "1234 Bob's Street",
                                  city: "Fudgeville",
                                  state: 'AK',
                                  zip_code: 27772,
                                  description: 'Wants a Dog',
                                  application_status: 'Pending'
                                },
                                {
                                  name: "John",
                                  street_address: '456 Elm St',
                                  city: 'Dallas',
                                  state: 'tx',
                                  zip_code: 70798,
                                  application_status: 'In Progress'
                                },
                                {
                                  name: 'Jane',
                                  street_address: '789 Oak St',
                                  city: 'Midland',
                                  state: 'CA',
                                  zip_code: 90123,
                                  description: 'Give me the fluff',
                                  application_status: 'Pending'
                                }
                              ])



# lucille_bald = shelter.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
# lobster = shelter.pets.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
# rex = shelter.pets.create!(adoptable: true, age: 2, breed: "Dog", name: "Rex" )
# floof = shelter.pets.create!(adoptable: true, age: 3, breed: "English Bulldog", name: "Floof")
# fluffy = shelter.pets.create!(adoptable: true, age: 4, breed: "Three-Headed Dog", name: "FlUfFy")
# fluff = shelter.pets.create!(adoptable: true, age: 5, breed: "Pomeranian", name: "FLUFF")
# mr_fluff = shelter.pets.create!(adoptable: true, age: 3, breed: "Great Dane", name: "Mr. FluFF")

