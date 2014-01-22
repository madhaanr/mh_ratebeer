class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy

  def average_rating
  "#{(ratings.inject(0.0) { |sum ,rating |sum+rating.score }/ratings.count).round(1)}"
  #"#{ratings.average("score").round(1)}"
=begin
    k=0.0
   self.ratings.each do |e|
     k+=e.score
   end
    "#{(k/self.ratings.count).round(1)}"
=end
  end

  def to_s
    "#{name}, #{brewery.name}"
  end
end
