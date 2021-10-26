require './lib/oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }

  describe "#balance" do
    it 'expects there to be a balance on the card' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'expects to be able to add money to a card' do
      expect { oystercard.top_up 10 }.to change { oystercard.balance }.by(10)
    end

    it 'expects to raise an error if balance exceeds maximum balance' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      expect { oystercard.top_up 1 }.to raise_error "Max. balance #{maximum_balance} exceeded"
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'expects an amount to be deducted from an oystercard' do
      oystercard.top_up(50)
      expect { oystercard.deduct 10 }.to change { oystercard.balance }.by(-10)
    end
  end

  describe '#in_journey?' do
    it 'returns true or false' do
      expect(oystercard.in_journey?)
    end
  end
end
