require "bundler/setup"
require "velocity"
require "vcr"
require "webmock/rspec"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) { set_api_token }
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<TOKEN>") { ENV["VELOCITY_API_TOKEN"] }
  config.configure_rspec_metadata!
end

def set_api_token
  Velocity.configure do |config|
    config.api_token = ENV["VELOCITY_API_TOKEN"]
  end
end
