class Brewery < ActiveRecord::Base
  include RatingAverage

  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  scope :active, -> { where active:true }
  scope :retired, -> {where active:[nil,false]}

  validates :name, presence: true
  validates :year, numericality: {greater_than_or_equal_to: 1042,

                                  only_integer: true}

  validate :year_newer_than_current

  def year_newer_than_current
    if year > Date.current.year
      errors.add(:year, ' should not be newer than current!')
    end
  end

  def self.top(n)
    Brewery.all.sort_by{ |b| -(b.average_rating||0) }.take(n)
  end

  #less_than_or_equal_to: Date.current.year,
=begin
  validate :year_format

  private
  def year_format
    errors.add(:year, " should be not newer than current!") unless (1042..Date.today.year)
  end
=end


  #validates_date :year, :on_or_before => lambda {Date.today}

  #def average_rating
  #  "#{(ratings.inject(0.0) { |sum ,rating |sum+rating.score }/ratings.count).round(1)}"
  #end
end
