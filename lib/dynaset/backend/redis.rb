require 'redis'
require 'connection_pool'
require 'json'
require 'dynaset/backend/basic'

module Dynamic
  module Backend
    class RedisBackend < BasicBackend

      #
      # Journal implementation in Redis.
      # We will use different namespace for the journal.
      #
      class RedisJournal < BasicBackend::Journal
        def set!(instance, key)
          instance.set "journal.#{key}", Time.now.to_i
        end

        def get!(instance, key)
          instance.get "journal.#{key}"
        end
      end

      def initialize(namespace='plugins', options={})
        options ||= { namespace: 'plugins', host: '127.0.0.1', timeout: 1, size: 10 }

        @instance = ConnectionPool.new(options.select {|k, v| [:timeout, :size].include? k }) do
          Redis.new(options.select{|k, v| [:host].include? k})
        end

        @namespace = namespace
        @journal = RedisJournal.new
      end

      def set!(key, value)
        key = "#{@namespace}.#{key}"
        value = value.to_json
        @instance.with do |client|
          client.pipelined do |pipe|
            pipe.publish key, value
            pipe.set key, value
            @journal.set! pipe, key
          end
        end
      end

      def get!(key)
        key = "#{@namespace}.#{key}"
        data = @instance.with do |client|
          client.get key
        end
        JSON.parse(data, symbolize_names: true)
      end

      def journal
        @journal
      end

      def watch(&block)
        @instance.with do |client|
          client.psubscribe "#{@namespace}.*" do |listener|
            listener.pmessage do |channel, event, message|
              block.call(event, message)
            end
          end
        end
      end
    end
  end
end
