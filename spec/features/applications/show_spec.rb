require "rails_helper"

RSpec.describe "the application show page" do
  it "shows the application and all its attributes" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because Scoob and I love Scooby Snacks")
    pet = applicant.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"

    expect(page).to have_content(applicant.name)
    expect(page).to have_content(applicant.street_address)
    expect(page).to have_content(applicant.city)
    expect(page).to have_content(applicant.state)
    expect(page).to have_content(applicant.zip_code)
    expect(page).to have_content(applicant.description)
    expect(page).to have_content(applicant.status)
  end

  it "shows pets associated with applicant" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because Scoob and I love Scooby Snacks")
    pet = applicant.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"

    expect(page).to have_content(pet.name)
  end

  it "links to pets show page" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because Scoob and I love Scooby Snacks")
    pet = applicant.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"

    click_link("Scooby")

    expect(current_path).to eq("/pets/#{pet.id}")
  end

  it "shows a pets search field" do 
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because Scoob and I love Scooby Snacks")
    pet = applicant.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"
    
    expect(page).to have_content("Search for a pet to add")
    
  end

  
  it "shows pets matching user search input" do 
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
    pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"
    # save_and_open_page
    fill_in "Search", with: "scoob"

    click_button "Search"
    save_and_open_page
    expect(page).to have_content("Scooby")
    
  end

  it 'shows a link to adopt a pet under each shown pet' do 
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
    pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"
    fill_in "Search", with: "scoob"
    
    click_button "Search"
    # save_and_open_page
    # save_and_open_page
    expect(page).to have_button("Adopt Scooby")
    
  end

  it "shows added pets to the application" do 
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
    pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"
    fill_in "Search", with: "scoob"
    
    click_button "Search"
    click_button "Adopt #{pet.name}"
    
    visit "/applications/#{applicant.id}"
    
    fill_in "Search", with: "z"
    click_button "Search"
    expect(page).to have_content("Scooby")
    save_and_open_page
  end

  it "shows a section to explain why I'd make a good owner if I have chosen pets to adopt (US-6)" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
    pet = applicant.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"

    expect(page).to have_content("Why would you be a good owner")
    expect(page).to have_field("Why would you be a good owner to the pet(s)?")
  end
  
  it "does NOT show a section to explain why I'd make a good owner if I have NOT chosen pets to adopt (US-7)" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
    pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"

    expect(page).to_not have_content("Why would you be a good owner")
    expect(page).to_not have_field("Why would you be a good owner")
  end

  it "shows a 'Submit Application' button if I have chosen pets to adopt (US-6)" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
    pet = applicant.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"

    expect(page).to have_button("Submit Application")
  end
  
  it "does NOT show a 'Submit Application' button if I have chosen pets to adopt (US-7)" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
    pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"

    expect(page).to_not have_button("Submit Application")
  end

  it "shows applicant's changed status from In Progress to Pending after application is submitted" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
    pet = applicant.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"

    expect(page).to have_content("In Progress")

    fill_in "Why would you be a good owner to the pet(s)?", with: "because I loooove them"
    click_button "Submit Application"

    expect(page).to have_content("Pending")

  end

  it "does NOT show section to add more pets to the application if application status is Pending" do
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
    pet = applicant.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
    cat = Pet.create(name: "Catdog", age: 4, breed: "Calico", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"

    fill_in "Why would you be a good owner to the pet(s)?", with: "because I loooove them"
    click_button "Submit Application"

    expect(page).to_not have_content("Search for a pet to add")
    expect(page).to_not have_button("Adopt Catdog")
  end

  it " Successfully searches pets with partial inputs " do 
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
    pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"
    # save_and_open_page
    fill_in "Search", with: "oob"

    click_button "Search"
    # save_and_open_page
    expect(page).to have_content("Scooby")
    
  end

  it " Successfully searches pets with case insensitive inputs" do 
    shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
    applicant = Application.create(name: "Shaggy", street_address: "123 Mystery Lane", city: "Irvine", state: "CA", zip_code: "91010", description: "Because ")
    pet = Pet.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{applicant.id}"
    # save_and_open_page
    fill_in "Search", with: "SCoOb"

    click_button "Search"
    # save_and_open_page
    expect(page).to have_content("Scooby")
  end
  # it "allows the user to delete a pet" do
  #   shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
  #   pet = Pet.create(name: "Scrappy", age: 1, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)

  #   visit "/pets/#{pet.id}"

  #   click_on("Delete #{pet.name}")

  #   expect(page).to have_current_path("/pets")
  #   expect(page).to_not have_content(pet.name)
  # end
end
