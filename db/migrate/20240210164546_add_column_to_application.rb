class AddColumnToApplication < ActiveRecord::Migration[7.0]
  def change
    add_column :application_pets, :application_reviewed, :boolean, default: false
    change_column :application_pets, :application_approved, :boolean, default: false
  end
end
