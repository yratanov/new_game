require 'level_object/mixin/state'

shared_examples 'creature with states' do |*states|
  it { expect(described_class).to respond_to(:states) }

  states.each do |state|
    context 'state!' do
      before do
        subject.state = 'some state'
        subject.send("#{state}!")
      end

      its(:state) { should == state }
    end

    context 'state?' do
      context 'true' do
        before do
          subject.state = state
        end

        its("#{state}?") { should be_true }
      end

      context 'false' do
        before do
          subject.state = 'other'
        end

        its("#{state}?") { should be_false }
      end
    end
  end
end
