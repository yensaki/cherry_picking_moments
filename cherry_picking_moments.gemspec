lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cherry_picking_moments/version"

Gem::Specification.new do |spec|
  spec.name          = "cherry_picking_moments"
  spec.version       = CherryPickingMoments::VERSION
  spec.authors       = ["yensaki"]
  spec.email         = ["mov.an.double@gmail.com"]

  spec.summary       = %q{Generate uniquish images from a movie}
  spec.description   = %q{Generate uniquish images from a movie}
  spec.homepage      = "https://github.com/yensaki/cherry_picking_moments"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "pycall", "1.2.1"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug"
end
