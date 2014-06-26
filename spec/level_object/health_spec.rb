require 'spec_helper'
require 'level_object/health'
require 'config'

describe LevelObject::Health do
  subject { described_class.new(image_registry, x, y) }
  let(:image_registry) { double }
  let(:x) { 10 }
  let(:y) { 20 }

  context '#touch' do
    let(:health_config) { [health_points: '1'] }
    let(:object) { double(get_damage: double) }
    let(:get_damage) { double }

    before do
      Game::Config.stub(:load).and_return(health_config[0])
      subject.stub(:object).and_return(object)
    end

    it 'should call get_heal and mark_to_destroy' do
      expect(object).to receive(:get_heal)
      expect(subject).to receive(:mark_to_destroy)
      subject.touch(object)
    end
  end
end
