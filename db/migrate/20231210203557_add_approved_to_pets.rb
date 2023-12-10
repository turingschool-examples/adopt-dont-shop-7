class AddApprovedToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :approved, :boolean
  end
end
