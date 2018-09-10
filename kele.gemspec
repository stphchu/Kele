Gem::Specification.new do |s|
   s.name          = 'kele'
   s.version       = '0.0.1'
   s.date          = '2018-09-07'
   s.summary       = 'Kele API Client'
   s.description   = 'A client for the Bloc API'
   s.authors       = ['Stephanie Chu']
   s.email         = 'schu@mail.ccsf.edu'
   s.files         = ['lib/kele.rb']
   s.require_paths = ["lib"]
   s.homepage      =
     'http://rubygems.org/gems/kele'
   s.license       = 'MIT'
   s.add_runtime_dependency 'httparty', '~> 0.13'
end
