Gem::Specification.new do |s|
  s.name = 'rubocop-nri'
  s.version = '1.0.0'
  s.date = '2017-07-20'
  s.summary = 'Cops we use'
  s.description = 'Cops we use'
  s.authors = ['Hardy Jones']
  s.email = 'engineering@noredink.com'
  s.require_paths = ['lib']
  s.homepage = 'https://github.com/NoRedInk/cops'
  s.license = 'MIT'

  s.add_runtime_dependency 'rubocop', '~> 0.49'

  s.add_development_dependency 'byebug'
end
