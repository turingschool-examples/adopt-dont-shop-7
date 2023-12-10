class Application < ApplicationRecord
    has_many :pets # dependent: :destroy
  
    def self.order_by_recently_created
      order(created_at: :desc)
    end
end