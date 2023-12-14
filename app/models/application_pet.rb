class ApplicationPet < ApplicationRecord
    belongs_to :application
    belongs_to :pet

    def change_application_pet_status(new_status)
        self.update(status: new_status)
    end
end