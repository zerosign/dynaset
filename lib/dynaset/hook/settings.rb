module Dynamic
  module Hook


    class Settings

      attr_reader :namespace

      #
      # Intialize the Settings with default data.
      #
      def initialize(namespace, data={})
        @namespace = namespace
        if data.empty?
          @data = Hash.new(MessagePack.unpack(SettingsManager.get!(namespace)))
        else
          @data = resolve(data, SettingsManager.get!(namespace))
          SettingsManager.set!(namespace, MessagePack.pack(data))
        end
      end

      #
      # Accessor method for field in Settings.
      # Warning: We use symbols as key in the Hash object.
      #
      def get!(key)
        if @data.empty?
          @data = resolve(data, SettingsManager.get!(namespace))
          SettingsManager.set!(namespace, MessagePack.pack(data))
        else
          MessagePack.unpack(@data)[key.to_sym]
        end
      end

      #
      # Mutator method for field in Settings.
      # Warning: We use symbols as key in the Hash object.
      #
      def set!(key, value)
        @data[key.to_sym] = value
      end

      #
      # Resolve conflicts between local and remote data.
      # Use always the most last updated_at.
      #
      private
      def resolve(left, right)
        case right
        when nil then left
        else
          if left[:updated_at] && right[:updated_at] &&
             left[:updated_at] < right[:updated_at]
            right
          else
            left
          end
        end
      end
    end
  end
end
