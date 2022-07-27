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

    it 'starts with no patrons' do
      expect(dmns.patrons).to eq([])
    end

  end

  context 'exhibits' do
    let(:gems_and_minerals) { Exhibit.new({ name: "Gems and Minerals", cost: 0 }) }
    let(:dead_sea_scrolls) { Exhibit.new({ name: "Dead Sea Scrolls", cost: 10 }) }
    let(:imax) { Exhibit.new({ name: "IMAX", cost: 15 }) }
    before(:each) do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)
    end

    it 'can add an exhibit' do
      expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])
    end

    context 'patrons' do
      let(:patron_1) { Patron.new("Bob", 20) }
      let(:patron_2) { Patron.new("Sally", 20) }
      let(:patron_3) { Patron.new("Johnny", 5) }

      it 'can recomment exhibits based on patron interests' do
        patron_1.add_interest("Dead Sea Scrolls")
        patron_1.add_interest("Gems and Minerals")
        patron_2.add_interest("IMAX")

        expect(dmns.recommend_exhibits(patron_1)).to eq([gems_and_minerals, dead_sea_scrolls])
        expect(dmns.recommend_exhibits(patron_2)).to eq([imax])
      end 



      context 'lottery' do

        before(:each) do
          dmns.admit(patron_1)
          dmns.admit(patron_2)
          dmns.admit(patron_3)
          patron_1.add_interest("Gems and Minerals")
          patron_1.add_interest("Dead Sea Scrolls")
          patron_2.add_interest("Dead Sea Scrolls")
          patron_3.add_interest("Dead Sea Scrolls")
        end

        it 'can admit patrons' do
          expect(dmns.patrons).to eq([patron_1, patron_2, patron_3])
        end

        it 'can return a hash with patron interested in each exhibit' do
          expected = {
            gems_and_minerals => [patron_1],
            dead_sea_scrolls => [patron_1, patron_2, patron_3],
            imax => []
          }
          expect(dmns.patrons_by_exhibit_interest).to eq(expected)

        end

        it 'can find contestents for a lottery based on interested patrons who cant afford an exhibit' do
          expect(dmns.ticket_lottery_contestants(dead_sea_scrolls)).to eq([patron_1, patron_3])
        end

        it 'can draw for a lottery winner' do
          expect(dmns.draw_lottery_winner(dead_sea_scrolls)).to eq("Johnny" || "Bob")
          expect(dmns.draw_lottery_winner(gems)).to eq(nil)
        end

        it 'can announce a lottery winner' do
          allow(dmns).to recieve(:draw_lottery_winner).and_call_original
          allow(dmns).to receive(:draw_lottery_winner).with(dead_sea_scrolls).and_return("Johnny")

          expect(dmns.announce_lottery_winner(imax)).to eq("No winners for this lottery")
          expect(dmns.announce_lottery_winner(gems_and_minerals)).to eq("Bob has won the IMAX exhibit lottery")
          expect(dmns.announce_lottery_winner(dead_sea_scrolls)).to eq("Johnny has won the Dead Sea Scrolls lottery")
        end

      end
    end
  end
end