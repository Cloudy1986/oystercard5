require './lib/oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  let(:station) { double :station }
  let(:journey){ {:journey_entry => :station, :journey_exit => :station} }

  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }

  describe '#balance' do
    it 'expects there to be a balance on the card' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#journey_history' do
    it 'there be no journey history on initiation' do
      expect(oystercard.journey_history).to be_empty
    end
  end

  describe '#top_up' do
    it 'expects to be able to add money to a card' do
      expect { oystercard.top_up 10 }.to change { oystercard.balance }.by(10)
    end

    it 'expects to raise an error if balance exceeds maximum balance' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      expect { oystercard.top_up 1 }.to raise_error "Max. balance #{maximum_balance} exceeded"
    end
  end

  # describe '#in_journey?' do
  #   context 'when oystercard is initialised it' do
  #     it 'is false' do
  #       expect(oystercard.in_journey?).to be false
  #     end
  #   end
  # end

  describe '#touch_in' do
    # context 'when oystercard is touched in' do
    #   it 'is true' do
    #     top_and_touch
    #     expect(oystercard.in_journey?).to be true
    #   end
    # end

    it 'expects to raise an error if balance is below minimum balance' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      expect { oystercard.touch_in(:station) }.to raise_error "Insufficient balance. Min. balance is #{minimum_balance}"
    end

    it 'register an entry_station on touch_in' do
      oystercard.top_up(50)
      oystercard.touch_in(:station)
      expect(oystercard.entry_station).to eq :station
    end

  end

  describe '#touch_out' do
    # context 'when oystercard is touched out' do
    #   it 'is false' do
    #     oystercard.top_up(50)
    #     oystercard.touch_in(:station)
    #     oystercard.touch_out(:station)
    #     expect(oystercard.in_journey?).to be false
    #   end
    # end

    it 'deducts 1 from balance' do
      minimum_fare = Oystercard::MINIMUM_FARE
      oystercard.top_up(10)
      expect { oystercard.touch_out(:station) }.to change { oystercard.balance }.by(-minimum_fare)
    end

    it 'resets entry_station to nil on touch_out' do
      oystercard.top_up(50)
      oystercard.touch_in(:station)
      oystercard.touch_out(:station)
      expect(oystercard.entry_station).to eq nil
    end

    it 'resets exit_station to nil on touch_out' do
      oystercard.top_up(50)
      oystercard.touch_in(:station)
      oystercard.touch_out(:station)
      expect(oystercard.exit_station).to eq nil
    end

    it 'adds the full journey as a hash to @journey_history' do
      oystercard.top_up(50)
      oystercard.touch_in(:station)
      oystercard.touch_out(:station)
      expect(oystercard.journey_history).to include journey
      #expect {oystercard.touch_out(:station) }.to change { oystercard.journey_history.count }.by(1)
    end
  end
end
