require 'httparty'

module Velocity
  class Api
    class NotFoundError < StandardError; end
    class UnauthorizedError < StandardError; end
    class InternalServerError < StandardError; end
    class BadRequestError < StandardError; end

    include HTTParty

    base_uri "https://api.velocity.codeclimate.com/v1"

    def initialize
      @options = {
        headers: {
          authorization: "Bearer #{Velocity.configuration.api_token}"
        }
      }
    end

    def fetch_contributors(args)
      parse_response(self.class.get("/people", @options.merge({
        query: build_query_attributes(args)
      })))
    end

    def parse_response(response)
      case response.code
        when 200
          JSON.parse(response.body)["data"]
        when 400
          errors = JSON.parse(response.body)["errors"]
          raise BadRequestError.new(errors.first["title"] + ": " + errors.first["detail"])
        when 401
          raise UnauthorizedError.new("401 Unauthorized");
        when 404
          raise NotFoundError.new("404 not found error");
        else
          raise InternalServerError.new("#{response.code} something went wrong: #{response.body}")
      end
    end

    def build_query_attributes(args)
      args.map do |key, value|
        "filter[#{key.to_s}][eq]=#{value}"
      end.join("&")
    end
  end
end