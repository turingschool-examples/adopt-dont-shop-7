require "rails_helper"

RSpec.describe "Admin view of shelters index" do
  before do
    @happy_tails = Shelter.create!(name: "Happy Tails", foster_program: true, city: "San Francisco", rank: 3)
    @apple_of_my_eye = Shelter.create!(name: "Apple of My Eye", foster_program: false, city: "Austin", rank: 5)
    @sunnyside = Shelter.create!(name: "Sunnyside", foster_program: false, city: "Boulder", rank: 2)
  end
# For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql

# 10. Admin Shelters Index

# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see all Shelters in the system listed in reverse alphabetical order by name

  it "shows all shelters in reverse alphabetical order by name" do
    visit "/admin/shelters"

    expect("Sunnyside").to appear_before("Happy Tails")
    expect("Happy Tails").to appear_before("Apple of My Eye")
  end

  # Routes in the admin/shelters index for updating or deleting a shelter
  # will route back to the main shelters page, not admin/shelters
  # Technically the user story does not say we need anything other than names for the admin
  # so we could delete all the links and not worry about it
  # But realistically the admin should be able to do everthing a visitor can do + more
  # ....so we COULD create routes for admin/(every other route)
  # which would completely double the length of our route file
  # so not really in our best interest at the moment, for the purposes of this project
  # but is something to consider

end