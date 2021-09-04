module Velocity
  class Role
    attr_accessor :id, :name, :description, :system, :readonly

    def initialize(id:, name:, description:, system:, readonly:)
      @id = id
      @name = name
      @description = description
      @system = system
      @readonly = readonly
    end

    def self.where(args)
      perform_request(args).map do |role|
        new(
          id: role["id"],
          name: role["attributes"]["name"],
          description: role["attributes"]["description"],
          system: role["attributes"]["system"],
          readonly: role["attributes"]["readonly"]
        )
      end
    end

    def self.find_by(args)
      where(args).first
    end

    def self.perform_request(args = {})
      Velocity::Api::Role.new(args).fetch
    end
  end
end
