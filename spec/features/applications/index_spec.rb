require "rails_helper"

RSpec.describe "application" do
  before do
    @application_1 = Application.create!(name: "Selena", street_address: "123 Street", city: "City", state: "State", zip_code: "8888", adopting_reason: "Love for cats, no job", status:"Pending")
    @application_2 = Application.create!(name: "Laura", street_address: "58 Street", city: "City", state: "State", zip_code: "5555", adopting_reason: "Need company", status:"Rejected")
    @application_3 = Application.create!(name: "Isaac", street_address: "456 Street", city: "City", state: "State", zip_code: "8878", adopting_reason: "Lots of love to give", status:"Accepted")
    @application_4 = Application.create!(name: "Mark", street_address: "889 Folsom Ave", city: "Denver", state: "CO", zip_code: "80024", adopting_reason: "Lonely", status:"Pending")
  end

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

  it "returns the correct number of applications" do
    visit "/applications"

    expect(page).to have_content("Applications total: 4")
  end
  
  it "lists all the applications with their attributes" do
    visit "/applications"

    within "#application-#{@application_1.id}" do
      expect(page).to have_content("Selena")
      expect(page).to have_content("123 Street, City, State, 8888")
      expect(page).to have_content("Love for cats, no job")
      expect(page).to have_content("Pending")
    end
    within "#application-#{@application_2.id}" do
      expect(page).to have_content("Laura")
      expect(page).to have_content("Rejected")
    end
  end

  it "displays a link to edit each application" do
    visit "/applications"

    expect(page).to have_content("Edit #{@application_1.name}")
    expect(page).to have_content("Edit #{@application_2.name}")

    click_link("Edit #{@application_1.name}")

    expect(page).to have_current_path("/applications/#{@application_1.id}")
  end

  it "displays a link to delete each application" do
    visit "/applications"
    save_and_open_page
    within "#application-#{@application_1.id}" do

      click_link("Delete application")
    end

    expect(current_path).to eq("/applications")
    expect(page).to_not have_content(@application_1.name)
  end
end
