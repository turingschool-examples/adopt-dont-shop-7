class Admin < ApplicationRecord
  validates :status, inclusion:{in: ["Pending"]}
  has_many :apps
  
  def self.order_by_name_reverse
    select("shelters.*").group("shelter.name").order(name: :desc)
  end

  def approved
    require 'pry'; binding.pry
    @app.update!(status: 2)
  end

  def rejected
    require 'pry'; binding.pry
    @app.update!(status: 3)
  end
end