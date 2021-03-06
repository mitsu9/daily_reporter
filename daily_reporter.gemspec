# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'daily_reporter/version'

Gem::Specification.new do |spec|
  spec.name          = "daily_reporter"
  spec.version       = DailyReporter::VERSION
  spec.authors       = ["mitsu9"]
  spec.email         = ["mitsunobu.h.9@gmail.com"]

  spec.summary       = %q{daily_reporter creates a daily report.}
  spec.description   = %q{daily_reporter creates a daily report}
  spec.homepage      = "https://github.com/mitsu9/daily_reporter"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "dotenv"

  spec.add_development_dependency 'bundler', '~> 1.17.2'
  spec.add_development_dependency 'rake', '~> 11.2'
  spec.add_development_dependency 'rspec', '~> 3.9'
end
