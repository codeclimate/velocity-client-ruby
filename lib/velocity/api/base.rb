require "httparty"

module Velocity
  module Api
    class Base
      class NotFoundError < StandardError; end
      class UnauthorizedError < StandardError; end
      class InternalServerError < StandardError; end
      class BadRequestError < StandardError; end

      include HTTParty

      base_uri "https://api.velocity.codeclimate.com/v1"

      attr_accessor :args

      def initialize(args)
        @args = args
      end

      def options
        {
          headers: {
            "Authorization" => "Bearer #{Velocity.configuration.api_token}",
            "Content-Type" => "application/vnd.api+json",
          }
        }
      end

      def parse_response(response)
        case response.code
          when 200..201
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

      def build_query
        args.map do |key, value|
          "filter[#{key.to_s}][#{operation(key)}]=#{value}"
        end.join("&") + "&page[size]=100"
      end

      def operation(key)
        case key.to_sym
        when :id
          "eq"
        else
          "contains"
        end
      end
    end
  end
end
