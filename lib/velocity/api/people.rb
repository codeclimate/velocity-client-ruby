module Velocity
  module Api
    class People < Velocity::Api::Base
      def fetch
        get("/people")
      end

      def update
        put("/people/#{args.fetch(:id)}", body)
      end

      private

      def body
        {
          body: {
            data: {
              id: args.fetch(:id),
              type: "people",
              relationships: relationships
            }
          }.to_json
        }
      end

      def relationships
        {
          teams: {
            data: args.fetch(:team_ids).map do |team_id|
              {
                type: "teams",
                id: team_id
              }
            end
          }
        }
      end
    end
  end
end
