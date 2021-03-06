require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
    #expect(user.username).to be("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
      let(:user){ FactoryGirl.create(:user)}

    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  it "with too short password is not saved" do
    user = User.create username:"Pekka", password:"AA1", password_confirmation:"AA1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "with password containing only letters is not saved" do
    user = User.create username:"Pekka", password:"QWER", password_confirmation:"QWER"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
      end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10,user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10,20,15,7,9,user)
      best = create_beer_with_rating(25,user)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "has favorite style" do
    let!(:brewery) {FactoryGirl.create :brewery, name:"Koff"}
    let!(:brewery2) {FactoryGirl.create :brewery, name:"Malmgard"}
    let!(:style) {FactoryGirl.create :style}
    let!(:style2) {FactoryGirl.create :style, name:"Lager"}
    let!(:beer1) {FactoryGirl.create :beer, name:"iso 3", brewery:brewery, style:style}
    let!(:beer2) {FactoryGirl.create :beer2, name:"Karhu", brewery:brewery, style:style2}
    let!(:beer3) {FactoryGirl.create :beer, name:"iso 3", brewery:brewery2, style:style}
    let!(:beer4) {FactoryGirl.create :beer2, name:"Karhu", brewery:brewery2, style:style2}
    let!(:user){FactoryGirl.create(:user)}
    let!(:rating1) {FactoryGirl.create :rating, score:2, beer:beer1, user:user}
    let!(:rating2) {FactoryGirl.create :rating, score:20, beer:beer1, user:user}
    let!(:rating3) {FactoryGirl.create :rating, score:13, beer:beer1, user:user}
    let!(:rating4) {FactoryGirl.create :rating, score:21, beer:beer2, user:user}
    let!(:rating5) {FactoryGirl.create :rating, score:5, beer:beer1, user:user}
    let!(:rating6) {FactoryGirl.create :rating, score:20, beer:beer1, user:user}
    let!(:rating7) {FactoryGirl.create :rating, score:13, beer:beer1, user:user}
    let!(:rating8) {FactoryGirl.create :rating, score:21, beer:beer2, user:user}
    #let!(:rating5) {FactoryGirl.create :rating, score:16, beer:beer2, user:user}

    it "and should respond to favorite_style" do
      user.should respond_to :favorite_style
    end

    it "and should return style Lager" do
      create_beers_with_ratings(50,50,user)


      expect(user.favorite_style.name).to eq("Weizen")
    end


    it "should return style with highest average rating" do
      expect(user.favorite_style.name).to eq("Lager")
    end
  end


  describe "has favorite brewery" do
    let!(:brewery) {FactoryGirl.create :brewery, name:"Koff"}
    let!(:brewery2) {FactoryGirl.create :brewery, name:"Malmgard"}
    let!(:beer1) {FactoryGirl.create :beer, name:"iso 3", brewery:brewery}
    let!(:beer2) {FactoryGirl.create :beer2, name:"Karhu", brewery:brewery}
    let!(:beer3) {FactoryGirl.create :beer, name:"iso 3", brewery:brewery2}
    let!(:beer4) {FactoryGirl.create :beer2, name:"Karhu", brewery:brewery2}
    let!(:user){FactoryGirl.create(:user)}
    let!(:rating1) {FactoryGirl.create :rating, score:2, beer:beer1, user:user}
    let!(:rating2) {FactoryGirl.create :rating, score:20, beer:beer1, user:user}
    let!(:rating3) {FactoryGirl.create :rating, score:13, beer:beer1, user:user}
    let!(:rating4) {FactoryGirl.create :rating, score:21, beer:beer2, user:user}
    let!(:rating5) {FactoryGirl.create :rating, score:5, beer:beer1, user:user}
    let!(:rating6) {FactoryGirl.create :rating, score:20, beer:beer1, user:user}
    let!(:rating7) {FactoryGirl.create :rating, score:13, beer:beer1, user:user}
    let!(:rating8) {FactoryGirl.create :rating, score:21, beer:beer2, user:user}

    it "and should respond to favorite brewery" do
      user.should respond_to :favorite_brewery
    end

    it "and should return favorite brewery" do
      expect(user.favorite_brewery).to eq("Koff")
    end
  end
end


private

def create_beer_with_rating(score,user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating,score:score,beer:beer,user:user)
  beer
end

def create_beers_with_ratings(*scores,user)
  scores.each do |score|
    create_beer_with_rating(score,user)
  end
end
