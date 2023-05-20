require 'rails_helper'

RSpec.describe "Application Show Page", type: :feature do
  before(:each) do
    test_data
  end

  describe "Application Show Page /applications/:id" do
    describe "I can see the following:" do
      it "can show applicant name and other attributes" do
        visit "/applications/#{@application_1.id}"
        
        expect(page).to have_content("Applicant Name: #{@application_1.name}")
        expect(page).to have_content("Street Address: #{@application_1.street_address}")
        expect(page).to have_content("City: #{@application_1.city}")
        expect(page).to have_content("State: #{@application_1.state}")
        expect(page).to have_content("Zip Code: #{@application_1.zip_code}")
        expect(page).to have_content("Description: #{@application_1.description}")
        expect(page).to have_content("Status: #{@application_1.status}")
        
        visit "/applications/#{@application_2.id}"
        
        expect(page).to have_content("Applicant Name: #{@application_2.name}")
        expect(page).to have_content("Street Address: #{@application_2.street_address}")
        expect(page).to have_content("City: #{@application_2.city}")
        expect(page).to have_content("State: #{@application_2.state}")
        expect(page).to have_content("Zip Code: #{@application_2.zip_code}")
        expect(page).to have_content("Description: #{@application_2.description}")
        expect(page).to have_content("Status: #{@application_2.status}")
      end
      
      it "each pet name is a link to their show page" do
        visit "/applications/#{@application_1.id}"
        click_link("#{@pet_2.name}")
        expect(current_path).to eq("/pets/#{@pet_2.id}")
        
        visit "/applications/#{@application_2.id}"
        click_link("#{@pet_1.name}")
        expect(current_path).to eq("/pets/#{@pet_1.id}")
        
        visit "/applications/#{@application_3.id}"
        click_link("#{@pet_5.name}")
        expect(current_path).to eq("/pets/#{@pet_5.id}")
      end
    end
    
    describe "Searching for Pets for an Application" do
      it "has a search function on page to 'Add a Pet to this Application'" do
        visit "/applications/#{@application_1.id}"
        
        within "#pet_search" do
          expect(page).to have_content("Add a Pet to this Application")
          expect(page).to have_field("Search Pet")
          
          fill_in("Search Pet", with: "Pepper")
          click_button("Search")
          
          expect(current_path).to eq("/applications/#{@application_1.id}")
          
          expect(page).to have_content("#{@pet_5.name}")
        end
        
        visit "/applications/#{@application_2.id}"
        within "#pet_search" do
          expect(page).to have_content("Add a Pet to this Application")
          expect(page).to have_field("Search Pet")
          
          fill_in("Search Pet", with: "Marshall")
          click_button("Search")
          
          expect(current_path).to eq("/applications/#{@application_2.id}")
          
          expect(page).to have_content("#{@pet_4.name}")
        end
      end
    end
    
    describe "Adding pet to application after search" do
      it "can add a pet to an application" do
        visit "/applications/#{@application_1.id}"
        fill_in("Search Pet", with: "Pepper")
        click_button("Search")
        
        expect(page).to have_content(@pet_5.name)
        expect(page).to have_button("Adopt This Pet")
        
        click_button("Adopt This Pet")
        
        expect(current_path).to eq("/applications/#{@application_1.id}")
        expect(page).to have_content(@pet_5.name)
        expect(page).to_not have_button("Adopt This Pet")
      end
    end
  end
end