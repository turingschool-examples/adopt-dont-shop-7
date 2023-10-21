require 'rails_helper'
RSpec.describe "the application show" do
  before :each do
    shelter = Shelter.create(name: "North Shelter", city: "Irvine CA", foster_program: false, rank: 9)
    @john = Application.create!(name: "John Smith", street_address: "376 Amherst Street", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: "Bruno", status: "In Progress")
    @trevor = Application.create!(name: "Trevor Smith", street_address: "815 Ardsma Ave", city: "Providence", state: "RI", zip_code: "02904", description: "I am a good person.", pet_names: [], status: "In Progress")  
    @bruiser = Pet.create!(adoptable: true, age: 1, breed: "huskey", name: "Bruiser", shelter_id: shelter.id)
    @bruno = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Bruno", shelter_id: shelter.id)
    @trixie = Pet.create!(adoptable: true, age: 7, breed: "pitbull", name: "Trixie", shelter_id: shelter.id)
  end

  # User Story 1, Application Show Page
  it "shows the applications and all of their attributes" do
    
    visit "/applications/#{@john.id}"

    expect(page).to have_content(@john.name)
    expect(page).to have_content(@john.street_address)
    expect(page).to have_content(@john.city)
    expect(page).to have_content(@john.state)
    expect(page).to have_content(@john.zip_code)
    expect(page).to have_content(@john.description)
    expect(page).to have_content(@john.pet_names)
    expect(page).to have_content(@john.status)
  end

  # User Story 4, Searching for Pets for an Application
  it 'Allows search for pet by name' do
    visit "/applications/#{@john.id}"

    expect(page).to have_content("Search for a pet's name")
    expect(page).to have_button("Search")
    
    fill_in "search", with: "Bruno"
    click_button("Search")

    expect(page).to have_content(@bruno.name)
  end

  it 'will not show pets if no search results' do
    visit "/applications/#{@john.id}"

    expect(page).to have_content("Search for a pet's name")
    expect(page).to have_button("Search")
    
    fill_in "search", with: "Lester"
    click_button("Search")

  expect(page).to_not have_content(@bruno.name)
  expect(page).to_not have_content("Lester")
  end

  # # User Story 5, Add a Pet to an Application
  # it 'Allows for pet adoption' do
  #   visit "/applications/#{@john.id}"
  #   fill_in "search", with: "Bru"
  #   click_button("Search")

  #   within(".adopt_#{@bruno.id}") do
  #     expect(page).to have_content "Adopt This Pet"
  #   end
  #   within(".adopt_#{@bruiser.id}") do
  #     expect(page).to have_content "Adopt This Pet"
  #   end

  #   within(".adopt_#{@bruiser.id}") do
  #     click_button("Adopt This Pet")
  #   end

  #   expect(current_path).to eq("/applications/#{application.id}")
  #   expect(page).to have_content(@bruiser.name)
  # end

  # # User Story 6, Submit an Application
  # it 'allows app submission' do
  #   visit "/applications/#{@john.id}"

  #   expect(@john.pet_names).to eq(@bruno)
  #   expect(page).to have_content("Submit Application")
  #   expect(page).to have_content("Please state why you would make a good owner.")

  #   fill_in "Good Owner" with: "I love dogs"

  #   expect(page).to have_button("Submit")

  #   click_button("Submit")

  #   expect(current_path).to eq("/applications/#{@john.id}")
  #   expect(page).to have_content("Pending")
  #   expect(page).to have_content(@bruno.name)
  #   expect(page).to_not have_content(@trixie.name)
  # end

  # # User Story 7, No Pets on an Application
  # it 'does not have section to submit app if no pets added' do
  #   visit "/applications/#{@trevor.id}"

  #   expect(@trevor.pet_names).to eq([])
  #   expect(page).to_not have_content("Submit Application")
  # end

  # # User Story 8, Partial Matches for Pet Names
  # it 'Alows search for pet by name partial matches' do
  #   visit "/applications/#{@john.id}"

  #   expect(page).to have_field("Enter a Pet's Name")
  #   expect(page).to have_button("Search By Name")
    
  #   fill_in "search", with: "Bru"
  #   click_button("Search")

  #   expect(page).to have_content(@bruno.name)
  #   expect(page).to have_content(@bruiser.name)
  # end

  # # User Story 9, Case Insensitive Matches for Pet Names
  # describe 'Case Insensitive Matches for Pet Names' do
  #   it 'Alows search for pet by name all upcase' do
  #     visit "/applications/#{@john.id}"

  #     expect(page).to have_field("Enter a Pet's Name")
  #     expect(page).to have_button("Search By Name")
      
  #     fill_in "search", with: "BRU"
  #     click_button("Search")

  #     expect(page).to have_content(@bruno.name)
  #     expect(page).to have_content(@bruiser.name)
  #   end

  #   it 'Alows search for pet by name all lowercase' do
  #     visit "/applications/#{@john.id}"

  #     expect(page).to have_field("Enter a Pet's Name")
  #     expect(page).to have_button("Search By Name")
      
  #     fill_in "search", with: "bru"
  #     click_button("Search")

  #     expect(page).to have_content(@bruno.name)
  #     expect(page).to have_content(@bruiser.name)
  #   end

  #   it 'Alows search for pet by name case insensitive' do
  #     visit "/applications/#{@john.id}"

  #     expect(page).to have_field("Enter a Pet's Name")
  #     expect(page).to have_button("Search By Name")
      
  #     fill_in "search", with: "BrU"
  #     click_button("Search")

  #     expect(page).to have_content(@bruno.name)
  #     expect(page).to have_content(@bruiser.name)
  #   end
  # end
end