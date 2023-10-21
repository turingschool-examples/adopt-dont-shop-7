class App < ApplicationRecord
  def status
    self.status = "In Progress"
  end

  
end