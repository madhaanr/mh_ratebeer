module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    "#{(ratings.inject(0.0) { |sum ,rating |sum+rating.score }/ratings.count).round(1)}"
  end
end