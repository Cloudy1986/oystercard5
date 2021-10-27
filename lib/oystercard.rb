class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    #@in_journey = false # refactored to remove in_journey
    @entry_station = nil
  end

  def top_up(amount)
    fail "Max. balance #{MAXIMUM_BALANCE} exceeded" if over_max?(amount)
    @balance += amount
  end

  def in_journey?
    @entry_station.nil? ? false : true
  end

  def touch_in(station)
    fail "Insufficient balance. Min. balance is #{MINIMUM_BALANCE}" if less_than_min?
    #@in_journey = true # refactored to remove in_journey
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    #@in_journey = false # refactored to remove in_journey
    @entry_station = nil
  end

  private

  def less_than_min?
    @balance < MINIMUM_BALANCE
  end

  def over_max?(amount)
    (@balance + amount) > MAXIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end
end
