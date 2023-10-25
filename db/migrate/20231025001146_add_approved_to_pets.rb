class AddApprovedToPets < ActiveRecord::Migration[7.0]
  def change
    add_column :pets, :approved, :boolean, default: false
  end
end
