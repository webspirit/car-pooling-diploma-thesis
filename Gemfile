source 'https://rubygems.org'

gem 'rails'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'passenger'
gem 'devise'
gem 'therubyracer' # compiles assets in production mode
#gem 'capistrano'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'#,   '~> 3.2.3'
  gem 'coffee-rails'#, '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier'#, '>= 1.0.3'
end

gem "letter_opener", :group => :development
gem 'jquery-rails'
gem 'hirb'

group :test, :development do
  gem 'capistrano'
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem "rspec-rails"
  gem "shoulda-matchers"
  # gem 'spork', "> 0.9.0.rc"
  gem "spork"
  gem "guard-spork"
  gem "launchy"
  gem "pry-remote"
  gem "pry-rails"
  gem "rb-fsevent"
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
