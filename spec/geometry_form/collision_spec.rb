require 'spec_helper'
require 'geometry_form/collision'

describe GeometryForm::Collision do
  subject { described_class.new }

  context 'triangle left' do
    it 'collided rectangle in' do
      t = GeometryForm::Triangle.new(50.0, 50.0, 50.0, 50.0, :left)
      r = GeometryForm::Rectangle.new(60.0, 60.0, 30.0, 30.0)
      subject.collided?(t, r).should be_true
    end

    it 'not collided rectangle in' do
      t = GeometryForm::Triangle.new(50.0, 50.0, 50.0, 50.0, :left)
      r = GeometryForm::Rectangle.new(50.0, 20.0, 20.0, 20.0)
      subject.collided?(t, r).should be_false
    end

    it 'not collided rectangle in 2' do
      t = GeometryForm::Triangle.new(50.0, 50.0, 50.0, 50.0, :left)
      r = GeometryForm::Rectangle.new(0.0, 50.0, 20.0, 20.0)
      subject.collided?(t, r).should be_false
    end


    it 'collided triangle in' do
      t = GeometryForm::Triangle.new(50.0, 50.0, 40.0, 40.0, :left)
      r = GeometryForm::Rectangle.new(40.0, 80.0, 20.0, 20.0)
      subject.collided?(t, r).should be_true
    end


    it 'not collided triangle in' do
      t = GeometryForm::Triangle.new(50.0, 50.0, 40.0, 40.0, :left)
      r = GeometryForm::Rectangle.new(60.0, 100.0, 20.0, 20.0)
      subject.collided?(t, r).should be_false
    end
  end

  context 'triangle right' do
    it 'not collided rectangle in' do
      t = GeometryForm::Triangle.new(0.0, 0.0, 50.0, 50.0, :right)
      r = GeometryForm::Rectangle.new(30.0, 0.0, 20.0, 20.0)
      subject.collided?(t, r).should be_false
    end

    it 'collided rectangle in' do
      t = GeometryForm::Triangle.new(0.0, 0.0, 50.0, 50.0, :right)
      r = GeometryForm::Rectangle.new(20.0, 20.0, 20.0, 20.0)
      subject.collided?(t, r).should be_true
    end
  end
end
