class SetDefaultStatusToPendingInApplicationPets < ActiveRecord::Migration[7.0]
  def change
    change_column_default :application_pets, :status, "Pending"
  end
end
# fixed forward? or can we add that some other way??