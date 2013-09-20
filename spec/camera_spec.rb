require 'spec_helper'
require 'camera'

describe Camera do

  let(:level) { double(width: 150, height: 150) }
  let(:window) { double(level: level, width: 20, height: 20) }
  subject {Camera.new(window)}

  context '#target' do
    it 'should center camera' do
      object = double(x: 50, y: 50)
      subject.target(object)

      subject.x.should == 40
      subject.y.should == 40
    end

    it 'should not show level end' do
      object = double(x: 150, y: 150)
      subject.target(object)

      subject.x.should == 130
      subject.y.should == 130


      object = double(x: 2, y: 3)
      subject.target(object)

      subject.x.should == 0
      subject.y.should == 0
    end
  end
end
