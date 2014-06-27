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

    context 'if not touched?' do
      it 'should call damage and mark_to_destroy and mark as touched' do
        expect(subject).not_to be_touched
        expect(object).to receive(:damage)
        expect(subject).to receive(:mark_to_destroy)
        subject.touch(object)
        expect(subject).to be_touched
      end
    end

    context 'if already touched?' do
      before do
        subject.stub(:touched?).and_return(true)
      end
      it 'should not call damage and mark_to_destroy' do
        expect(subject).to be_touched
        expect(object).not_to receive(:damage)
        expect(subject).not_to receive(:mark_to_destroy)
        subject.touch(object)
        expect(subject).to be_touched
      end
    end
  end
end
