require 'spec_helper'
require 'level_object/base'

describe LevelObject::Base do
  subject { described_class.new(image_registry, x, y) }
  let(:image_registry) { double }
  let(:x) { 10 }
  let(:y) { 20 }

  context '#draw' do
    before do
      subject.stub(:image).and_return(image)
    end

    context 'image is not nil' do
      let(:image) { double(width: 5, height: 10) }
      before do
        subject.stub(:width).and_return(15)
        subject.stub(:height).and_return(10)
      end

      it 'should draw image' do
        expect(image).to receive(:draw).with(10, 20, 0, 3, 1)
        subject.draw
      end
    end

    context 'image is nil' do
      let(:image) { nil }

      it 'should not draw image' do
        expect(image).not_to receive(:draw)
        subject.draw
      end
    end
  end

  context '#collided?' do
    let(:object) { double(geometry: object_geometry) }
    let(:object_geometry) { double }
    let(:geometry) { double }

    before do
      subject.stub(:geometry).and_return(geometry)
    end

    it 'should call collided? on geometry' do
      expect(geometry).to receive(:collided?).
                              with(object_geometry).and_return(true)
      expect(subject).to be_collided(object)
    end
  end
end
