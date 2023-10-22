class RemoveStatusFromApplications < ActiveRecord::Migration[7.0]
  def change
    remove_column :applications, :status
  end
end

Capybara.default_driver = :selenium_chrome
