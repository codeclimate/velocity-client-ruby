module Velocity
  module Api
    class People < Velocity::Api::Base
      def fetch
        parse_response(self.class.get("/people", options.merge(query: build_query)))
      end
    end
  end
end
