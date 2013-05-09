# encoding: utf-8

require 'rspec'
require './lottery'

describe Lottery do
  context "応募者が商品数より多い" do
    let(:lottery) { Lottery.new 3 }

    before do
      lottery.add('Ieyasu', 1)
      lottery.add('Hideyoshi', 2)
      lottery.add('Nobunaga',5)
      lottery.add('Yoritomo', 2)
      lottery.add('Kamatari', 10)
    end

    it "当選者が3人いる" do
      expect(lottery.winners).to have(3).items
    end
  
    it "毎回結果が違う" do
      winners1 = lottery.winners
      winners2 = lottery.winners
      expect(winners1).not_to eq winners2
    end

    it "当選者は重複しない" do
      100.times do
        expect(lottery.winners.uniq).to have(3).items
      end
    end

    describe "重み付けの評価" do
      before do
        results = Hash.new(0)
        100.times do
          lottery.winners.each do |member|
            results[member] += 1
          end
        end
        @ranking = results.sort_by(&:last).map(&:first).reverse
      end

      it "KamatariとNobunagaが一番当たりやすい" do
        expect(@ranking).to start_with("Kamatari", "Nobunaga")
      end

      it "Ieyasuが一番当たらない" do
        expect(@ranking.last).to eq "Ieyasu"
      end
    end
  end

  context "誰も応募しない" do
    let(:lottery) { Lottery.new 3 }

    it "[]を返す" do
      expect(lottery.winners).to be_empty
    end
  end

  context "応募者が商品数より少ない" do
    let(:lottery) { Lottery.new 3 }

    before do
      lottery.add('Ieyasu', 1)
      lottery.add('Hideyoshi', 2)
    end

    it "応募者全員を返す" do
      expect(lottery.winners).to have(2).items
    end

    it "Ieyasuが含まれる" do
      expect(lottery.winners).to include 'Ieyasu'
    end

    it "Hideyoshiが含まれる" do
      expect(lottery.winners).to include 'Hideyoshi'
    end
  end

  context "商品数が0の場合" do
    let(:lottery) { Lottery.new 0 }

    before do
      lottery.add('Ieyasu', 1)
      lottery.add('Hideyoshi', 2)
    end

    it "[]を返す" do
      expect(lottery.winners).to be_empty
    end
  end
end
