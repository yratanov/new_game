require 'spec_helper'

describe Rectangle do

  subject { described_class.new(10, 10, 10, 10) }

  context '#warp' do
    it 'should assign x, y' do
      subject.warp(1, 2)
      subject.x.should == 1
      subject.y.should == 2
    end
  end

  context '#collided?' do
    it 'touches' do
      rect = described_class.new(12, 12, 10, 10)
      subject.collided?(rect).should be_true
    end

    it 'not touches' do
      rect = described_class.new(20, 20, 10, 10)
      subject.collided?(rect).should be_false
    end

    it 'one dot touch' do
      rect = described_class.new(19, 19, 10, 10)
      subject.collided?(rect).should be_true
    end
  end

end
