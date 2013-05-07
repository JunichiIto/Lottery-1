# encoding: utf-8

require 'rspec'
require './lottery'



describe Lottery do

  context "応募者が当選者規定数より多い"
    it "当選者が３人いる" do
      lottery = Lottery::new 3
      lottery.add('Ieyasu',1)
      lottery.add('Hideyoshi', 2)
      lottery.add('Nobunaga',5)
      lottery.add('Yoritomo', 2)
      lottery.add('Kamatari', 10)   
      expect(lottery.winners.size).to eq 3
    end

  context "応募者が当選者規定数より少ない" do
    it "[]を返す" do
      lottery = Lottery::new 3
      lottery.add('Ieyasu',1)
      expect(lottery.winners).to eq []
    end
  end


end
