class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user


  validates :name, presence: true
  validates :style, presence: true

 # def average_rating
  #"#{(ratings.inject(0.0) { |sum ,rating |sum+rating.score }/ratings.count).round(1)}"
  #"#{ratings.average("score").round(1)}"
=begin
    k=0.0
   self.ratings.each do |e|
     k+=e.score
   end
    "#{(k/self.ratings.count).round(1)}"
=end
  #end

  def to_s
    "#{name}, #{brewery.name}"
  end
end
