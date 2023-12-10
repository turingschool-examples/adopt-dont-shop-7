require "rails_helper"

RSpec.describe "the application show" do
  before(:each) do
    @victor_app = Application.create!(applicant_name: "Victor Antonio Sanchez", address: "97 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 3, adoptable: false)
    @victor_app.pets << [@pet_1, @pet_2]# Associates pets with the application
  end
  
  it "display's the applicants info" do
    # 1. Application Show Page
    # As a visitor
    # When I visit an applications show page
    visit "/applications/#{@victor_app.id}"
    # Then I can see the following:
    # - Name of the Applicant
    expect(page).to have_content("Applicant Name: Victor Antonio Sanchez")
    # - Full Address of the Applicant including street address, city, state, and zip code
    expect(page).to have_content("Address: 97 Jaffa Road")
    expect(page).to have_content("City: Jerusalem")
    expect(page).to have_content("State: Israel")
    expect(page).to have_content("Zip code: 9103401")
    # - Description of why the applicant says they'd be a good home for this pet(s)
    expect(page).to have_content("Because I'm rich! :)")
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    expect(page).to have_link("Mr. Pirate")
    expect(page).to have_link("Clawdia")
    expect(page).to_not have_link("Ann")
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    expect(page).to have_content("Application Status: In Progress")
  end
  it "returns partial matches in a Pet name's search" do
    sam_app = Application.create!(applicant_name: "Samuel Puttman", address: "94 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
    shelter_2 = Shelter.create(name: "Black Ice shelter", city: "Denver, CO", foster_program: true, rank: 7)
    pet_4 = @shelter_1.pets.create!(name: 'fluffy', age: 1, breed: 'Golden', adoptable: true) 
    pet_5 = @shelter_1.pets.create!(name: 'fluff', age: 1, breed: 'Golden', adoptable: true)
    pet_6 = @shelter_1.pets.create!(name: 'mr. fluff', age: 1, breed: 'Golden', adoptable: true) 
    sam_app.pets << [pet_4, pet_5, pet_6]# Associates pets with the application

    # 8. Partial Matches for Pet Names

    # As a visitor
    # When I visit an application show page
    visit "/applications/#{sam_app.id}"
    # And I search for Pets by name
    fill_in :name, with: "fluff"
    click_on("Search")
    # Then I see any pet whose name PARTIALLY matches my search
    # For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"
    # expect(page).to have_content("fluffy")
    expect(page).to have_content("fluff")
    # expect(page).to have_content("mr. fluff")
    # 9. Case Insensitive Matches for Pet Names
  end

  it "returns Case Insensitive Matches for Pet name's search" do
    sam_app = Application.create!(applicant_name: "Samuel Puttman", address: "94 Jaffa Road", city: "Jerusalem", state: "Israel", zip_code: "9103401", description: "Because I'm rich! :)")
    shelter_2 = Shelter.create(name: "Black Ice shelter", city: "Denver, CO", foster_program: true, rank: 7)
    pet_4 = @shelter_1.pets.create!(name: 'Fluffy', age: 1, breed: 'Golden', adoptable: true) 
    pet_5 = @shelter_1.pets.create!(name: 'FLUFF', age: 1, breed: 'Golden', adoptable: true)
    pet_6 = @shelter_1.pets.create!(name: 'Mr. FlUfF', age: 1, breed: 'Golden', adoptable: true) 
    sam_app.pets << [pet_4, pet_5, pet_6]# Associates pets with the application

    # 9. Case Insensitive Matches for Pet Names
    # As a visitor
    # When I visit an application show page
    visit "/applications/#{sam_app.id}"
    # And I search for Pets by name
    # Then my search is case insensitive
    # For example, if I search for "fluff", my search would match pets with names "Fluffy", "FLUFF", and "Mr. FlUfF"
    expect(page).to have_content("Fluffy")
    expect(page).to have_content("FLUFF")
    expect(page).to have_content("Mr. FlUfF")
  end
end