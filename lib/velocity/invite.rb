module Velocity
  class Invite
    attr_accessor :id, :name, :email, :job_function

    def initialize(id:, email:, name:, job_function:)
      @id = id
      @email = email
      @name = name
      @job_function = job_function
    end

    def self.create(args)
      response = perform_request(args)
      new(
        id: response["id"],
        name: response["attributes"]["name"],
        email: response["attributes"]["email"],
        job_function: response["attributes"]["job_function"]
      )
    end

    def self.perform_request(args = {})
      Velocity::Api::Invite.new(args).send
    end
  end
end
