require 'spec_helper'

describe Beer do
  let!(:style) {FactoryGirl.create :style}
  let!(:style2) {FactoryGirl.create :style, name:"Lager"}
  it "has the name, style and brewery set correctly" do

    beer = Beer.create name:"Kukko 3", style:style

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "can't be created without a name" do
    beer=Beer.create name:"", style:style2

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "can't be created without a style" do
    beer=Beer.create name:"Kukko 3"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
