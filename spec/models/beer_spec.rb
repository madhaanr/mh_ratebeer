require 'spec_helper'

describe Beer do
  it "has the name, style and brewery set correctly" do
    beer = Beer.create name:"Kukko 3", style:"Lager"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "can't be created without a name" do
    beer=Beer.create name:"", style:"Lager"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "can't be created without a style" do
    beer=Beer.create name:"Kukko 3", style:""

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
