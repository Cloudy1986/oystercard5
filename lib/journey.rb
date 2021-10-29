class Journey
  attr_reader :entry_station

  def initialise
    @entry_station = nil
  end

  def in_journey?
    @entry_station.nil? ? false : true
  end
end