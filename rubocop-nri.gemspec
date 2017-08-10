# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'rubocop-nri'
  s.version = '2.0.1'
  s.date = '2017-07-20'
  s.summary = 'Cops we use internally at NoRedInk'
  s.description = 'Cops we use internally at NoRedInk'
  s.authors = ['Hardy Jones']
  s.email = 'engineering@noredink.com'
  s.require_paths = ['lib']
  s.files = Dir['lib/**/*']
  s.homepage = 'https://github.com/NoRedInk/cops'
  s.license = 'MIT'

  s.add_runtime_dependency 'rubocop', '~> 0.49'

  s.add_development_dependency 'byebug', '~> 9.0'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'rubocop-rspec', '~> 1.15'
end
