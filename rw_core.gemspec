$:.push File.expand_path("../lib", __FILE__)
require 'rw/core/version'

Gem::Specification.new do |s|
  s.name = 'rw_core' #	Rename	core	to	rw_core
  s.version = Rw::Core::VERSION #	Add	namespace
  s.authors = ['Abolfazl Mahmoodi']
  s.email = ['rubywebit@gmail.com']
  s.homepage = 'http://rubywebit.com'
  s.summary = 'Core	features	of	rubywebit.'
  s.description = 'Core	features	of	rubywebit.'
  s.license = 'MIT'
  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['']
  s.add_dependency 'rails', '5.1.5'
  s.add_development_dependency 'pg'

  s.add_dependency	'sass-rails', '~>	5.0'
  s.add_dependency	'bootstrap-sass', '~>	3.3.3'
  s.add_dependency	'autoprefixer-rails', '~>	6.4'

  s.add_dependency  'turbolinks', '~> 5'
  s.add_dependency  'jquery-turbolinks'

  s.add_dependency 'sorcery'
  s.add_dependency 'validates_email_format_of'

  s.add_dependency 'simple_form'
  s.add_dependency 'reform'
  s.add_dependency 'interactor'
  #
  s.add_dependency 'jquery-datatables-rails', '~> 3.3.0'
  s.add_dependency 'will_paginate'
  s.add_dependency 'will_paginate-bootstrap'
  #
  # s.add_dependency 'jquery-fileupload-rails'
  s.add_dependency 'parsi-date'
  s.add_dependency 'rack-cache'
  s.add_dependency 'carrierwave', '~> 1.0'
  s.add_dependency 'pdfkit'
  s.add_dependency 'wkhtmltopdf-binary'
  s.add_dependency 'rest-client'
  s.add_dependency 'roo', '~> 2.8.0'
  s.add_dependency 'remotipart', '~> 1.2'
  s.add_dependency 'httparty'
  s.add_dependency 'sucker_punch', '~> 2.0'
end
