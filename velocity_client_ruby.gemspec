
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "velocity/version"

Gem::Specification.new do |spec|
  spec.name          = "velocity_client_ruby"
  spec.version       = Velocity::VERSION
  spec.authors       = ["Victor Antoniazzi", "Vera Protopopova"]
  spec.email         = ["vgsantoniazzi@gmail.com", "vera.protopopova@gmail.com"]

  spec.summary       = %q{Ruby Gem to interact with Velocity Teams API}
  spec.description   = %q{Interact with Velocity Teams API}
  spec.homepage      = "http://velocity.codeclimate.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/codeclimate/velocity-client-ruby"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency  "httparty", "~> 0.18"
end
