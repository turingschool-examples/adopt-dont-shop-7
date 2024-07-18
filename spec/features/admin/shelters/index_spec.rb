require "rails_helper"

RSpec.describe "the admin shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_2.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_3.pets.create!(name: "Dozer", breed: "pitbull", age: 4, adoptable: true)

    @application1 = Application.create!(name: "Joe Baeza", street_address: "12345 Joe Street", city: "Irvine", state: "CA", zip_code: "54321",
                                        description: "I like Clawdia so I want to adopt them.", status: "In Progress")
    @application2 = Application.create!(name: "Billy Bob", street_address: "56789 The Bob Street", city: "Boulder", state: "CO", zip_code: "09876",
                                        description: "I'll go for Mr. Pirate since that name sounds sick.", status: "Pending")
    @application3 = Application.create!(name: "The Guy", street_address: "111111 The Guy Avenue", city: "Seattle", state: "WA", zip_code: "29212",
                                        description: "Lucille Bald looks like a sphynx and I think I am a sphynx kind of guy.", status: "Pending")

    @pet_application1 = PetApplication.create!(application: @application1, pet: @pet_2)
    @pet_application2 = PetApplication.create!(application: @application2, pet: @pet_1)
    @pet_application3 = PetApplication.create!(application: @application3, pet: @pet_3)
  end

  it "displays the sort of view to the user" do
    visit "/admin/shelters"
    expect(page).to have_content("This is the Admin view")
  end

  it "lists all the shelter names in reverse alphabetical order" do
    visit "/admin/shelters"
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
    expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
    
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  # it "has a link to sort shelters by the number of pets they have" do
  #   visit "/admin/shelters"

  #   expect(page).to have_link("Sort by number of pets")
  #   click_link("Sort by number of pets")

  #   expect(page).to have_current_path("/shelters?sort=pet_count")
  #   expect(@shelter_3.name).to appear_before(@shelter_1.name)
  #   expect(@shelter_2.name).to appear_before(@shelter_1.name)
  # end

  it "has a link to update each shelter" do
    visit "/admin/shelters"

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Update #{@shelter_1.name}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_link("Update #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_link("Update #{@shelter_3.name}")
    end

    click_on("Update #{@shelter_1.name}")
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/edit")
  end

  it "has a link to delete each shelter" do
    visit "/admin/shelters"

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Delete #{@shelter_1.name}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_link("Delete #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_link("Delete #{@shelter_3.name}")
    end

    click_on("Delete #{@shelter_1.name}")
    expect(page).to have_current_path("/shelters")
    expect(page).to_not have_content(@shelter_1.name)
  end

  it "has a text box to filter results by keyword" do
    visit "/admin/shelters"
    expect(page).to have_button("Search")
  end

  it "lists partial matches as search results" do
    visit "/admin/shelters"

    fill_in "Search", with: "RGV"
    click_on("Search")

    expect(page).to have_content(@shelter_2.name)
    expect(page).to_not have_content(@shelter_1.name)
  end

  describe "displays a section for shelters with pending applications" do
    it "in this section I see the name of every shelter that has a pending application" do
      visit "/admin/shelters"
      
      expect(page).to have_content("Shelters with Pending Applications")

      within "#shelters-pending-application" do
        expect(page).to have_content("#{@shelter_3.name}")
        expect(page).to_not have_content("#{@shelter_1.name}")
        expect(page).to_not have_content("#{@shelter_2.name}")
      end
    end
  end
end
