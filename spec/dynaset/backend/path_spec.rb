require 'dynaset/backend/basic'
require 'dynaset/backend/path'

describe Dynamic::Backend::PathBackend do

  it 'is inherited from BasicBackend' do
    expect(described_class.ancestors).to be_include Dynamic::Backend::BasicBackend
  end

  context 'PathBackend instance' do
    subject { Dynamic::Backend::PathBackend.new }

    after :each do
      # TODO: cleanup the file
    end

    it { should_not be nil }
    it { should be_kind_of Dynamic::Backend::PathBackend }

    it 'should be able set & get settings with value' do

    end

  end
end
