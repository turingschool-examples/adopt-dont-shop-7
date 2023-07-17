class UpdateApplicationPetsStatusDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :application_pets, :status, 'pending'
  end
end
