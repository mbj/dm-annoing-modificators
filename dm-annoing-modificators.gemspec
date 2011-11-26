# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dm-annoing-modificators/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'dm-annoing-modificators'
  s.version = DataMapper::AnnoingModificators::VERSION

  s.authors  = ['Markus Schirp']
  s.email    = 'piotr.solnica@gmail.com'
  s.date     = '2011-11-16'
  s.summary  = 'Provides DataMapper::{Model.,Resource#}{create,first_or_create,update}_or_raise'
  s.homepage = 'http://github.com/mbj/dm-annoing-modificators'

  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths    = %w(lib)
  s.extra_rdoc_files = %w(LICENSE README.rdoc)

  s.rubygems_version = '1.8.10'

  s.add_runtime_dependency(%q<dm-core>,               ['~> 1.3.0.beta'])
  s.add_development_dependency(%q<dm-validations>,    ['~> 1.3.0.beta'])
  s.add_development_dependency(%q<dm-migrations>,     ['~> 1.3.0.beta'])
  s.add_development_dependency(%q<dm-sqlite-adapter>, ['~> 1.3.0.beta'])
  s.add_development_dependency(%q<dm-do-adapter>,     ['~> 1.3.0.beta'])

  s.add_development_dependency(%q<rake>,      ['~> 0.8.7'])
  s.add_development_dependency(%q<rspec>,     ['~> 2.7'])
end
