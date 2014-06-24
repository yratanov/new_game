require 'spec_helper'
require 'player'

describe Player do
  subject { described_class.new(level, image_registry, x, y) }
  let(:level) { double }
  let(:x) { 1 }
  let(:y) { 2 }
  let(:image_registry) { double }
  let(:run_speed) { 2 }

  before do
    subject.run_speed = run_speed
  end

  context '#go_left' do
    context 'vel_x is positive and player speed not max' do
      before do
        subject.vel_x = 10
        subject.stub(:max_run_speed?).and_return(false)
      end
      it 'should decrease vel_x' do
        expect { subject.go_left }.to change(subject, :vel_x).by(-2)
      end
    end

    context 'vel_x is negative and player speed max' do
      before do
        subject.vel_x = -10
        subject.stub(:max_run_speed?).and_return(true)
      end
      it 'should decrease vel_x' do
        expect { subject.go_left }.not_to change(subject, :vel_x)
      end
    end
  end

  context '#go_right' do
    context 'vel_x is negative and player speed not max' do
      before do
        subject.vel_x = -10
        subject.stub(:max_run_speed?).and_return(false)
      end
      it 'should decrease vel_x' do
        expect { subject.go_right }.to change(subject, :vel_x).by(2)
      end
    end

    context 'vel_x is positive and player speed max' do
      before do
        subject.vel_x = 10
        subject.stub(:max_run_speed?).and_return(true)
      end
      it 'should decrease vel_x' do
        expect { subject.go_right }.not_to change(subject, :vel_x)
      end
    end
  end
end
