class Style < ActiveRecord::Base
  has_many :beers


  def self.top(n)
    Style.all.each do |r|
      r.beers.sort_by{ |b| -(b.average_rating||0) }.take(n)
    end
  end
  def to_s
    name
  end
end
