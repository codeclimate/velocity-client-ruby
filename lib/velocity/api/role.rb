module Velocity
  module Api
    class Role < Velocity::Api::Base
      def fetch
        parse_response(self.class.get("/roles", options.merge(query: build_query)))
      end
    end
  end
end
