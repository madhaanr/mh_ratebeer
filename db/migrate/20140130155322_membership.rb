class Membership < ActiveRecord::Migration
  def change
    change_table :memberships do |t|
    t.rename :beer_club_id, :beerclub_id
    end
  end
end
