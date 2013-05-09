# encoding: utf-8

require 'rspec'
require './lottery'

describe Lottery do
  context "応募者が商品数より多い" do
    let(:lottery) { Lottery.new 3 }

    before do
      lottery.add('Ieyasu',1)
      lottery.add('Hideyoshi', 2)
      lottery.add('Nobunaga',5)
      lottery.add('Yoritomo', 2)
      lottery.add('Kamatari', 10)
    end

    it "当選者が3人いる" do
      expect(lottery.winners.size).to eq 3
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
        results = {}
        100000.times do
          lottery.winners.each do |member|
            results[member] = 0 unless results[member]
            results[member] += 1
          end
        end
        @result = results.sort_by{|result|result[1]}.map{|result|result[0]}
      end

      it "指定した重み付けの通りに当選する(最初)" do
        expect(@result.first).to eq "Ieyasu"
      end

      it "指定した重み付けの通りに当選する(終わり)" do
        expect(@result).to end_with("Nobunaga", "Kamatari")
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
      expect(lottery.winners).to include 'Ieyasu'
      expect(lottery.winners).to include 'Hideyoshi'
    end

    it "当選者の数は商品数より少ない" do
      expect(lottery.winners.size).to be < 3
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
