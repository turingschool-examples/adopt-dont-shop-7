require 'rails_helper'

RSpec.describe 'admin shelter index', type: :feature do
  describe 'As a visitor' do
    before(:each) do
    @shel_1 = Shelter.create(name: "C. Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shel_2 = Shelter.create(name: "B. RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shel_3 = Shelter.create(name: "A. Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shel_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @shel_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @shel_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    end

    # SQL Only Story
    # 10. Admin Shelters Index
    it 'lists all shelters in reverse alpha order' do
      # For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql
      # When I visit the admin shelter index ('/admin/shelters')
      visit '/admin/shelters'
      # Then I see all Shelters in the system listed in reverse alphabetical order by name
      expect(@shel_1.name).to appear_before(@shel_2.name)
      expect(@shel_1.name).to appear_before(@shel_3.name)
      
      expect(@shel_2.name).to appear_before(@shel_3.name)
      expect(@shel_2.name).to_not appear_before(@shel_1.name)
      
      expect(@shel_3.name).to_not appear_before(@shel_1.name)
      expect(@shel_3.name).to_not appear_before(@shel_2.name)
    end
  end
end