require 'station'

describe Station do
  let(:name) { double :name }
  let(:zone) { double :zone }
  let(:station) { Station.new(:name, :zone) }

  describe '#name' do
    it 'expects there to be a name on initiation of station' do
      expect(station.name).to eq(:name)
    end
  end

end