module Dynamic
  module Manager
    class SettingsManager

      #
      # Runtime error if there were no handler to be
      # registered.
      #
      class NoHandlerError < RuntimeError
      end

      class << self
        #
        # Get current namespace.
        #
        def namespace
          NAMESPACE
        end

        #
        # Get current client pool
        #
        def backend
          BACKEND
        end

        #
        # Configure the settings manager
        #
        def configure(options)
          # TODO : pass the options into backend initialize
          # options ||= { namespace: 'plugins.', host: '127.0.0.1', timeout: 1, size: 10 }
          # options.keep_if {|key| [:timeout, :host, :size].include? key }
          # Backend = ConnectionPool.new(options) do
          #   Redis.new(options[:host])
          # end

          const_set :NAMESPACE, options[:namespace]
          const_set :BACKEND, Backend
          const_set :LISTENERS, {}

          Kernel.at_exit do
            const_set :INSTANCE, nil
            const_set :BACKEND, nil
            const_set :NAMESPACE, nil
          end
        end

        def set!(key, value)
          backend.set!(key, value)
        end

        def get!(key)
          backend.get!(key)
        end

        #
        # Register handler into listeners. (as a Plugin)
        #
        def register(handler)
          LISTENERS[handler.namespace] = handler
        end

        #
        # Listen namespace as a block
        #
        def listen(namespace, &block)
          if Kernel.block_given?
            LISTENERS[namespace] = block
          else
            throw NoHandlerError
          end
        end

        private
        def watch
          backend.watch do |event, message|
            handler = LISTENERS[event]
            case handler
            when Hook::Handler then handler.on_changed(event, message)
            when Proc || Lambda then handler.call(event, message)
            else throw NotImplementedError
            end
          end
        end
      end
    end
  end
end
