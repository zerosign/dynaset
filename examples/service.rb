require 'sinatra/base'
require 'sinatra/json'
require 'dynaset'
require 'dynaset/backend/redis'
require 'concurrent/tvar'

# configure the settings manager singleton
Dynamic::Manager::SettingsManager.configure(
  namespace: 'plugin',
  backend: Dynamic::Backend::RedisBackend.new(
    'counter',
    host: '127.0.0.1',
    timeout: 1,
    size: 100
  )
)

class CounterSettings < Dynamic::Hook::Settings

  def timeout
    self.get!(:timeout)
  end

  def timeout=(value)
    self.set!(:timeout, value.to_i)
  end
end

settings = Concurrent::TVar.new(CounterSettings.new('counter',
                                                    timeout: 100,
                                                    updated_at: Time.now.to_i))

class SimpleService < Sinatra::Base

  enable :sessions

  post '/set' do
    Concurrent::atomically do
      settings.value[:timeout] = (params[:timeout] || 10).seconds
    end
  end

  get '/' do
    value = Concurrent::atomically do
      settings.value[:timeout]
    end
    json(timeout: value)
  end

  run! if app_file == $0
end
