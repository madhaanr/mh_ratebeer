class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: {minimum: 3,maximum:15}
  validates :password, presence: true, length: {minimum: 4, }, format: {with:/[A-Z]+/, with:/[0-9]+/}

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beerclubs, through: :memberships


  def to_s
    "#{username}"
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc ).limit(1).first.beer
  end

  def favorite_style
    @a=0.0
    rated_styles.each do |style|
      if users_average_rating(style)>@a then @style_name=style and @a=users_average_rating(style) end
    end
    @style_name
  end

  def favorite_brewery
    #@a=0.0
    #user_breweries.each do |brewery|
      #if users_breweries_average(brewery)>@a then @brew=brewery and @a=users_breweries_average(brewery) end
    #end
    #@brew
  end

  private

  def rated_styles
    ratings.map{|r| r.beer.style}.uniq
  end

  def users_average_rating(style)
    ratings.select{ |r| r.beer.style == style }.inject(0.0){ |sum,r| sum+r.score }/ratings.select{|r| r.beer.style==style}.count
  end

  def user_breweries
    beers.map{ |r| r.brewery.name }.uniq
  end

  def users_breweries_average(brewery)
    beers.select{ |r| r.brewery.name == brewery }.inject(0.0){|sum,r| r.ratings}
  end

  # esimerkit_tallessa
  #(ratings.select{ |r| r.beer.style == "Lager" }.inject(0){ |sum,r| sum+r.score })/ratings.count
  #User.first.ratings.select{ |r| r.beer.style == "Lager" }.inject(0){ |sum,r| sum+r.score }
  #User.first.ratings.group_by{|rating| rating.beer.style}
  #User.first.ratings.map{|r| r.beer.style}.uniq
  #User.first.beers.select{|r| r.brewery.name}.inject(0.0){|sum,r| sum+r.beer.ratings}

end
