class Application < ApplicationRecord
    has_many :pets # dependent: :destroy
    validates :name, presence: true
    validates :street_address, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip_code, presence: true, numericality: true, length: { is: 5 }
    validates :description, presence: true

    def self.order_by_recently_created
      order(created_at: :desc)
    end
end