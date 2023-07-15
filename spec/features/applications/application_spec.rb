require "rails_helper"

RSpec.describe "application" do
  it "displays a link to all pets" do
    visit "/"
    expect(page).to have_content("Adopt, don't shop!")
    expect(page).to have_link("Pets")
    click_link("Pets")
    expect(page).to have_current_path("/pets")
  end

  it "displays a link to all shelters" do
    visit "/"

    expect(page).to have_link("Shelters")
    click_link("Shelters")
    expect(page).to have_current_path("/shelters")
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it "displays a link to all veterinary offices" do
    visit "/"

    expect(page).to have_link("Veterinary Offices")
    click_link("Veterinary Offices")
    expect(page).to have_current_path("/veterinary_offices")
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it "displays a link to all veterinarians" do
    visit "/"

    expect(page).to have_link("Veterinarians")
    click_link("Veterinarians")
    expect(page).to have_current_path("/veterinarians")
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it "displays a link to specfic pets" do
    @shelter_1 = Shelter.create!(foster_program: true, name: "Denver Animal Shelter", city: "Denver", rank: 1)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter_1.id)
    @application_1 = Application.create!(name_of_applicant: "Matt Lim", street_address: "1234 Example St", city: "Denver", state: "CO", zip_code: 80202, description: "I love animals", pet_names: "Lucille Bald", application_status: "Pending", shelter_id: @shelter_1.id)
    @application_2 = Application.create!(name_of_applicant: "Jorja Fleming", street_address: "5678 Sample St", city: "Denver", state: "CO", zip_code: 80202, description: "I am lonely and need cats", pet_names:"Fido", application_status: "Pending", shelter_id: @shelter_1.id)
    @application_1.pets << @pet_1

    visit "/applications/#{@application_1.id}"
    
    expect(page).to have_content("Matt Lim")
    save_and_open_page

    click_link 'Lucille Bald'
    expect(page).to have_current_path("/applications/pets/#{@pet_1.id}")


    
    # visit "/pets"
    # expect(page).to have_link("Lucille Bald")
    # save_and_open_page

    # click_link 'Lucille Bald'
    # expect(have_current_path).to eq("/pets/1")

  end
end
