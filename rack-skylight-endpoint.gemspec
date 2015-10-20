# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "rack-skylight-endpoint"
  spec.version       = '1.0.0'
  spec.authors       = ["Eduard Litau"]
  spec.email         = ["eduard.litau@gmail.com"]

  spec.summary       = %q{Custom skylight endpoints for specific paths}
  spec.description   = %q{Rack middleware to set custom skylight.io endpoints for specific paths.}
  spec.homepage      = "http://github.com/elitau/rack-skylight-endpoint"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "skylight", "~> 0.8"
  spec.add_dependency "rack",     "~> 1.6"
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "rake", "~> 10.0"
end
