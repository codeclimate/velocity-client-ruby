module Velocity
  module Api
    class Team < Velocity::Api::Base
      def fetch
        parse_response(self.class.get("/teams", options.merge(query: build_query)))
      end
    end
  end
end
