require 'spec_helper'
require 'geometry_form/triangle_direction/left'

describe GeometryForm::TriangleDirection::Left do
  subject { described_class.new(triangle) }

  let(:triangle) { double(left: 0.0, right: 10.0, bottom: 10.0, top: 0.0) }

  context '#dot_inside?' do
    it { expect(subject).not_to be_dot_inside(0, 0) }
    it { expect(subject).to be_dot_inside(10, 10) }
    it { expect(subject).to be_dot_inside(0, 10) }
    it { expect(subject).to be_dot_inside(5, 5) }
    it { expect(subject).to be_dot_inside(9, 9) }
    it { expect(subject).to be_dot_inside(10, 5) }
    it { expect(subject).not_to be_dot_inside(2, 1) }
  end

  context '#x_at' do
    it { expect(subject.x_at(-2)).to eq 10 }
    it { expect(subject.x_at(2)).to eq 8 }
    it { expect(subject.x_at(5)).to eq 5 }
    it { expect(subject.x_at(10)).to eq 0 }
    it { expect(subject.x_at(15)).to eq 0 }
  end

  context '#y_at' do
    it { expect(subject.y_at(-2)).to eq 10 }
    it { expect(subject.y_at(2)).to eq 8 }
    it { expect(subject.y_at(5)).to eq 5 }
    it { expect(subject.y_at(10)).to eq 0 }
    it { expect(subject.y_at(15)).to eq 0 }
  end
end
