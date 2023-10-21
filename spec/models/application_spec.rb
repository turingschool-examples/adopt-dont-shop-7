require "rails_helper"

RSpec.describe Application, type: :model do 
  before(:each) do 
  end

    app = Application.create!({
      name: "Joe Shmo", 
      address: "2323 Wysteria Ln., Littleton, CO 89321",
      descriptioissn: "Love pets; live on farm",
      pet_names: "Socks, Juneau, Curtis, Stimpy",
      status: "Pending"
    })

  describe "applications#show" do
    it 'saves the contact info of applicants' do 
      expect(app.name).to eq("Joe Shmo")
      expect(app.address).to eq("2323 Wysteria Ln., Littleton, CO 89321")
      expect(app.description).to eq("Love pets; live on farm")
      expect(app.pet_names).to eq("Socks, Juneau, Curtis, Stimpy")
      expect(app.status).to eq("Pending")
    end
  end
end 