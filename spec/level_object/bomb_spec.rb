require 'spec_helper'
require 'level_object/bomb'

describe LevelObject::Bomb do
  subject { described_class.new(image_registry, level, x, y) }
  let(:image_registry) { double }
  let(:level) { double }
  let(:x) { 10 }
  let(:y) { 20 }

  context '#touch' do
    let(:object) { double(damage: double) }
    let(:damage) { double }

    before do
      subject.stub(:object).and_return(object)
    end

    it 'should call damage and mark_to_destroy' do
      expect(object).to receive(:damage)
      expect(subject).to receive(:mark_to_destroy)
      subject.touch(object)
    end
  end
end
