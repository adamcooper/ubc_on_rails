class Rating < ActiveRecord::Base

  validates :name, :presence => true
end
