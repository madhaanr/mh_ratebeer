require 'spec_helper'

describe 'Ratings' do
  let!(:brewery) {FactoryGirl.create :brewery, name:"Koff"}
  let!(:style) {FactoryGirl.create :style}
  let!(:style2) {FactoryGirl.create :style, name:"Lager"}
  let!(:beer1) {FactoryGirl.create :beer, name:"iso 3", brewery:brewery,style:style}
  let!(:beer2) {FactoryGirl.create :beer, name:"Karhu", brewery:brewery,style:style}
  let!(:user) {FactoryGirl.create :user}
  let!(:rating1) {FactoryGirl.create :rating, score:2, beer:beer1, user:user}
  let!(:rating2) {FactoryGirl.create :rating, score:20, beer:beer1, user:user}
  let!(:rating3) {FactoryGirl.create :rating, score:13, beer:beer1, user:user}
  let!(:rating4) {FactoryGirl.create :rating, score:17, beer:beer2, user:user}
  let!(:rating5) {FactoryGirl.create :rating, score:19, beer:beer1, user:user}
  let!(:rating6) {FactoryGirl.create :rating, score:20, beer:beer2, user:user}
  let!(:rating7) {FactoryGirl.create :rating, score:30, beer:beer1, user:user}

  let!(:user2) {FactoryGirl.create :user, username:"Matti",password:"1QWE",password_confirmation:"1QWE"}
  let!(:rating8) {FactoryGirl.create :rating, score:20, beer:beer2, user:user2}
  let!(:rating9) {FactoryGirl.create :rating, score:30, beer:beer1, user:user2}

  it "are all shown in ratings page" do
    visit ratings_path
    expect(page).to have_content "Number of ratings: 9"
    #save_and_open_page
    #expect(page).to have_content "iso 3 2 Pekka"
    expect(page).to have_content "iso 3 30 Matti"
    expect(page).to have_content "Karhu 20 Matti"
    expect(page).to have_content "iso 3 19 Pekka"
    expect(page).to have_content "Karhu 20 Pekka"
    expect(page).to have_content "iso 3 30 Pekka"
  end

  it "are shown on raters page" do
    #sign_in(username:"Matti", password:"1QWE")
    visit user_path(user2)
    expect(page).to have_content "has made 2 ratings"
    expect(page).to have_content "average rating 25.0"
    expect(page).to have_content "Karhu 20"
    expect(page).to have_content "iso 3 30"
    expect(page).not_to have_content "iso 3 2"
    expect(page).not_to have_content "iso 3 13"
    expect(page).not_to have_content "Karhu 17"
  end

=begin
  it "can be deleted by user" do
    #sign_in(username:"Matti", password:"1QWE")
    visit user_path(user2)

    expect(Rating.exists?(8)).to be(true)
    page.find('li',:text=>"Karhu 20").click_link('delete')
    expect(page).to have_content "has made 1 ratings"
    expect(page).to have_content "average rating 30.0"
    expect(page).not_to have_content "Karhu 20 delete"
    expect(page).to have_content "iso 3 30 delete"
    expect(Rating.exists?(8)).to be(false)
    #save_and_open_page
  end
=end

  it "done by user decide their favorite beer style" do
    #sign_in(username:"Matti", password:"1QWE")
    visit user_path(user2)
    #save_and_open_page
    expect(page).to have_content "favorite beer style is Weizen"
    #save_and_open_page
  end

  it "done by user decide their favorite brewery style" do
    #sign_in(username:"Matti", password:"1QWE")
    visit user_path(user2)
    expect(page).to have_content "favorite brewery is Koff"
  end
end