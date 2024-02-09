require "rails_helper"

RSpec.describe "Index Application Page" do

  before(:each) do
    @application_1 = Application.create!(name: "John", street_address: "1234 ABC Lane", city: "Turing", state: "Backend", zipcode: "54321", description: "I love animals")
  end

  it "lists all applications and their information" do
    
  end
end
