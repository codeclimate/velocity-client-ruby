require 'httparty'

module Velocity
  class Api
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
        response = self.class.get("/people", @options.merge({
          query: build_query_attributes(args)
        }))
      case response.code
        when 200
          JSON.parse(response.body)
        when 404
          raise "not found"
        when 500...600
          raise "error"
        else
          errors = JSON.parse(response.body)["errors"]
          raise errors.first["title"]
      end
    end

    def build_query_attributes(args)
      args.map do |key, value|
        "filter[#{key.to_s}][eq]=#{value}"
      end.join("&")
    end
  end
end