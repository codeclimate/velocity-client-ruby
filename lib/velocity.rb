require "velocity/api/base"
require "velocity/api/people"
require "velocity/api/invite"
require "velocity/contributor"
require "velocity/invite"
require "dotenv/load"

module Velocity
  class << self
    attr_accessor :configuration

    def configure
      @configuration ||= Configuration.new
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

  class Configuration
    attr_accessor :api_token

    def api_token
      @api_token || ENV["VELOCITY_API_TOKEN"]
    end
  end
end
