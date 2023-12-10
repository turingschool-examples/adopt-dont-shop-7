class Admin::Shelter < ApplicationRecord
  def self.reverse_alpha_order
    Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name desc")
    #shelters = Shelter.order(name: :desc) ActiverRecord Equivalent
  end
end