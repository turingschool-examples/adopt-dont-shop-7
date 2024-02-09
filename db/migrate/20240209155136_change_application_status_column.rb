class ChangeApplicationStatusColumn < ActiveRecord::Migration[7.0]

  def change
    change_column :applications, :status, :integer, using: 'status::integer', default: 0
  end
end
