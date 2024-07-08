# frozen_string_literal: true

require_relative "lib/omniauth-threads-api/version"

Gem::Specification.new do |spec|
  spec.name = "omniauth-threads-api"
  spec.version = OmniAuth::ThreadsAPI::VERSION
  spec.authors = ["Giacomo Guiulfo Knell"]
  spec.email = ["giaco@hey.com"]

  spec.summary = "OmniAuth strategy for the Threads API"
  spec.description = "OmniAuth strategy for the Threads API"
  spec.homepage = "https://github.com/giacomoguiulfo/omniauth-threads-api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "oauth2", "~> 2.0"
  spec.add_dependency "omniauth", "~> 2.0"
  spec.add_dependency "omniauth-oauth2", "~> 1.8"
end
