module Velocity
  class Contributor
    attr_accessor :id, :name, :email

    def initialize(id:, email:, name:)
      @id = id
      @email = email
      @name = name
    end

    def self.where(args)
      perform_request(args).map do |contributor|
        new(id: contributor["id"], name: contributor["attributes"]["name"], email: contributor["attributes"]["email"])
      end
    end

    def self.find_by(args)
      where(args).first
    end

    def self.perform_request(args = {})
      Velocity::Api::People.new(args).fetch
    end
  end
end
