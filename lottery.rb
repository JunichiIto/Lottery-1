class Lottery

  def initialize n
    @quantity = n
    @members = []
  end
  
  def add member, weight
    @members.concat Array.new(weight, member)
  end

  def winners
    ret = []
    members = @members.dup
    @quantity.times do
      ret << members.sample
      members.delete(ret.last)
    end
    ret.compact
  end
end
