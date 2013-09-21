require 'spec_helper'
require 'camera'
require 'level_object/base'

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

  context '#can_see?' do
    before :each do
      object = double(x: 50, y: 50)
      subject.target(object)
    end

    it 'can' do
      level_object = create_object 55, 55, 5, 5
      subject.can_see?(level_object).should be_true


      level_object = create_object 55, 55, 30, 30
      subject.can_see?(level_object).should be_true

      level_object = create_object 45, 45, 10, 10
      subject.can_see?(level_object).should be_true
    end

    it 'cannot' do
      level_object = create_object 80, 80, 10, 10
      subject.can_see?(level_object).should be_false
    end
  end

  private

  def create_object(left, top, w, h)
    double geometry: GeometryForm::Rectangle.new(left, top, w, h)
  end

end
