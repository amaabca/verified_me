require_relative 'lib/verified_me/version'

Gem::Specification.new do |spec|
  spec.name = 'verified_me'
  spec.version = VerifiedMe::VERSION
  spec.authors = [
    'Jesse Doyle',
    'Michael van den Beuken',
    'Darko Dosenovic',
    'Zoie Carnegie'
  ]
  spec.email = [
    'jesse.doyle@ama.ab.ca',
    'michael.vandenbeuken@ama.ab.ca',
    'darko.dosenovic@ama.ab.ca',
    'zoie.carnegie@ama.ab.ca'
  ]

  spec.summary = %q{Integration with the Verified.Me API}
  spec.description = %q{API wrappers for the Verified.Me service}
  spec.homepage = 'https://github.com/amaabca/verified_me'
  spec.license = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rest-client', '>= 2.0.0'
  spec.add_dependency 'rest-client-jogger', '>= 0.3'
  spec.add_dependency 'shrink_wrap'
end
