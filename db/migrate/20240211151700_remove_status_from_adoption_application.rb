class RemoveStatusFromAdoptionApplication < ActiveRecord::Migration[7.1]
  def change
    remove_column :adoption_applications, :status, :string
  end
end
