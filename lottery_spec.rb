# encoding: utf-8

require 'rspec'
require './lottery'



describe Lottery do

  def new_lottery(q = 3)
    lottery = Lottery::new q
    lottery.add('Ieyasu',1)
    lottery.add('Hideyoshi', 2)
    lottery.add('Nobunaga',5)
    lottery.add('Yoritomo', 2)
    lottery.add('Kamatari', 10)
    lottery
  end

  context "応募者が商品数より多い" do

    it "当選者が3人いる" do
      lottery = new_lottery
      expect(lottery.winners.size).to eq 3
    end
  
    it "毎回結果が違う" do
      lottery = new_lottery
      winners1 = lottery.winners
      winners2 = lottery.winners
      expect(winners1).not_to eq winners2
    end

    it "当選者は重複しない" do
      100.times do
        lottery = new_lottery 3
        expect(lottery.winners.uniq.size).to eq 3
      end
    end

    it "指定した重み付けの通りに当選する" do
      lottery = new_lottery
      results = {}
      100000.times do
        lottery.winners.each do |member|
          results[member] = 0 unless results[member]
          results[member] += 1
        end
      end
      result = results.sort_by{|result|result[1]}.map{|result|result[0]}
      # expect(result).to start_with("Ieyasu") # 使い方が間違っている？
      expect(result.first).to eq "Ieyasu"
      expect(result).to end_with("Nobunaga", "Kamatari")
    end

  end


  context "誰も応募しない" do
    it "[]を返す" do
      lottery = Lottery::new 3
      expect(lottery.winners).to eq []
    end
  end

  context "応募者が商品数より少ない" do
    it "応募者全員を返し、当選者の数は商品数より少ない" do
      lottery = Lottery::new 3
      lottery.add('Ieyasu',1)
      lottery.add('Hideyoshi', 2)
      expect(lottery.winners).to eq ['Ieyasu', 'Hideyoshi']
      expect(lottery.winners.size).to be < 3
    end
  end

  context "商品数が0の場合" do
    it "[]を返す" do
      lottery = new_lottery 0
      expect(lottery.winners).to eq []
    end
  end


end
