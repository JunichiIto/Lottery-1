class Lottery

  def initialize n
    @quantity = n
    @members = []
  end
  
  def add member, weight
    weight.times do
      @members << member
    end
  end

  def winners
    ret = []
    members = @members.dup
    @quantity.times do
      if ret[0] == nil
        ret << members.sample
      else
        ret << members.delete_if{ |member| member == ret.last}.sample
      end
    end
    p ret
  end

end



# lottery = Lottery::new 2
# lottery.add('Ieyasu',1)
# lottery.add('Hideyoshi', 2)
# lottery.add('Nobunaga',5)
# lottery.add('Yoritomo', 2)
# lottery.add('Kamatari', 10)

# lottery.winners

# results = { }
# 1000000.times do
#   lottery.winners.each do |member|
#     results[member] = 0 unless results[member]
#     results[member] += 1
#   end
# end
# puts results

 
