require 'spec_helper'
require 'level_object/bomb'
require 'config'

describe LevelObject::Bomb do
  subject { described_class.new(image_registry, x, y) }
  let(:image_registry) { double }
  let(:x) { 10 }
  let(:y) { 20 }

  context '#touch' do
    let(:object) { double(get_damage: double) }
    let(:get_damage) { double }

    before do
      subject.stub(:object).and_return(object)
    end

    it 'should call get_damage and mark_to_destroy' do
      expect(object).to receive(:get_damage)
      expect(subject).to receive(:mark_to_destroy)
      subject.touch(object)
    end
  end
end
