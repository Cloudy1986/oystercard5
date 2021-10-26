class Oystercard
  MAXIMUM_BALANCE = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    if (@balance + amount) > MAXIMUM_BALANCE
      fail "Max. balance #{MAXIMUM_BALANCE} exceeded"
    end
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    false
  end
end
