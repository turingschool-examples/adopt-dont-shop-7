require "rails_helper"

RSpec.describe "the application show" do

  before :each do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @application1 = Application.create!(name: "Mike", full_address: "9999 Street Road, Denver, CO 80231", good_home: "Gimme", good_owner: "one eyed cats!!", status: "Pending")
    @application2 = Application.create!(name: "Eric", full_address: "888 Road Street, Salt Lake City, UT 88231", good_home: "5 solid meals a day", good_owner: "I woudln't", status: "Rejected")
    @application3 = Application.create!(name: "Billy", full_address: "777 Circle Court, Houston, TX 77000", good_home: "Best Day Every Day", status: "In Progress")
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: @shelter.id)
    @pet_4 = Pet.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false, shelter_id: @shelter.id)
    @pet_5 = Pet.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true, shelter_id: @shelter.id)
    @pet_6 = Pet.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true, shelter_id: @shelter.id)

    @application1.pets << @pet_1 
    @application1.pets << @pet_2 
    @application2.pets << @pet_2 
    @application2.pets << @pet_3 
  end

  it "shows the application and all it's attributes" do

    visit "/applications/#{@application1.id}"

    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application1.full_address)
    expect(page).to have_content(@application1.good_home)
    expect(page).to have_content(@application1.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)

  end
  
  it "Names of pets are links that lead to the pet show page" do

    visit "/applications/#{@application1.id}"
    
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    click_link(@pet_1.name)
    expect(current_path).to eq("/pets/#{@pet_1.id}")
    visit "/applications/#{@application1.id}"
    click_link(@pet_2.name)
    expect(current_path).to eq("/pets/#{@pet_2.id}")

  end

  it "Can search and returns names to add pets to application" do
    visit "/applications/#{@application3.id}"

    expect(page).to have_content(@application3.name)
    expect(page).to have_content(@application3.full_address)
    expect(page).to have_content(@application3.good_home)
    expect(page).to have_content(@application3.status)

    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_button("Search")

    fill_in(:search, with: "Clawdia")
    expect(page).to_not have_content("Results:")
    click_button("Search")

    expect(current_path).to eq("/applications/#{@application3.id}")
    expect(page).to have_content("Results:")
    expect(page).to have_content("Clawdia")
  end

  it "Can add pets found by search result to an application" do
    visit "/applications/#{@application3.id}"
    expect(page).to_not have_content("Clawdia")
    fill_in(:search, with: "Clawdia")
    click_button("Search")
    expect("Add a Pet to this Application").to appear_before("Clawdia")
    expect("Clawdia").to appear_before("Adopt this Pet")
    click_button("Adopt this Pet")
    # click_link("Adopt this Pet")
    expect(current_path).to eq("/applications/#{@application3.id}")
    expect("Clawdia").to appear_before("Add a Pet to this Application")
  end

  it "Cannot add a pet that has already been added" do
    visit "/applications/#{@application3.id}"
    expect(page).to_not have_content("Already on Application")
    fill_in(:search, with: "Clawdia")
    click_button("Search")
    click_button("Adopt this Pet")
    # click_link("Adopt this Pet")
    expect(page).to_not have_content("Already on Application")
    fill_in(:search, with: "Clawdia")
    click_button("Search")
    click_button("Adopt this Pet")
    expect(page).to have_content("Already on Application")

  end
  
  it "Add reason on why I would be a good parent and allows to submit application" do
    @application3.pets << @pet_4
    @application3.pets << @pet_5
    visit "/applications/#{@application3.id}"
    expect(@application3.pets).to eq([@pet_4, @pet_5])
    expect("Mr. Pirate").to appear_before("Clawdia")
    
    expect(page).to have_content("Why would I make a good owner for these pet(s)?")
    expect(page).to have_button("Submit Application")
    expect(@application3.status).to eq("In Progress")
    fill_in(:good_owner, with: "I like cats")
    click_button("Submit Application")
    expect(current_path).to eq("/applications/#{@application3.id}")
    expect(page).to have_content("Why would I make a good owner for these pet(s)?: I like cats")
    expect(page).to have_content("Pending")
  end
  
  it "The field and button to submit are not shown if there are not pets on the application" do
    
    visit "/applications/#{@application3.id}"
    expect(@application3.pets).to eq([])
    
    expect(page).to_not have_content("Finalize Application")
    expect(page).to_not have_button("Submit Application")
    expect(@application3.status).to eq("In Progress")
  end

  it "When visiting a page as an admin, I see a button to accept an application" do
    visit "/applications/#{@application1.id}"
    expect(page).to_not have_content("Approve Application for #{@pet_1.name}")
    expect(page).to_not have_content("Approve Application for #{@pet_2.name}")

    visit "/admin/applications/#{@application1.id}"
    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application1.full_address)
    expect(page).to have_content(@application1.good_home)
    expect(page).to have_content(@application1.good_owner)
    expect(page).to have_content(@application1.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to_not have_content("Finalize Application")
    expect(page).to_not have_button("Submit Application")
    expect(page).to_not have_content("Add a Pet to this Application")
    expect(page).to have_button("Approve Application for #{@pet_1.name}")
    expect(page).to have_button("Approve Application for #{@pet_2.name}")
  end

  it "As an admin, I can click to accept an application, and I wil be shown that the application is accepted on this page" do
    visit "/admin/applications/#{@application1.id}"
    expect(page).to_not have_content("Adoption of #{@pet_1.name} has been approved")
    expect(page).to_not have_content("Adoption of #{@pet_2.name} has been approved")
    click_button("Approve Application for #{@pet_1.name}")
    expect(current_path).to eq("/admin/applications/#{@application1.id}")
    expect(page).to have_content("Adoption of #{@pet_1.name} has been approved")
    expect(page).to_not have_content("Adoption of #{@pet_2.name} has been approved")
    click_button("Approve Application for #{@pet_2.name}")
    expect(current_path).to eq("/admin/applications/#{@application1.id}")
    expect(page).to have_content("Adoption of #{@pet_1.name} has been approved")
    expect(page).to have_content("Adoption of #{@pet_2.name} has been approved")
  end

  it "When visiting a page as an admin, I see a button to accept an application" do
    visit "/applications/#{@application1.id}"
    expect(page).to_not have_content("Reject Application for #{@pet_1.name}")
    expect(page).to_not have_content("Reject Application for #{@pet_2.name}")

    visit "/admin/applications/#{@application1.id}"
    expect(page).to have_button("Reject Application for #{@pet_1.name}")
    expect(page).to have_button("Reject Application for #{@pet_2.name}")
  end

  it "As an admin, I can click to accept an application, and I wil be shown that the application is accepted on this page" do
    visit "/admin/applications/#{@application1.id}"
    expect(page).to_not have_content("Adoption of #{@pet_1.name} has been rejected")
    expect(page).to_not have_content("Adoption of #{@pet_2.name} has been rejected")
    click_button("Reject Application for #{@pet_1.name}")
    expect(current_path).to eq("/admin/applications/#{@application1.id}")
    expect(page).to have_content("Adoption of #{@pet_1.name} has been rejected")
    expect(page).to_not have_content("Adoption of #{@pet_2.name} has been rejected")
    click_button("Reject Application for #{@pet_2.name}")
    expect(current_path).to eq("/admin/applications/#{@application1.id}")
    expect(page).to have_content("Adoption of #{@pet_1.name} has been rejected")
    expect(page).to have_content("Adoption of #{@pet_2.name} has been rejected")
  end

  it "Accepting a pet on one application will not affect it's status on other applications" do
    visit "/admin/applications/#{@application2.id}"
    expect(page).to have_button("Approve Application for #{@pet_2.name}")
    expect(page).to have_button("Reject Application for #{@pet_2.name}")
    expect(page).to_not have_content("Adoption of #{@pet_2.name} has been approved")
    expect(page).to_not have_content("Adoption of #{@pet_2.name} has been rejected")
    visit "/admin/applications/#{@application1.id}"
    click_button("Approve Application for #{@pet_2.name}")
    visit "/admin/applications/#{@application2.id}"
    expect(page).to have_button("Approve Application for #{@pet_2.name}")
    expect(page).to have_button("Reject Application for #{@pet_2.name}")
    expect(page).to_not have_content("Adoption of #{@pet_2.name} has been approved")
    expect(page).to_not have_content("Adoption of #{@pet_2.name} has been rejected")
    click_button("Approve Application for #{@pet_2.name}")
    expect(page).to_not have_button("Approve Application for #{@pet_2.name}")
    expect(page).to_not have_button("Reject Application for #{@pet_2.name}")
    expect(page).to have_content("Adoption of #{@pet_2.name} has been approved")
    expect(page).to_not have_content("Adoption of #{@pet_2.name} has been rejected")
    visit "/admin/applications/#{@application1.id}"
    expect(page).to have_content("Adoption of #{@pet_2.name} has been approved")
  end

  it "Rejcting a pet on one application will not affect it's status on other applications" do
    visit "/admin/applications/#{@application1.id}"
    click_button("Reject Application for #{@pet_2.name}")
    visit "/admin/applications/#{@application2.id}"
    expect(page).to have_button("Approve Application for #{@pet_2.name}")
    expect(page).to have_button("Reject Application for #{@pet_2.name}")
    expect(page).to_not have_content("Adoption of #{@pet_2.name} has been approved")
    expect(page).to_not have_content("Adoption of #{@pet_2.name} has been rejected")
    click_button("Approve Application for #{@pet_2.name}")
    expect(page).to_not have_button("Approve Application for #{@pet_2.name}")
    expect(page).to_not have_button("Reject Application for #{@pet_2.name}")
    expect(page).to have_content("Adoption of #{@pet_2.name} has been approved")
    expect(page).to_not have_content("Adoption of #{@pet_2.name} has been rejected")
    visit "/admin/applications/#{@application1.id}"
    expect(page).to have_content("Adoption of #{@pet_2.name} has been rejected")
  end

  it "As an admin, approving all pets on an application will change the status of an application to 'Approved'" do
    visit "/admin/applications/#{@application1.id}"
    click_button("Approve Application for #{@pet_1.name}")
    expect(page).to have_content("Pending")
    click_button("Approve Application for #{@pet_2.name}")
    expect(page).to_not have_content("Pending")
    expect(page).to have_content("Application Status: Approved")
  end

  it "As an admin, rejecting any pet on an application will change the status of an application to 'Rejected'" do
    @application1.pets << @pet_3
    visit "/admin/applications/#{@application1.id}"
    click_button("Approve Application for #{@pet_1.name}")
    expect(page).to have_content("Pending")
    click_button("Approve Application for #{@pet_2.name}")
    expect(page).to have_content("Pending")
    click_button("Reject Application for #{@pet_3.name}")
    expect(page).to have_content("Application Status: Rejected")
  end

  it "As an admin, rejecting any pet on an application will change the status of an application to 'Rejected' (different order)" do
    @application1.pets << @pet_3
    visit "/admin/applications/#{@application1.id}"
    click_button("Reject Application for #{@pet_1.name}")
    expect(page).to have_content("Application Status: Rejected")
    click_button("Approve Application for #{@pet_2.name}")
    expect(page).to have_content("Application Status: Rejected")
    click_button("Reject Application for #{@pet_3.name}")
    expect(page).to have_content("Application Status: Rejected")
  end
end
