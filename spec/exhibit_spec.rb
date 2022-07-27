require './lib/exhibit'

RSpec.describe Exhibit do
  let!(:exhibit) {Exhibit.new({name: "Gems and Minerals", cost: 0})}

  it 'can be instantiated' do
    expect(exhibit).to be_an(Exhibit)
  end

  it 'has a name' do 
    expect(exhibit.name).to eq("Gems and Minerals")
  end

  it 'has a cost' do 
    expect(exhibit.cost).to eq(0)
  end
  
end