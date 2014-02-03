class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :beerclub

  validates :user_id, :uniqueness => {:scope => :beerclub_id}

end
