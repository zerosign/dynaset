module Dynamic
  module Hook
    #
    # Class that can be handler class
    #
    class Handler
      attr_accessor :namespace

      #
      # Callback on changed settings.
      # This callback need to be implemented so that
      # runtime 'plugin' like could be achieved.
      #
      def on_changed(settings)
        throw NotImplementedError
      end
    end
  end
end
