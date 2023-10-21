require "rails_helper"

RSpec.describe Application, type: :model do 
  describe "relationships" do
    it { should have_many :pet_applications } 
    it { should have_many(:pets).through(:pet_applications) }

  end
  # before(:each) do 

  #   @app = Application.create!({
  #     name: "Joe Shmo", 
  #     street_addr: "2323 Wysteria Ln.",
  #     city: "Littleton",
  #     state: "CO",
  #     zip: "89321",
  #     description: "Love pets; live on farm",
  #     pets: "Socks, Juneau, Curtis, Stimpy",
  #     status: "Pending"
  #   })

  # end

  # describe "applications#show" do
  #   it 'saves the contact info of applicants' do 
  #     expect(@app.name).to eq("Joe Shmo")
  #     expect(@app.street_addr).to eq("2323 Wysteria Ln.")
  #     expect(@app.city).to eq("Littleton")
  #     expect(@app.state).to eq("CO")
  #     expect(@app.zip).to eq("89321")
  #     expect(@app.description).to eq("Love pets; live on farm")
  #     expect(@app.pets).to eq("Socks, Juneau, Curtis, Stimpy")
  #     expect(@app.status).to eq("Pending")
  #   end
  # end
end 