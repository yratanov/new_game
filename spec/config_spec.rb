require 'spec_helper'
require 'config'
require 'player'
require 'level_object/bomb'
require 'level_object/health'
require 'level_object/creature/zombie'
require 'hud/debug'

describe Game::Config do
  subject { described_class }

  context '#set_up' do
    before do
      subject.stub(:configurable_classes).and_return(classes)
    end

    let(:classes) { [klass_1, klass_2] }
    let(:klass_1) { double }
    let(:klass_2) { double }

    it 'should run for all classes' do
      expect(subject).to receive(:configure_class).with(klass_1)
      expect(subject).to receive(:configure_class).with(klass_2)

      subject.set_up
    end
  end

  context '#configure_class' do
    let(:loaded_data) { { setting_1: true, setting_2: 10 } }
    let(:klass) { double(to_s: 'Klass') }

    before do
      subject.stub(:load).with('klass').and_return(loaded_data)
    end

    it 'should set settings' do
      expect(subject).to receive(:underscore).with(klass).
        and_return 'klass'
      expect(klass).to receive(:setting_1=).with(true)
      expect(klass).to receive(:setting_2=).with(10)

      subject.configure_class(klass)
    end
  end

  context '#load' do
    context 'file not found' do
      let(:type) { 'something special' }

      it 'should do nothing' do
        expect(subject.load(type)).to eq({})
      end
    end
  end

  context '#configurable_classes' do
    let(:expected_array) do
      [
        Player,
        LevelObject::Health,
        LevelObject::Bomb,
        LevelObject::Creature::Zombie,
        Hud::Debug,
      ]
    end

    its(:configurable_classes) { should eq expected_array }
  end

  context '#underscore' do
    let(:klass) { double to_s: 'ModuleWithSomething::BestClass' }
    let(:underscored) { 'module_with_something/best_class' }

    it { expect(subject.underscore(klass)).to eq underscored }
  end
end
