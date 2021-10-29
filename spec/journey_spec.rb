require './lib/journey'

describe Journey do
  let(:station) { double :station }
  let(:oystercard_touched_in) { double('touched in oystercard', :top_up => 50, :touch_in => :station) }
  let(:oystercard_touched_out) { double('touched out oystercard', :top_up => 50, :touch_in => :station, :touch_out => :station) }

  describe '#in_journey?' do
    context 'when oystercard is initialised it' do
      it 'is false' do
        expect(subject.in_journey?).to be false
      end
    end
    context 'when oystercard is touched in' do
      it 'is true' do
        oystercard_touched_in
        expect(subject.in_journey?).to be true
      end
    end
    context 'when oystercard is touched out' do
      it 'is false' do
        oystercard_touched_out
        expect(subject.in_journey?).to be false
      end
    end
  end
end