require 'level_object/mixin/jumper'

shared_examples 'jumper' do
  before do
    described_class.jump_power = 10
  end

  it { should respond_to :jump_power }

  context '#jump_power' do
    its(:jump_power) { should == 10 }
  end

  context '#jump' do
    context 'on ground' do
      before do
        subject.on_ground = false
      end

      it 'should not change velocity' do
        expect { subject.jump }.not_to change(subject, :vel_y)
      end
    end

    context 'not on ground' do
      before do
        subject.on_ground = true
      end

      it 'should not change velocity' do
        expect { subject.jump }.to change(subject, :vel_y).by(-10)
      end
    end
  end
end
