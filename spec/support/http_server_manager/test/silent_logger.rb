module HttpServerManager
  module Test

    class SilentLogger

      def self.method_missing(*args)
        # Intentionally blank
      end

    end

  end
end
