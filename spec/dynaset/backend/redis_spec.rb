require 'dynaset/backend/basic'
require 'dynaset/backend/redis'

describe Dynamic::Backend::RedisBackend do

  it 'is inherited from BasicBackend' do
    expect(described_class.ancestors).to be_include Dynamic::Backend::BasicBackend
  end

  context 'RedisBackend instance' do
    subject { Dynamic::Backend::RedisBackend::new }

    after(:each) do
      client = Redis.new
      client.expire "plugins.flumine.settings", 0
      client.expire "journal.plugins.flumine.settings", 0
    end

    it { should_not be nil }
    it { should be_kind_of Dynamic::Backend::RedisBackend }

    it 'should be able set & get settings with value' do
      state = { state: false }
      subject.set!("flumine.settings", state)
      expect(subject.get!("flumine.settings")).to include(state)
    end

    it 'should be able to watch settings changes' do
      state = { state: false }

      thread = Thread.new do
        subject.watch do |event, message|
          expect(event).to include('plugins.flumine.settings')
          expect(JSON.parse(message, symbolize_names: true)).to include(state)
          Thread.kill(Thread.current)
        end
      end

      sleep 2
      subject.set!("flumine.settings", state)
      thread.join
    end
  end
end
