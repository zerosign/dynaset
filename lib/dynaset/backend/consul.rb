require 'diplomat'

module Dynamic
  module Backend
    class ConsulBackend < BasicBackend

      class ConsulJournal < BasicBackend::Journal

        def set!(instance, key)
        end

        def get!(instance, key)
        end

      end

      def initialize(namespace='plugins', options={})

      end
    end
  end
end
