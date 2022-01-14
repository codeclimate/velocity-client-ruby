module Velocity
  module Api
    class Team < Velocity::Api::Base
      def fetch
        get("/teams")
      end
    end
  end
end
