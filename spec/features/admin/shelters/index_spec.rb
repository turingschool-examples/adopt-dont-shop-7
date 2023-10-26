require "rails_helper"

RSpec.describe "Admin Shelter Index" do 
  before(:each) do 
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 3) 
    @shelter_2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
   end

  it "shows all Shelters in the system in reverse alphabetical order by name" do
    
    visit "/admin/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_3.name) 
    expect(@shelter_3.name).to appear_before(@shelter.name)

    save_and_open_page
  end
end 