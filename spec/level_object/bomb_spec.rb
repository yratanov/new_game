require 'spec_helper'
require 'level_object/bomb'

describe LevelObject::Bomb do
  subject { described_class.new(image_registry, level, x, y) }
  let(:image_registry) { double }
  let(:level) { double }
  let(:x) { 10 }
  let(:y) { 20 }

  context '#touch' do
    it 'should call mark_to_destroy' do
      expect(subject).to receive(:mark_to_destroy)
      subject.touch
    end
  end
end
