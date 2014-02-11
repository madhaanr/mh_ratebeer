require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if several are returned by the API all are shown at the page" do
    BeermappingApi.stub(:places_in).with("helsinki").and_return(
        [ Place.new(:name => "Pullman Bar"), Place.new(:name => "Belge"),Place.new(:name => "St. Urho's Pub")]
    )
    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"

    expect(page).to have_content "Pullman Bar"
    expect(page).to have_content "Belge"
    expect(page).to have_content "St. Urho's Pub"
    #save_and_open_page
  end
  it "if no places are found notice is posted" do
    BeermappingApi.stub(:places_in).with("joensuu").and_return(
        []
    )
    visit places_path
    fill_in('city', with: 'joensuu')
    click_button "Search"

    expect(page).to_not have_content "Pullman Bar"
    expect(page).to have_content "No locations in joensuu"
    #save_and_open_page
  end
end
