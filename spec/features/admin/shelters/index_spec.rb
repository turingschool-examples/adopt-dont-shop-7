require "rails_helper" 

RSpec.describe "Admin Shelters Index page" do 
  before(:each) do 
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
  end

  it "displays all Shelters in the system listed in reverse alphabetical order" do 
    visit "/admin/shelters"

    expect(page).to have_content("Admin Shelters")
    expect(page).to have_content("Aurora shelter")
    expect(page).to have_content("City: Aurora, CO")
    expect(page).to have_content("Foster Program: false")
    expect(page).to have_content("Rank: 9")
    
    expect(page).to have_content("RGV animal shelter")
    expect(page).to have_content("City: Harlingen, TX")
    expect(page).to have_content("Foster Program: false")
    expect(page).to have_content("Rank: 5")
    
    expect(page).to have_content("Fancy pets of Colorado")
    expect(page).to have_content("City: Denver, CO")
    expect(page).to have_content("Foster Program: false")
    expect(page).to have_content("Rank: 10")

    expect("RGV animal shelter").to appear_before("Fancy pets of Colorado")
    expect("Fancy pets of Colorado").to appear_before("Aurora shelter")
    
    save_and_open_page
  end
end 