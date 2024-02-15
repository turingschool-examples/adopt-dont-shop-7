class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.search(search_params)
    where("name ILIKE ?", "%#{search_params}%")
  end

  def yes_or_no(true_or_false)
    true_or_false ? "Yes" : "No"
  end
end
