require "rails_helper"

RSpec.describe "the application show" do
  before(:each) do
    @shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @application_1 = Application.create(name: "John Dwayne", address: "1010 W 50th Ave, Denver, CO, 80020", description: "Background as a dog sitter", status: "In Progress")
    @pet = @application_1.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create(name: "Chicken", age: 3, breed: "Lab", adoptable: true, shelter_id: @shelter.id)
  end

  it "shows the application and all of its attributes" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_content("#{@pet.name}")
    
    click_link("#{@pet.name}")

    expect(page).to have_current_path("/pets/#{@pet.id}")
  end

  it "allows a user to search for pets and displays all found pets on the page" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_field("pet_search")
    expect(page).to have_button("Search")

    fill_in("pet_search", with: "#{@pet_2.name}")
    click_button("Search")

    expect(page).to have_content("Name: #{@pet_2.name}")
    expect(page).to have_content("Age: #{@pet_2.age}")
    expect(page).to have_content("Breed: #{@pet_2.breed}")
    expect(page).to have_content("Adoptable: #{@pet_2.adoptable}")
    expect(page).to have_content("Shelter ID: #{@pet_2.shelter_id}")
  end

  it "has a form to submit an application if one or more pets have been added" do # add sad path for this
    visit "/applications/#{@application_1.id}"

    expect(page).to have_field("adoption_description")
    expect(page).to have_button("Submit Application")
  end

  it "removes the add pets section and updates the application status once submitted" do
    visit "/applications/#{@application_1.id}"

    fill_in("adoption_description", with: "I really like this pet")
    click_button("Submit Application")

    expect(page).to have_content(@pet.name)
    expect(page).to have_content("Pending")
    expect(page).to_not have_content("Add a Pet")
    expect(page).to_not have_button("Submit Application")
  end
end