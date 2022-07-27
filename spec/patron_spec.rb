require './lib/patron'

RSpec.describe Patron do
  let!(:patron_1) {Patron.new("Bob", 20)}

  it 'can be instantiated' do 
    expect(patron_1).to be_an(Patron)
  end

  it 'has a name' do
    expect(patron_1.name).to eq("Bob")
  end

  it 'has some money' do 
    expect(patron_1.spending_money).to eq(20)
  end

  it 'starts with no interests' do
    expect(patron_1.interests).to eq([])
  end

  it 'can get interests' do
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")

    expect(patron_1.interests).to eq(["Dead Sea Scrolls", "Gems and Minerals"])
  end
end