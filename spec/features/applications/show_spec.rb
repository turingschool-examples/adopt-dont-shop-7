require "rails_helper"

RSpec.describe "the applications show page" do
  before(:each) do
    @shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    @pet1 = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: @shelter.id)
    @pet2 = Pet.create!(name: "Scrappy", age: 1, breed: "Not So Great Dane", adoptable: true, shelter_id: @shelter.id)
    @pet3 = Pet.create!(name: "Blue", age: 3, breed: "Blue Dog", adoptable: true, shelter_id: @shelter.id)
    @app1 = Application.create!(name: "Shaggy",
                                street_address: "1234 Bobs rd",
                                city: "Denver",
                                state: "Colorado",
                                zip_code: "80220",
                                description: "I want a dog!",
                                status: "In Progress")
    @app2 = Application.create!(name: "Fred",
                                street_address: "1234 Fred rd",
                                city: "Boulder",
                                state: "Colorado",
                                zip_code: "80221",
                                description: "I NEED a dog!",
                                status: "In Progress")
    PetApplication.create!(application: @app1, pet: @pet1)
    PetApplication.create!(application: @app1, pet: @pet2) 
  end

  # User Story 1
  it "shows the applications show page with all it's attributes" do
    visit "/applications/#{@app1.id}"

    expect(page).to have_content("Applicant Name: #{@app1.name}")
    expect(page).to have_content("Street Address: #{@app1.street_address}")
    expect(page).to have_content("City: #{@app1.city}")
    expect(page).to have_content("State: #{@app1.state}")
    expect(page).to have_content("Zip Code: #{@app1.zip_code}")
    expect(page).to have_content("Description: #{@app1.description}")
    expect(page).to have_content("Status: #{@app1.status}")

    expect(page).to_not have_content(@pet3.name)

    click_link(@pet1.name)
    expect(current_path).to eq "/pets/#{@pet1.id}"

    visit "/applications/#{@app1.id}"

    click_link(@pet2.name)
    expect(current_path).to eq "/pets/#{@pet2.id}"
  end

  # User Story 4
  it "can search for pets to add to the application" do 
    visit "/applications/#{@app1.id}"

    within("#pets_on_application") do 
      expect(page).to have_content("Scooby")
      expect(page).to have_content("Scrappy")
      expect(page).to_not have_content("Blue")
    end

    within("#add_pets") do 
      expect(page).to have_content("Add a Pet to This Application")
      fill_in "search_by_name", with: "Blue"
      click_button "Submit"
    end

    expect(current_path).to eq "/applications/#{@app1.id}"
    
    within("#search_results") do 
      expect(page).to have_content("Blue")
    end
  end

  # User Story 5
  it "adds a pet to an application" do
    visit "/applications/#{@app1.id}"

    within("#pets_on_application") do 
      expect(page).to have_content("Scooby")
      expect(page).to have_content("Scrappy")
      expect(page).to_not have_content("Blue")
    end

    within("#add_pets") do 
      fill_in "search_by_name", with: "Blue"
      click_button "Submit"
    end

    expect(current_path).to eq "/applications/#{@app1.id}"

    within("#search_results") do 
      expect(page).to have_content("Blue")
      click_button "Adopt This Pet"
    end

    expect(current_path).to eq "/applications/#{@app1.id}"

    within("#pets_on_application") do 
      expect(page).to have_content("Scooby")
      expect(page).to have_content("Scrappy")
      expect(page).to have_content("Blue")
    end
  end

  # User Story 6
  it "submits an application" do
    visit "/applications/#{@app1.id}"
    
    within("#add_pets") do 
      fill_in "search_by_name", with: "Blue"
      click_button "Submit"
    end

    expect(current_path).to eq "/applications/#{@app1.id}"

    within("#search_results") do
      expect(page).to have_content("Blue")
      click_button "Adopt This Pet"
    end

    expect(current_path).to eq "/applications/#{@app1.id}"
  
    within("#submit_application") do
      fill_in "why_good_owner", with: "I want a dog!"
      click_button "Submit"
    end

    expect(current_path).to eq "/applications/#{@app1.id}"
    expect(page).to have_content("Status: Pending")

    within("#pets_on_application") do 
      expect(page).to have_content("Scooby")
      expect(page).to have_content("Scrappy")
      expect(page).to have_content("Blue")
    end
    expect(page).to_not have_content("Add a Pet to This Application")
  end

  # User Story 7
  it "does not let you submit if there are no pets on the application" do 
    visit "/applications/#{@app2.id}"

    within("#submit_application") do
      expect(page).to_not have_content("Submit")
    end
  end

  # User Story 8
  it "shows partial matches for pet names" do
    visit "/applications/#{@app1.id}"

    within("#add_pets") do 
      fill_in "search_by_name", with: "Sc"
      click_button "Submit"
    end

    expect(current_path).to eq "/applications/#{@app1.id}"

    within("#search_results") do
      expect(page).to have_content("Scooby")
      expect(page).to have_content("Scrappy")
      expect(page).to_not have_content("Blue")
    end
  end

  # User Story 9
  it " shows pet name matches without being case sensitive" do
    visit "/applications/#{@app1.id}"

    within("#add_pets") do 
      fill_in "search_by_name", with: "bL"
      click_button "Submit"
    end

    expect(current_path).to eq "/applications/#{@app1.id}"

    within("#search_results") do
      expect(page).to have_content("Blue")
      expect(page).to_not have_content("Scooby")
      expect(page).to_not have_content("Scrappy")
    end
  end
end