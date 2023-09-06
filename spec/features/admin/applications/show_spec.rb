require "rails_helper"

RSpec.describe "Admin Applications Show Page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)

    @cory = Application.create!(name:"Cory", street_address: "385 N Billups st.", city: "Athen", state: "GA", zipcode:"30606", description:"Extremely normal and can be trusted", status:"Pending" )
    @antoine = Application.create!(name:"Antoine", street_address: "1244 Windsor Street", city: "Salt Lake City", state: "UT", zipcode:"84105", description:"need to strengthen fingers through petting", status:"Pending" )
    @jeff = Application.create!(name:"Jeff", street_address: "1244 Windsor Street", city: "Salt Lake City", state: "UT", zipcode:"84105", description:"need to strengthen fingers through petting", status:"Pending" )

    @pet_applications_1 = PetApplication.create!(pet_id: "#{@pet_1.id}", application_id: "#{@cory.id}", status: "Pending" )
    @pet_applications_2 = PetApplication.create!(pet_id: "#{@pet_3.id}", application_id: "#{@antoine.id}", status: "Pending" )
    @pet_applications_3 = PetApplication.create!(pet_id: "#{@pet_3.id}", application_id: "#{@jeff.id}", status: "Pending" )
    @pet_applications_4 = PetApplication.create!(pet_id: "#{@pet_2.id}", application_id: "#{@antoine.id}", status: "Pending" )
  end
  describe "#show"
    it "shows the application and all its attributes" do
      visit "/admin/applications/#{@cory.id}"

      within("#applicant_info-#{@cory.id}") do
        expect(page).to have_content(@cory.name)
        expect(page).to have_content(@cory.street_address)
        expect(page).to have_content(@cory.city)
        expect(page).to have_content(@cory.state)
        expect(page).to have_content(@cory.zipcode)
        expect(page).to have_content(@cory.description)
        expect(page).to have_content(@cory.status)
      end
    end 

    it "shows all pets on the application" do
      visit "/admin/applications/#{@cory.id}"

      within("#pet_applied_for-#{@pet_1.id}") do 
        expect(page).to have_content(@pet_1.name)
      end
    end 

    describe "approve/reject buttons" do
      it "sets pet application status to 'Approved' when button is clicked" do
        visit "/admin/applications/#{@cory.id}"

        within("#pet_applied_for-#{@pet_1.id}") do
          expect(page).to have_button("Approve Adoption")
          expect(page).to have_content("Pending")
        end

        click_button("Approve Adoption")

        within("#pet_applied_for-#{@pet_1.id}") do
          expect(page).to_not have_button("Approve Adoption")
          expect(page).to have_content("Approved")
        end
      end

      it "sets pet application status to 'Rejected' when button is clicked" do
        visit "/admin/applications/#{@cory.id}"

        within("#pet_applied_for-#{@pet_1.id}") do
          expect(page).to have_button("Reject Adoption")
          expect(page).to have_content("Pending")
          click_button("Reject Adoption")
        end

        within("#pet_applied_for-#{@pet_1.id}") do
          expect(page).to_not have_button("Reject Adoption")
          expect(page).to have_content("Rejected")
        end
      end

      it "does not affect other applications when approving/rejecting" do
        visit "admin/applications/#{@antoine.id}"
        
        within("#pet_applied_for-#{@pet_3.id}") do
          expect(page).to have_button("Reject Adoption")
          expect(page).to have_content("Pending")
          click_button("Reject Adoption")
          expect(page).to have_content("Rejected")
        end
      
        visit "admin/applications/#{@jeff.id}"

        within("#pet_applied_for-#{@pet_3.id}") do
          expect(page).to have_content("Pending")
        end
      end

      describe "Application Status changed based on individual pet approval" do 
        it "Sets application status to 'Approved' when all pets are approved" do
          visit "/admin/applications/#{@antoine.id}"
  
          within("#pet_applied_for-#{@pet_3.id}") do
            expect(page).to have_content("Pending")
            click_button("Approve Adoption")
            expect(page).to have_content("Approved")
          end
          
          within("#pet_applied_for-#{@pet_2.id}") do
            expect(page).to have_content("Pending")
            click_button("Approve Adoption")
            expect(page).to have_content("Approved")
          end
          
          @antoine.reload
          expect(@antoine.status).to eq("Approved")
        end

        it "Sets application status to 'Rejected' when not all pets are approved" do
          visit "/admin/applications/#{@antoine.id}"
  
          within("#pet_applied_for-#{@pet_3.id}") do
            expect(page).to have_content("Pending")
            click_button("Approve Adoption")
            expect(page).to have_content("Approved")
          end
          
          within("#pet_applied_for-#{@pet_2.id}") do
            expect(page).to have_content("Pending")
            click_button("Reject Adoption")
            expect(page).to have_content("Rejected")
          end
          
          @antoine.reload
          expect(@antoine.status).to eq("Rejected")
        end
      end
    end
  end
