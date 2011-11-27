class Rating < ActiveRecord::Base

  validates :name, :comments, presence: true

end
