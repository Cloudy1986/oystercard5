class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :exit_station, :journey_history

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
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
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    @journey_history << { :journey_entry => @entry_station, :journey_exit => station }
    @entry_station = nil
    @exit_station = nil
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
