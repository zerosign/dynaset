require 'rb-inotify'
require 'yaml'
require 'dynaset/backend/basic'

module Dynamic
  module Backend
    class PathBackend < BasicBackend
      def initialize(namespace='plugins', path='config/', options={})
        @instance = INotify::Notifier.new
        @namespace = namespace
        @path = path
      end

      def set!(key, value)
        path = "#{@namespace}/#{key}.yml"
        value = value.to_yaml
        # write to the file
        File.open(path, 'w') do |handle|
          handle.write(value)
        end
      end

      def get!(key)
        path = "#{@namespace}/#{key}.yml"
        # read data from the file
        YAML.load_file(path)
      end

      def journal
        # return the journal handler
      end

      def watch(&block)
        @instance.watch(path, :modify) do |event|
          # propagate the event to listener
          path = event.absolute_name
          if path[/\.yml$/]
            data = YAML.load_file(path)
            namespace = File.basename(path).gsub('.yml', '')
            block.call(namespace, data)
          end
        end
      end
    end
  end
end
