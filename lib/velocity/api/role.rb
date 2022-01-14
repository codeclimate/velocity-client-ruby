module Velocity
  module Api
    class Role < Velocity::Api::Base
      def fetch
        get("/roles")
      end
    end
  end
end
