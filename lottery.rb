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
    ret
  end

end
