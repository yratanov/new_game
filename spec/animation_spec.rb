require 'spec_helper'

describe Animation do

  let(:images) { [image, image] }
  subject { Animation.new(images, 2) }

  it { subject.height.should == 10 }
  it { subject.width.should == 12 }

  it 'draw counting wait time value' do
    images.first.should_receive(:draw).exactly(4).times
    images.last.should_receive(:draw).twice

    6.times do # same like when frames changes
      subject.draw
    end
  end

  private
  def image(height = 10, width = 12)
    double(draw: 'true', height: height, width: width)
  end
end
