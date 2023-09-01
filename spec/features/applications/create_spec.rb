require "rails_helper"

RSpec.describe "Create Application" do
  it "is linked from the pet index page" do
    visit "/pets"

    # save_and_open_page
    
    click_link "Start an Application"

    expect(current_path).to eq("/application/new")
  end

  it "has a for that includes these attributes" do
    visit "/application/new"

    
end