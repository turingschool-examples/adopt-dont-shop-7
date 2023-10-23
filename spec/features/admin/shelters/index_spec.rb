require 'rails_helper'

RSpec.describe "Admin Index Page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
  end

  # USER STORY 10
  it "lists all the shelter names in reverse alphabetical order" do
    visit "/admin/shelters"
    save_and_open_page
    first = find("#shelter-#{@shelter_2.id}")
    second = find("#shelter-#{@shelter_3.id}")
    third = find("#shelter-#{@shelter_1.id}")
    expect(first).to appear_before(second)
    expect(second).to appear_before(third)
  end
  # RAW SQL - in shelter model
  # def self.order_by_reverse_alphabetical
  # find_by_sql("SELECT * FROM shelters ORDER BY name DESC")

  # in shelter controller inside of admin subdir
  # def index 
  #   @shelters = Shelter.order_by_reverse_alphabetical
end
