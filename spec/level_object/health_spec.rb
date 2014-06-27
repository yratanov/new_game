require 'spec_helper'
require 'level_object/health'
require 'config'

describe LevelObject::Health do
  subject { described_class.new(image_registry, level, x, y) }
  let(:image_registry) { double }
  let(:level) { double }
  let(:x) { 10 }
  let(:y) { 20 }

  context '#touch' do
    let(:object) { double(heal: double) }
    let(:heal) { double }

    before do
      subject.stub(:object).and_return(object)
    end

    it 'should call heal and mark_to_destroy' do
      expect(object).to receive(:heal)
      expect(subject).to receive(:mark_to_destroy)
      subject.touch(object)
    end
  end
end
