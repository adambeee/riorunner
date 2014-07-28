source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc


# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails' #It is also recommended to use Autoprefixer with Bootstrap to add browser vendor prefixes automatically.
gem 'devise'
gem 'protected_attributes'
#gem 'bootstrap_tokenfield_rails'
#gem 'haml'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-linkedin'
gem 'will_paginate', '~> 3.0' ## Gemfile for Rails 3, Rails 4, Sinatra, and Merb
#gem 'sunspot_rails'
#gem 'font-awesome-rails'
#gem 'jquery-turbolinks'
gem 'acts-as-taggable-on'
gem 'paperclip'
gem 'aws-sdk'
gem 'simple_form'

group :development, :test do
# Use mysql as the database for Active Record
  #gem 'rspec-rails', '~> 2.14.0.rc1'
  #gem 'guard-rspec', '2.5.0'
  #gem 'annotate', '2.4.0'
  #gem 'factory_girl_rails', '4.2.1'
  #gem 'sunspot_solr'
  #gem 'quiet_assets'
  #gem 'rails_layout'
  #gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'mailcatcher'
  gem 'spring' # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
# This gem allows me to simulate a user's interaction with this app using a natural English-like syntax together with selenium....
# which is one of capybara's dependencies.
  gem 'capybara', '2.1.0'
  gem 'webrat', '0.7.3'
  gem 'spork-rails', '4.0.0'
  gem 'guard-spork', '1.5.0'
end
group :production do
  # gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end
