module Velocity
  module Api
    class Invite < Velocity::Api::Base
      def send
        parse_response(self.class.post("/invitations", options.merge(body)))
      end

      def body
        {
          body: {
            data: {
              type: "invitations",
              attributes: attributes,
              relationships: relationships
            }
          }.to_json
        }
      end

      def attributes
        {
          name: args.fetch(:name),
          email: args.fetch(:email),
          jobFunction: args.fetch(:job_function)
        }
      end

      def relationships
        {
          roles: {
            data: args.fetch(:role_ids).map do |role_id|
              {
                type: "roles",
                id: role_id
              }
            end
          }
        }
      end
    end
  end
end
