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
    members = @members.uniq
    members.size < @quantity ? members : draw_lots
  end

  def draw_lots
    ret = []
    members = @members.dup
    @quantity.times do
      if ret[0] == nil
        ret << members.sample
      else
        ret << members.delete_if{ |member| member == ret.last}.sample
      end
    end unless @members.empty?
    ret.delete_if{|m|m.nil?}
  end

end
