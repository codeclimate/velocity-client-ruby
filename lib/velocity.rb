require "velocity/api"
require "velocity/contributor"
module Velocity
  class << self
    attr_accessor :configuration

    def configure
      @configuration ||= Configuration.new
      yield(configuration)
    end
  end

  class Configuration
    attr_accessor :api_token
  end
end
