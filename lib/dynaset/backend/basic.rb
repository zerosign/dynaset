module Dynamic
  module Backend
    #
    # Basic backend for dealing with the IO
    # directly. You should implement this
    # directly if you want to add more support
    # for another database.
    #
    class BasicBackend

      #
      # Journal handler for set/get the timestamp
      # based on the backend.
      #
      class Journal
        def set!(instance, key)
          throw NotImplementedError
        end

        def get!(instance, key)
          throw NotImplementedError
        end
      end

      #
      # Set the key with value value
      #
      def set!(key, value)
        throw NotImplementedError
      end

      #
      # Accessor for the journal instance implementation.
      #
      def journal
        throw NotImplementedError
      end

      #
      # Get the key and return a value.
      #
      def get!(key)
        throw NotImplementedError
      end

      #
      # Method to watch over a key.
      #
      def watch(&block)
        throw NotImplementedError
      end
    end
  end
end
