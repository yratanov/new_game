require 'level_object/mixin/view'

shared_examples 'creature with view' do |view_class|
  it { expect(described_class).to respond_to :view }
  it { expect(described_class.view_class).to eq view_class }
end
