require './lib/oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }

  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }

  def top_and_touch
    oystercard.top_up(50)
    oystercard.touch_in("waterloo")
  end

  describe '#balance' do
    it 'expects there to be a balance on the card' do
      expect(oystercard.balance).to eq(0)
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

  describe '#in_journey?' do
    context 'when oystercard is initialised it' do
      it 'is false' do
        expect(oystercard.in_journey?).to be false
      end
    end
  end

  describe '#touch_in' do
    context 'when oystercard is touched in' do
      it 'is true' do
        top_and_touch
        expect(oystercard.in_journey?).to be true
      end
    end

    it 'expects to raise an error if balance is below minimum balance' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      expect { oystercard.touch_in("waterloo") }.to raise_error "Insufficient balance. Min. balance is #{minimum_balance}"
    end

    it 'register an entry_station on touch_in' do
      top_and_touch
      expect(oystercard.entry_station).to eq "waterloo"
    end

  end

  describe '#touch_out' do
    context 'when oystercard is touched out' do
      it 'is false' do
        top_and_touch
        oystercard.touch_out
        expect(oystercard.in_journey?).to be false
      end
    end

    it 'deducts 1 from balance' do
      minimum_fare = Oystercard::MINIMUM_FARE
      oystercard.top_up(10)
      expect { oystercard.touch_out }.to change { oystercard.balance }.by(-minimum_fare)
    end
  end
end
