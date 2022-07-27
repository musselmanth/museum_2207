require './lib/museum'
require './lib/exhibit'
require './lib/patron'

RSpec.describe Museum do
  let(:dmns) {Museum.new("Denver Museum of Nature and Science")}
  
  context 'museum' do
    
    it 'can be instantiated' do
      expect(dmns).to be_an(Museum)
    end

    it 'has a name' do
      expect(dmns.name).to eq("Denver Museum of Nature and Science")
    end

    it 'starts with no exhibits' do
      expect(dmns.exhibits).to eq([])
    end

  end

  context 'exhibits' do
    let(:gems_and_minerals) { Exhibit.new({ name: "Gems and Minerals", cost: 0 }) }
    let(:dead_sea_scrolls) { Exhibit.new({ name: "Dead Sea Scrolls", cost: 10 }) }
    let(:imax) { Exhibit.new({ name: "IMAX", cost: 15 }) }

    it 'can add an exhibit' do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)

      expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])
    end

    context 'patrons' do
      let(:patron_1) { Patron.new("Bob", 20) }
      let(:patron_2) { Patron.new("Sally", 20) }

      xit 'can recomment exhibits based on patron interests' do
        patron_1.add_interest("Dead Sea Scrolls")
        patron_1.add_interest("Gems and Minerals")
        patron_2.add_interest("IMAX")

        expect(dmns.recommend_exhibits(patron_1)).to eq([gems_and_minerals, dead_sea_scrolls])
        expect(dmns.recommend_exhibits(patron_2)).to eq([imax])
      end 

    end
  end
end