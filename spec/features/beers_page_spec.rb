require 'spec_helper'

describe "Beer" do
  let!(:brewery){FactoryGirl.create(:brewery)}
  let!(:user) {FactoryGirl.create :user}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "can be added with valid name" do
    visit new_beer_path
    #save_and_open_page
    fill_in('beer_name',with:'Kumpula winter special')
    select('Weizen',from:'beer[style]')
    select('anonymous',from:'beer[brewery_id]')
    click_button("Create Beer")
    expect(page).to have_content "Kumpula winter special"
  end

  it "can't be added without valid name" do
    visit new_beer_path
    fill_in('beer_name',with:'')
    select('Weizen',from:'beer[style]')
    select('anonymous',from:'beer[brewery_id]')

    click_button('Create Beer')

    expect(page).to have_content "New beer"
    expect(page).to have_content "Name can't be blank"
  end
end